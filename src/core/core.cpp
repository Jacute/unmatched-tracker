#include "core.h"
#include "../log.h"
#include "errors.h"

#include <QDate>
#include <QPointer>
#include <QSet>

constexpr int imgThreadCount = 8;
constexpr const char* dbDateFormat = "yyyy-MM-dd";
constexpr const char* displayDateFormat = "dd-MM-yyyy";

Core::Core(Database& db, DbExporter& dbExporter, FileProvider* fp)
    : db_(db),
      dbExporter_(dbExporter),
      provider_(fp),
      QObject(nullptr) {
    imageThreadPool_.setMaxThreadCount(imgThreadCount);
};

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
    ldebug(op) << "heroes got from db";

    return mapHeroesQml(heroes);
}

QVariantList Core::getHeroesBySetId(quint64 setId) const {
    const char op[] = "Core::getHeroesBySetId";

    linfo(op) << "getting heroes by set id";
    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroesBySetId(setId, heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    linfo(op) << "heroes by set id got successfully";

    return mapHeroesQml(heroes);
}

QVariantList Core::getMaps() const {
    const char op[] = "Core::getMaps";

    QVector<models::GameMap> maps;
    Rc rc = db_.getMaps(maps);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "heroes got from db";

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
    ldebug(op) << "short sets got from db";

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
    ldebug(op) << "sets got from db";

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
    ldebug(op) << "cards by hero id got from db";

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
    ldebug(op) << "profiles got from db";

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

QVariantMap Core::createProfile(const QString& name) const {
    const char op[] = "Core::createProfile";
    QVariantMap result;
    result["ok"] = false;

    const QString trimmedName = name.trimmed();
    if (trimmedName.isEmpty()) {
        lwarn(op) << "profile name is empty";
        result["error"] = err_profile::EmptyName;
        return result;
    }

    if (trimmedName.size() > 256) {
        lwarn(op) << "profile name is long";
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

QVariantMap Core::deleteProfile(quint64 id) const {
    const char op[] = "Core::deleteProfile";
    QVariantMap result;
    result["ok"] = false;

    Rc rc = db_.deleteProfile(id);
    // TODO: refactor this -> throw error events to frontend using signal
    switch (rc) {
    case Rc::Ok:
        linfo(op) << "profile with id " << id << " successfully deleted";
        result["ok"] = true;
        result["error"] = err::None;
        break;
    case Rc::ErrNotFound:
        lerr(op) << "error profile not found: " << id;
        result["error"] = err_profile::NotFound;
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
        lwarn(op) << "invalid history page size: " << limit;
        return {};
    }

    QVector<models::GameRecord> games;
    Rc rc = db_.getGameHistory(games, sortBy, limit, offset);
    if (rc != Rc::Ok) {
        lerr(op) << "error getting game history: " << rc2str(rc);
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
        lwarn(op) << "invalid game record data";
        result["error"] = err_game::InvalidData;
        return result;
    }

    models::GameRecordInput input;
    input.mode = mode;
    input.mapId = game.value("map_id");
    input.winningTeam = winningTeam;

    QSet<int> positions;
    QSet<quint64> profileIds;
    QVector<int> teamSizes(teamCount + 1, 0);
    for (const QVariant& participantValue : participants) {
        const QVariantMap participantMap = participantValue.toMap();
        models::GameRecordParticipantInput participant;
        participant.position = participantMap.value("position").toUInt();
        participant.team = participantMap.value("team").toUInt();
        participant.profileId = participantMap.value("profile_id").toULongLong();
        participant.heroId = participantMap.value("hero_id").toULongLong();
        participant.heroRemainingHp = participantMap.value("hero_remaining_hp");

        // participant validation
        if (participant.position < 1 || participant.position > playerCount) {
            lwarn(op) << "invalid position in game participant data: " << participant;
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (participant.team < 1 || participant.team > teamCount) {
            lwarn(op) << "invalid team in game participant data: " << participant;
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (participant.profileId == 0) {
            lwarn(op) << "zero profileId in game participant data: " << participant;
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (positions.contains(participant.position)) {
            lwarn(op) << "duplicate of position in game participant data: " << participant;
            result["error"] = err_game::InvalidData;
            return result;
        }
        if (profileIds.contains(participant.profileId)) {
            lwarn(op) << "duplicate of profileId in game participant data: " << participant;
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
            lwarn(op) << "invalid team size for mode " << mode;
            result["error"] = err_game::InvalidData;
            return result;
        }
    }

    const QString playedAt = game.value("played_at").toString().trimmed();
    if (!playedAt.isEmpty()) {
        input.playedAt = dbDateFromDisplay(playedAt);
        if (input.playedAt.isEmpty()) {
            lwarn(op) << "invalid played_at date: " << playedAt;
            result["error"] = err_game::InvalidData;
            return result;
        }
    }

    Rc rc = db_.createGameRecord(input);
    if (rc != Rc::Ok) {
        lerr(op) << "error creating game record: " << rc2str(rc);
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
        lwarn(op) << "game record id is empty";
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
        lerr(op) << "game record not found: " << trimmedId;
        result["error"] = err_game::NotFound;
        break;
    default:
        result["error"] = err::DbError;
        break;
    }

    return result;
}

QString Core::getImage(const QString& path) const {
    const char op[] = "Core::getImage";
    QString sourceUrl;
    Rc rc = provider_->get(path, sourceUrl);
    if (rc != Rc::Ok) {
        lerr("Core::requestImage") << "error getting image: " << path << " rc=" << rc2str(rc);
        // TODO: throw error event to fronted using signal
        return ""; // TODO: add placeholder image
    }
    linfo(op) << "image got successfully url=" << sourceUrl;
    return sourceUrl;
}

void Core::requestImage(const QString& path) {
    QPointer<Core> self(this);
    FileProvider* provider = provider_;

    imageThreadPool_.start([self, provider, path]() {
        QString sourceUrl;
        Rc rc = provider->get(path, sourceUrl);

        if (!self) {
            return;
        }

        QMetaObject::invokeMethod(
            self,
            [self, path, sourceUrl, rc]() {
                if (!self) {
                    return;
                }

                if (rc != Rc::Ok) {
                    lerr("Core::requestImage")
                        << "error getting image: " << path << " rc=" << rc2str(rc);
                    emit self->imageFailed(path);
                    return;
                }

                linfo("Core::requestImage") << "image got successfully url=" << sourceUrl;
                emit self->imageReady(path, sourceUrl);
            },
            Qt::QueuedConnection);
    });
}

QVariantMap Core::exportDb(const QUrl& to) const {
    QVariantMap result;
    Rc rc = dbExporter_.exportDb(db_, to);
    if (rc == Rc::Ok) {
        result["ok"] = true;
    } else {
        result["ok"] = false;
        result["error"] = rc2str(rc);
    }
    return result;
}
