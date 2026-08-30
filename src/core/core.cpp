#include "core.h"
#include "../log.h"
#include "errors.h"

#include <QDate>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QPointer>
#include <QSaveFile>
#include <QSet>
#include <QSettings>
#include <QStandardPaths>
#include <QThread>
#include <QUuid>
#include <QString>

constexpr const char* dbDateFormat = "yyyy-MM-dd";
constexpr const char* displayDateFormat = "dd-MM-yyyy";
constexpr const char* randomizerConfigFileName = "randomizer.json";
constexpr const char* defaultProfileSettingsKey = "preferences/default_profile_id";

namespace {
QString randomizerConfigPath() {
    const QString storagePath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if (storagePath.isEmpty()) {
        return {};
    }
    return QDir(storagePath).filePath(randomizerConfigFileName);
}

bool enabledItemsToJson(const QVariantList& items, QJsonObject& result) {
    for (const QVariant& item : items) {
        const QVariantMap itemMap = item.toMap();
        bool idOk = false;
        const quint64 id = itemMap.value("id").toULongLong(&idOk);
        if (!idOk || id == 0 || !itemMap.contains("enabled")) {
            return false;
        }
        result.insert(QString::number(id), itemMap.value("enabled").toBool());
    }
    return true;
}

bool isEnabledItemsJson(const QJsonObject& items) {
    for (auto it = items.constBegin(); it != items.constEnd(); ++it) {
        bool idOk = false;
        const quint64 id = it.key().toULongLong(&idOk);
        if (!idOk || id == 0 || !it.value().isBool()) {
            return false;
        }
    }
    return true;
}

QString filesrc2str(FileSource src) {
    switch (src)
    {
    case FileSource::Cache:
        return "cache";
    case FileSource::Http:
        return "http";
    default:
        return "unknown";
    }
}
} // namespace

Core::Core(const Logger& logger, Database& db, DbExporter& dbExporter, FileProvider* fp)
    : db_(db),
      dbExporter_(dbExporter),
      provider_(fp),
      logger_(logger),
      QObject(nullptr) {};

static QVariantList mapHeroesQml(const QVector<models::Hero>& heroes) {
    QVariantList list;
    for (const auto& h : heroes) {
        QVariantMap obj;
        obj["id"] = h.id;
        obj["name"] = std::move(h.name);
        obj["hp"] = h.hp;
        obj["move"] = h.move;
        obj["img_path"] = std::move(h.imgPath);
        obj["set_id"] = h.setId;
        obj["ability"] = h.ability;
        obj["attack_type"] = h.attackType;

        QVariantList assistants;
        for (const auto& assistant : h.assistants) {
            QVariantMap assistantObj;
            assistantObj["id"] = assistant.id;
            assistantObj["name"] = assistant.name;
            assistantObj["count"] = assistant.count;
            assistantObj["hp_per_one"] = assistant.hpPerOne;
            assistantObj["attack_type"] = assistant.attackType;
            assistants.append(std::move(assistantObj));
        }
        obj["assistants"] = assistants;

        list.append(std::move(obj));
    }
    return list;
}

static QString displayDateFromDb(const QVariant& value) {
    const QString dateText = value.toString().trimmed();
    if (dateText.isEmpty()) {
        return {};
    }

    const QDate dbDate = QDate::fromString(dateText, dbDateFormat);
    if (dbDate.isValid()) {
        return dbDate.toString(displayDateFormat);
    }

    const QDate displayDate = QDate::fromString(dateText, displayDateFormat);
    if (displayDate.isValid()) {
        return dateText;
    }

    return dateText;
}

static QString dbDateFromDisplay(const QString& value) {
    const QString dateText = value.trimmed();
    if (dateText.isEmpty()) {
        return {};
    }

    const QDate date = QDate::fromString(dateText, displayDateFormat);
    return date.isValid() ? date.toString(dbDateFormat) : QString();
}

static bool gameModeSpec(const QString& mode, int& playerCount, int& teamCount) {
    if (mode == "1v1") {
        playerCount = 2;
        teamCount = 2;
    } else if (mode == "1v1v1") {
        playerCount = 3;
        teamCount = 3;
    } else if (mode == "1v1v1v1") {
        playerCount = 4;
        teamCount = 4;
    } else if (mode == "2v2") {
        playerCount = 4;
        teamCount = 2;
    } else {
        return false;
    }
    return true;
}

QVariantList Core::getHeroes() const {
    const char op[] = "Core::getHeroes";

    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroes(heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.debug(op, "heroes got from db");

    return mapHeroesQml(heroes);
}

QVariantList Core::getHeroesBySetId(quint64 setId) const {
    const char op[] = "Core::getHeroesBySetId";

    logger_.info(op, "getting heroes by set id");
    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroesBySetId(setId, heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.info(op, "heroes by set id got successfully");

    return mapHeroesQml(heroes);
}

QVariantList Core::getMaps() const {
    const char op[] = "Core::getMaps";

    QVector<models::GameMap> maps;
    Rc rc = db_.getMaps(maps);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.debug(op, "heroes got from db");

    QVariantList list;
    for (const auto& m : maps) {
        QVariantMap obj;
        obj["id"] = m.id;
        obj["name"] = std::move(m.name);
        obj["img_path"] = std::move(m.imgPath);
        obj["set_id"] = m.setId;

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Core::getSets() const {
    const char op[] = "Core::getSets";

    QVector<models::GameSetShort> sets;
    Rc rc = db_.getSets(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.debug(op, "short sets got from db");

    QVariantList list;
    for (const auto& s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = std::move(s.name);
        obj["img_path"] = std::move(s.imgPath);

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Core::getSHM() const {
    const char op[] = "Core::getSHM";

    QVector<models::GameSet> sets;
    Rc rc = db_.getSHM(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.debug(op, "sets got from db");

    QVariantList list;
    for (const auto& s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = std::move(s.name);
        obj["img_path"] = std::move(s.imgPath);
        obj["released_at"] = std::move(s.releasedAt);

        QVariantList heroes;
        for (const auto& h : s.heroes) {
            QVariantMap hObj;
            hObj["id"] = h.id;
            hObj["hp"] = h.hp;
            hObj["move"] = h.move;
            hObj["name"] = std::move(h.name);
            hObj["img_path"] = std::move(h.imgPath);
            heroes.append(std::move(hObj));
        }
        obj["heroes"] = std::move(heroes);

        QVariantList maps;
        for (const auto& m : s.maps) {
            QVariantMap mObj;
            mObj["id"] = m.id;
            mObj["name"] = std::move(m.name);
            mObj["img_path"] = std::move(m.imgPath);
            maps.append(std::move(mObj));
        }
        obj["maps"] = std::move(maps);

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Core::getCardsByHeroId(quint64 heroId) const {
    const char op[] = "Core::getCardsByHeroId";

    QVector<models::Card> cards;
    Rc rc = db_.getCardsByHeroId(heroId, cards);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.debug(op, "cards by hero id got from db");

    QVariantList list;
    for (const auto& c : cards) {
        QVariantMap obj;
        obj["id"] = c.id;
        obj["name"] = c.name;
        obj["description"] = c.description;
        obj["count"] = c.count;
        obj["img_path"] = c.imgPath;
        obj["hero_id"] = c.heroId;
        obj["card_type_id"] = c.cardTypeId;
        list.append(obj);
    }
    return list;
}

QVariantList Core::getProfiles() const {
    const char op[] = "Core::getProfiles";

    QVector<models::PlayerProfile> profiles;
    Rc rc = db_.getProfiles(profiles);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    logger_.debug(op, "profiles got from db");

    QVariantList list;
    for (const auto& p : profiles) {
        QVariantMap obj;
        obj["id"] = p.id;
        obj["name"] = p.name;
        obj["created_at"] = p.createdAt;
        list.append(std::move(obj));
    }
    return list;
}

QVariantMap Core::getProfileStats(const QString& profileId, const QString& gameMode) const {
    const char op[] = "Core::getProfileStats";
    QVariantMap result{{"ok", false}, {"error", err::None}};

    const QString trimmedId = profileId.trimmed();
    if (trimmedId.isEmpty() || QUuid(trimmedId).isNull()) {
        logger_.warning(op, "invalid profile id", {{"profile_id", profileId}});
        result["error"] = err_profile::InvalidId;
        return result;
    }

    int playerCount = 0;
    int teamCount = 0;
    if (!gameModeSpec(gameMode, playerCount, teamCount)) {
        logger_.warning(op, "invalid game mode", {{"game_mode", gameMode}});
        result["error"] = err_game::InvalidData;
        return result;
    }

    models::ProfileStats stats;
    const Rc rc = db_.getProfileStats(trimmedId, gameMode, stats);
    if (rc == Rc::ErrNotFound) {
        result["error"] = err::NotFound;
        return result;
    }
    if (rc != Rc::Ok) {
        logger_.error(op, "error getting profile stats", rc2str(rc));
        result["error"] = err::DbError;
        return result;
    }

    result["games_played"] = stats.gamesPlayed;
    result["games_won"] = stats.gamesWon;
    result["win_percentage"] = stats.gamesPlayed > 0
                                   ? 100.0 * stats.gamesWon / stats.gamesPlayed
                                   : 0.0;
    result["average_winning_hp"] = stats.averageWinningHp;

    QVariantMap favoriteHero;
    if (stats.favoriteHeroId != 0) {
        favoriteHero["id"] = stats.favoriteHeroId;
        favoriteHero["name"] = stats.favoriteHeroName;
        favoriteHero["img_path"] = stats.favoriteHeroImgPath;
        favoriteHero["games_played"] = stats.favoriteHeroGames;
        favoriteHero["games_won"] = stats.favoriteHeroWins;
        favoriteHero["win_percentage"] = stats.favoriteHeroGames > 0
                                               ? 100.0 * stats.favoriteHeroWins /
                                                     stats.favoriteHeroGames
                                               : 0.0;
    }
    result["favorite_hero"] = favoriteHero;

    QVariantMap favoriteMap;
    if (stats.favoriteMapId != 0) {
        favoriteMap["id"] = stats.favoriteMapId;
        favoriteMap["name"] = stats.favoriteMapName;
        favoriteMap["img_path"] = stats.favoriteMapImgPath;
        favoriteMap["games_played"] = stats.favoriteMapGames;
    }
    result["favorite_map"] = favoriteMap;
    result["ok"] = true;
    return result;
}

QVariantMap Core::getProfileHeroStats(const quint64& id, const QString& gameMode) const {
    const char op[] = "Core::getHeroStats";
    QVariantMap result{{"ok", false}, {"error", err::None}};

    QString profileId = getDefaultProfileId();

    models::HeroStats stats;
    Rc rc = db_.getProfileHeroStats(id, profileId, gameMode, stats);
    if (rc == Rc::ErrNotFound) {
        result["error"] = err::NotFound;
        return result;
    }
    if (rc != Rc::Ok) {
        logger_.error(op, "error getting profile stats", rc2str(rc));
        result["error"] = err::DbError;
        return result;
    }

    QVariantMap statsJson;
    statsJson["games_played"] = stats.games;
    statsJson["games_won"] = stats.wins;
    statsJson["win_percentage"] = stats.games > 0 ? stats.wins * 100.0 / stats.games : 0;
    statsJson["average_winning_hp"] = stats.averageWinningHp;
    statsJson["most_played_enemy_id"] = stats.mostPlayedEnemyId;
    
    result["stats"] = statsJson;
    result["ok"] = true;
    return result;
}

QString Core::getDefaultProfileId() const {
    QSettings settings;
    return settings.value(defaultProfileSettingsKey).toString();
}

QVariantMap Core::setDefaultProfileId(const QString& profileId) const {
    const char op[] = "Core::setDefaultProfileId";
    QVariantMap result{{"ok", false}, {"error", err::None}};

    const QString trimmedId = profileId.trimmed();
    if (trimmedId.isEmpty() || QUuid(trimmedId).isNull()) {
        logger_.warning(op, "invalid profile id", {{"profile_id", profileId}});
        result["error"] = err_profile::InvalidId;
        return result;
    }

    QSettings settings;
    settings.setValue(defaultProfileSettingsKey, trimmedId);
    settings.sync();
    if (settings.status() != QSettings::NoError) {
        logger_.error(op, "can't save default profile");
        result["error"] = err::SettingsError;
        return result;
    }

    result["ok"] = true;
    return result;
}

QVariantMap Core::createProfile(const QString& name) const {
    const char op[] = "Core::createProfile";
    QVariantMap result;
    result["ok"] = false;

    const QString trimmedName = name.trimmed();
    if (trimmedName.isEmpty()) {
        logger_.warning(op, "profile name is empty");
        result["error"] = err_profile::EmptyName;
        return result;
    }

    if (trimmedName.size() > 256) {
        logger_.warning(op, "profile name is long");
        result["error"] = err_profile::NameTooLong;
        return result;
    }

    Rc rc = db_.createProfile(trimmedName);
    switch (rc) {
    case Rc::Ok:
        result["ok"] = true;
        result["error"] = err::None;
        break;
    case Rc::ErrDuplicate:
        result["error"] = err_profile::DuplicateName;
        break;
    default:
        result["error"] = err::DbError;
        break;
    }
    return result;
}

QVariantMap Core::deleteProfile(const QString& id) const {
    const char op[] = "Core::deleteProfile";
    QVariantMap result;
    result["ok"] = false;

    Rc rc = db_.deleteProfile(id);
    // TODO: refactor this -> throw error events to frontend using signal
    switch (rc) {
    case Rc::Ok:
        logger_.info(op, "profile deleted", {{"profile_id", id}});
        result["ok"] = true;
        result["error"] = err::None;
        break;
    case Rc::ErrNotFound:
        logger_.error(op, "profile not found", id);
        result["error"] = err::NotFound;
        break;
    case Rc::ErrReferenced:
        logger_.warning(op, "profile is used in game records",
                    {{"profile_id", id}});
        result["error"] = err_profile::HasGameRecords;
        break;
    default:
        result["error"] = err::DbError;
        break;
    }

    return result;
}

QVariantList Core::getGameHistory(const QString& sortBy, quint32 limit, quint32 offset) const {
    const char op[] = "Core::getGameHistory";

    constexpr quint32 maxPageSize = 100;
    if (limit == 0 || limit > maxPageSize) {
        logger_.warning(op, "invalid history page size", {{"limit", limit}});
        return {};
    }

    QVector<models::GameRecord> games;
    Rc rc = db_.getGameHistory(games, sortBy, limit, offset);
    if (rc != Rc::Ok) {
        logger_.error(op, "error getting game history", rc2str(rc));
        return QVariantList{};
    }

    QVariantList list;
    for (const auto& game : games) {
        QVariantMap obj;
        obj["id"] = game.id;
        obj["mode"] = game.mode;
        obj["map_id"] = game.mapId;
        obj["map_name"] = game.mapName;
        obj["winning_team"] = game.winningTeam;
        obj["played_at"] = displayDateFromDb(game.playedAt);
        obj["created_at"] = game.createdAt;

        QVariantList participants;
        for (const auto& participant : game.participants) {
            QVariantMap participantObj;
            participantObj["position"] = participant.position;
            participantObj["team"] = participant.team;
            participantObj["profile_id"] = participant.profileId;
            participantObj["profile_name"] = participant.profileName;
            participantObj["hero_id"] = participant.heroId;
            participantObj["hero_name"] = participant.heroName;
            participantObj["hero_img_path"] = participant.heroImgPath;
            participantObj["hero_remaining_hp"] = participant.heroRemainingHp;
            participants.append(std::move(participantObj));
        }
        obj["participants"] = participants;
        list.append(std::move(obj));
    }

    return list;
}

QVariantMap Core::createGameRecord(const QVariantMap& game) const {
    const char op[] = "Core::createGameRecord";
    QVariantMap result;
    result["ok"] = false;

    const QString mode = game.value("mode").toString();
    const QVariantList participants = game.value("participants").toList();
    const int winningTeam = game.value("winning_team").toInt();
    int playerCount = 0;
    int teamCount = 0;

    if (!gameModeSpec(mode, playerCount, teamCount) || participants.size() != playerCount ||
        winningTeam < 1 || winningTeam > teamCount) {
        logger_.warning(op, "invalid game record data");
        result["error"] = err_game::InvalidData;
        return result;
    }

    models::GameRecordInput input;
    input.mode = mode;
    input.mapId = game.value("map_id");
    input.winningTeam = winningTeam;

    QSet<int> positions;
    QSet<QString> profileIds;
    QVector<int> teamSizes(teamCount + 1, 0);
    for (const QVariant& participantValue : participants) {
        const QVariantMap participantMap = participantValue.toMap();
        models::GameRecordParticipantInput participant;
        participant.position = participantMap.value("position").toUInt();
        participant.team = participantMap.value("team").toUInt();
        participant.profileId = participantMap.value("profile_id").toString().trimmed();
        participant.heroId = participantMap.value("hero_id").toULongLong();
        participant.heroRemainingHp = participantMap.value("hero_remaining_hp");

        // participant validation
        if (participant.position < 1 || participant.position > playerCount) {
            logger_.warning(op, "invalid participant position",
                        {{"position", participant.position}, {"profile_id", participant.profileId}});
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (participant.team < 1 || participant.team > teamCount) {
            logger_.warning(op, "invalid participant team",
                        {{"team", participant.team}, {"profile_id", participant.profileId}});
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (participant.profileId.isEmpty() || QUuid(participant.profileId).isNull()) {
            logger_.warning(op, "invalid participant profile id",
                        {{"profile_id", participant.profileId}});
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (positions.contains(participant.position)) {
            logger_.warning(op, "duplicate participant position",
                        {{"position", participant.position}});
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (profileIds.contains(participant.profileId)) {
            logger_.warning(op, "duplicate participant profile id",
                        {{"profile_id", participant.profileId}});
            result["error"] = err_game::InvalidData;
            return result;
        }

        positions.insert(participant.position);
        profileIds.insert(participant.profileId);
        teamSizes[participant.team]++;
        input.participants.append(std::move(participant));
    }

    const int expectedTeamSize = playerCount / teamCount;
    for (int team = 1; team <= teamCount; ++team) {
        if (teamSizes[team] != expectedTeamSize) {
            logger_.warning(op, "invalid team size",
                        {{"game_mode", mode}, {"team", team}, {"team_size", teamSizes[team]}});
            result["error"] = err_game::InvalidData;
            return result;
        }
    }

    const QString playedAt = game.value("played_at").toString().trimmed();
    if (!playedAt.isEmpty()) {
        input.playedAt = dbDateFromDisplay(playedAt);
        if (input.playedAt.isEmpty()) {
            logger_.warning(op, "invalid played date", {{"played_at", playedAt}});
            result["error"] = err_game::InvalidData;
            return result;
        }
    }

    Rc rc = db_.createGameRecord(input);
    if (rc != Rc::Ok) {
        logger_.error(op, "error creating game record", rc2str(rc));
        result["error"] = err::DbError;
        return result;
    }

    result["ok"] = true;
    result["error"] = err::None;
    return result;
}

QVariantMap Core::deleteGameRecord(const QString& id) const {
    const char op[] = "Core::deleteGameRecord";
    QVariantMap result;
    result["ok"] = false;

    const QString trimmedId = id.trimmed();
    if (trimmedId.isEmpty()) {
        logger_.warning(op, "game record id is empty");
        result["error"] = err_game::InvalidData;
        return result;
    }

    Rc rc = db_.deleteGameRecord(trimmedId);
    switch (rc) {
    case Rc::Ok:
        result["ok"] = true;
        result["error"] = err::None;
        break;
    case Rc::ErrNotFound:
        logger_.error(op, "game record not found", trimmedId);
        result["error"] = err::NotFound;
        break;
    default:
        result["error"] = err::DbError;
        break;
    }

    return result;
}

void Core::requestImage(const QString& path) {
    const char* op = "Core::requestImage";
    
    if (path.isEmpty()) {
        return;
    }
    if (pendingImages_.contains(path)) {
        return;
    }
    pendingImages_.insert(path);

    QPointer<Core> self(this);
    provider_->get(
        path,
        [op, path, self](const QString& sourceUrl, Rc rc, FileSource source) {
            if (!self) {
                return;
            }
            self->pendingImages_.remove(path);
            if (rc != Rc::Ok) {
                self->logger_.error(op, "error getting image", rc2str(rc),
                                    {{"source", filesrc2str(source)},
                                     {"url", sourceUrl},
                                     {"path", path}});
                emit self->imageFailed(path);
                return;
            }

            self->logger_.info(op, "image received",
                              {{"source", filesrc2str(source)},
                               {"url", sourceUrl},
                               {"path", path}});
            emit self->imageReady(path, sourceUrl);
        }
    );
}

QVariantMap Core::exportDb(const QUrl& to) const {
    const char op[] = "Core::exportDb";
    QVariantMap result;
    Rc rc = dbExporter_.exportDb(db_, to);
    if (rc == Rc::Ok) {
        result["ok"] = true;
    } else {
        result["ok"] = false;
        result["error"] = rc2str(rc);
        logger_.error(op, "database export failed", result["error"].toString());
    }
    return result;
}

QVariantMap Core::getBuildInfo() const {
    return {
        {"ok", true},
        {"error", err::None},
        {"version", QStringLiteral(APP_VERSION)},
        {"commit", QStringLiteral(APP_COMMIT_HASH)},
        {"build_type", QStringLiteral(APP_BUILD_TYPE)},
    };
}

QVariantMap Core::saveRandomizerConfig(const QVariantList& heroes,
                                       const QVariantList& maps) const {
    const char op[] = "Core::saveRandomizerConfig";
    QVariantMap result{{"ok", false}, {"error", err::None}};

    const QString storagePath =
        QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if (storagePath.isEmpty() || !QDir().mkpath(storagePath)) {
        logger_.error(op, "can't create randomizer config directory",
                    {{"path", storagePath}});
        result["error"] = err_randomizer::StorageError;
        return result;
    }

    QJsonObject heroStates;
    QJsonObject mapStates;
    if (!enabledItemsToJson(heroes, heroStates) || !enabledItemsToJson(maps, mapStates)) {
        logger_.warning(op, "invalid randomizer config data");
        result["error"] = err_randomizer::InvalidData;
        return result;
    }

    QJsonObject data;
    data.insert("version", 1);
    data.insert("heroes", heroStates);
    data.insert("maps", mapStates);

    QSaveFile file(randomizerConfigPath());
    if (!file.open(QIODevice::WriteOnly)) {
        logger_.error(op, "can't open randomizer config", file.errorString());
        result["error"] = err_randomizer::WriteError;
        return result;
    }

    const QByteArray json = QJsonDocument(data).toJson(QJsonDocument::Indented);
    if (file.write(json) != json.size() || !file.commit()) {
        logger_.error(op, "can't write randomizer config", file.errorString());
        result["error"] = err_randomizer::WriteError;
        return result;
    }

    result["ok"] = true;
    return result;
}

QVariantMap Core::loadRandomizerConfig() const {
    const char op[] = "Core::loadRandomizerConfig";
    QVariantMap result{{"ok", true}, {"error", err::None}, {"exists", false}};

    const QString configPath = randomizerConfigPath();
    if (configPath.isEmpty()) {
        logger_.error(op, "randomizer config directory is unavailable");
        result["ok"] = false;
        result["error"] = err_randomizer::StorageError;
        return result;
    }

    QFile file(configPath);
    if (!file.exists()) {
        return result;
    }
    if (!file.open(QIODevice::ReadOnly)) {
        logger_.error(op, "can't open randomizer config", file.errorString());
        result["ok"] = false;
        result["error"] = err_randomizer::ReadError;
        return result;
    }

    QJsonParseError parseError;
    const QJsonDocument document = QJsonDocument::fromJson(file.readAll(), &parseError);
    if (parseError.error != QJsonParseError::NoError || !document.isObject()) {
        logger_.error(op, "invalid randomizer config", parseError.errorString());
        result["ok"] = false;
        result["error"] = err_randomizer::InvalidConfig;
        return result;
    }

    const QJsonObject data = document.object();
    const QJsonObject heroStates = data.value("heroes").toObject();
    const QJsonObject mapStates = data.value("maps").toObject();
    if (data.value("version").toInt() != 1 || !data.value("heroes").isObject() ||
        !data.value("maps").isObject() || !isEnabledItemsJson(heroStates) ||
        !isEnabledItemsJson(mapStates)) {
        logger_.error(op, "unsupported randomizer config structure");
        result["ok"] = false;
        result["error"] = err_randomizer::InvalidConfig;
        return result;
    }

    result["exists"] = true;
    result["heroes"] = heroStates.toVariantMap();
    result["maps"] = mapStates.toVariantMap();
    return result;
}
