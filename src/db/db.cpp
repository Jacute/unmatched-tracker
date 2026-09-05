#include "db.h"
#include "../log.h"
#include "../rc.h"

#include <QDebug>
#include <QDir>
#include <QSqlError>
#include <QSqlQuery>
#include <QStandardPaths>
#include <QUuid>

Database::Database(const Logger& logger, const QString& dbPath, const QString& dbName)
    : dbPath_(dbPath),
      dbName_(dbName),
      logger_(logger) {
}

Rc Database::open() {
    if (!db.isValid()) {
        db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName(dbPath_);
    }

    if (db.isOpen()) {
        return Rc::Ok;
    }

    if (!db.open()) {
        logger_.error("Database::open", "database open error", db.lastError().text());
        return Rc::ErrCreateDb;
    }

    QSqlQuery foreignKeysQuery(db);
    if (!foreignKeysQuery.exec("PRAGMA foreign_keys = ON")) {
        logger_.error("Database::open", "can't enable foreign keys",
                      foreignKeysQuery.lastError().text());
        db.close();
        return Rc::ErrExecQuery;
    }

    logger_.debug("Database::open", "database opened",
                {{"database_path", dbPath_}});

    return Rc::Ok;
}

void Database::close() {
    db.close();
}

QString Database::path() const {
    return dbPath_;
}

ScopedDatabaseClose::ScopedDatabaseClose(const Logger& logger, Database& db)
    : db_(db),
      logger_(logger) {
    db_.close();
}

ScopedDatabaseClose::~ScopedDatabaseClose() {
    const char op[] = "ScopedDatabaseClose::~ScopedDatabaseClose";
    const Rc rc = db_.open();
    if (rc != Rc::Ok) {
        logger_.error(op, "can't reopen database", rc2str(rc));
    }
}

static void readHeroes(QSqlQuery& query, QVector<models::Hero>& heroes) {
    while (query.next()) {
        const quint64 heroId = query.value(0).toULongLong();
        if (heroes.isEmpty() || heroes.constLast().id != heroId) {
            models::Hero hero;
            hero.id = heroId;
            hero.name = query.value(1).toString();
            hero.hp = query.value(2).toUInt();
            hero.move = query.value(3).toUInt();
            hero.setId = query.value(4).toULongLong();
            hero.imgPath = query.value(5).toString();
            hero.ability = query.value(6).toString();
            hero.attackType = query.value(7).toString();
            heroes.append(std::move(hero));
        }

        if (!query.value(8).isNull()) {
            models::Assistant assistant;
            assistant.id = query.value(8).toULongLong();
            assistant.name = query.value(9).toString();
            assistant.count = query.value(10).toUInt();
            assistant.hpPerOne = query.value(11).toUInt();
            assistant.attackType = query.value(12).toString();
            heroes.last().assistants.append(std::move(assistant));
        }
    }
}

Rc Database::getHeroes(QVector<models::Hero>& heroes) {
    const char op[] = "Database::getHeroes";

    QSqlQuery query;

    bool ok = query.exec("SELECT h.id, h.name, h.hp, h.move, h.set_id, h.img_path, "
                         "h.ability, h.attack_type, "
                         "a.id, a.name, a.count, a.hp_per_one, a.attack_type "
                         "FROM heroes h "
                         "LEFT JOIN assistants a ON a.hero_id = h.id "
                         "ORDER BY h.id, a.id");
    if (!ok) {
        logger_.error(op, "sql error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    readHeroes(query, heroes);
    return Rc::Ok;
}

Rc Database::getHeroesBySetId(quint64 setId, QVector<models::Hero>& heroes) {
    const char op[] = "Database::getHeroesBySetId";

    QSqlQuery query;

    bool ok = query.prepare("SELECT h.id, h.name, h.hp, h.move, h.set_id, h.img_path, "
                            "h.ability, h.attack_type, "
                            "a.id, a.name, a.count, a.hp_per_one, a.attack_type "
                            "FROM heroes h "
                            "LEFT JOIN assistants a ON a.hero_id = h.id "
                            "WHERE h.set_id = :setId "
                            "ORDER BY h.id, a.id");
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }
    query.bindValue(":setId", setId);
    if (!query.exec()) {
        logger_.error(op, "sql execute error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    readHeroes(query, heroes);
    return Rc::Ok;
}

Rc Database::getMaps(QVector<models::GameMap>& maps) {
    const char op[] = "Database::getMaps";

    QSqlQuery query;

    bool ok = query.exec("SELECT id, name, set_id, img_path FROM maps");
    if (!ok) {
        logger_.error(op, "sql error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::GameMap map;
        map.id = query.value(0).toULongLong();
        map.name = query.value(1).toString();
        map.setId = query.value(2).toUInt();
        map.imgPath = query.value(3).toString();
        maps.append(std::move(map));
    }
    return Rc::Ok;
}

Rc Database::getSets(QVector<models::GameSetShort>& sets) {
    const char op[] = "Database::getSets";

    QSqlQuery query;

    bool ok = query.exec("SELECT id, name, img_path, released_at FROM sets");
    if (!ok) {
        logger_.error(op, "sql error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::GameSetShort set;
        set.id = query.value(0).toULongLong();
        set.name = query.value(1).toString();
        set.imgPath = query.value(2).toString();
        set.releasedAt = query.value(3).toDate();
        sets.append(std::move(set));
    }
    return Rc::Ok;
}

Rc Database::getSHM(QVector<models::GameSet>& sets) {
    const char op[] = "Database::getSHM";

    QSqlQuery query;

    bool ok = query.exec("SELECT id, name, img_path, released_at FROM sets");
    if (!ok) {
        logger_.error(op, "set sql error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::GameSet set;
        set.id = query.value(0).toULongLong();
        set.name = query.value(1).toString();
        set.imgPath = query.value(2).toString();
        set.releasedAt = query.value(3).toDate();

        QSqlQuery heroQuery;
        ok = heroQuery.prepare(
            "SELECT id, name, hp, move, set_id, img_path FROM heroes WHERE set_id = :setId");
        if (!ok) {
            logger_.error(op, "hero sql prepare error", {{"error", heroQuery.lastError().text()}});
            return Rc::ErrPrepareQuery;
        }
        heroQuery.bindValue(":setId", set.id);
        if (!heroQuery.exec()) {
            logger_.error(op, "hero sql exec error", {{"error", heroQuery.lastError().text()}});
            return Rc::ErrExecQuery;
        }
        QVector<models::Hero> heroes;
        while (heroQuery.next()) {
            models::Hero hero;
            hero.id = heroQuery.value(0).toULongLong();
            hero.name = heroQuery.value(1).toString();
            hero.hp = heroQuery.value(2).toUInt();
            hero.move = heroQuery.value(3).toUInt();
            hero.setId = heroQuery.value(4).toULongLong();
            hero.imgPath = heroQuery.value(5).toString();
            heroes.append(std::move(hero));
        }
        logger_.debug(op, "set heroes loaded",
                    {{"set_name", set.name}, {"heroes_count", heroes.size()}});
        set.heroes = std::move(heroes);

        QSqlQuery mapQuery;
        ok = mapQuery.prepare("SELECT id, name, img_path FROM maps WHERE set_id = :setId");
        if (!ok) {
            logger_.error(op, "map sql prepare error", {{"error", mapQuery.lastError().text()}});
            return Rc::ErrPrepareQuery;
        }
        mapQuery.bindValue(":setId", set.id);
        if (!mapQuery.exec()) {
            logger_.error(op, "map sql exec error", {{"error", mapQuery.lastError().text()}});
            return Rc::ErrExecQuery;
        }
        QVector<models::GameMap> maps;
        while (mapQuery.next()) {
            models::GameMap map;
            map.id = mapQuery.value(0).toULongLong();
            map.name = mapQuery.value(1).toString();
            map.imgPath = mapQuery.value(2).toString();
            maps.append(std::move(map));
        }
        set.maps = std::move(maps);

        sets.append(std::move(set));
    }
    return Rc::Ok;
}

Rc Database::getCardsByHeroId(quint64 heroId, QVector<models::Card>& cards) {
    const char op[] = "Database::getCardsByHeroId";

    QSqlQuery query;

    bool ok = query.prepare(
        "SELECT id, name, description, count, img_path, hero_id, card_type_id "
        "FROM cards WHERE hero_id = :heroId ORDER BY card_type_id ASC, value DESC, name ASC");
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    query.bindValue(":heroId", heroId);
    if (!query.exec()) {
        logger_.error(op, "sql exec error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::Card card;
        card.id = query.value(0).toULongLong();
        card.name = query.value(1).toString();
        card.description = query.value(2).toString();
        card.count = query.value(3).toULongLong();
        card.imgPath = query.value(4).toString();
        card.heroId = query.value(5).toULongLong();
        card.cardTypeId = query.value(6).toULongLong();
        cards.append(std::move(card));
    }
    return Rc::Ok;
}

Rc Database::getProfiles(QVector<models::PlayerProfile>& profiles) {
    const char op[] = "Database::getProfiles";

    QSqlQuery query;
    bool ok = query.exec("SELECT id, name, created_at FROM player_profiles ORDER BY name");
    if (!ok) {
        logger_.error(op, "sql error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::PlayerProfile profile;
        profile.id = query.value(0).toString();
        profile.name = query.value(1).toString();
        profile.createdAt = query.value(2).toString();
        profiles.append(std::move(profile));
    }
    return Rc::Ok;
}

Rc Database::createProfile(const QString& name) {
    const char op[] = "Database::createProfile";
    const QString id = QUuid::createUuid().toString(QUuid::WithoutBraces);

    QSqlQuery query;
    bool ok = query.prepare("INSERT INTO player_profiles (id, name) VALUES (:id, :name)");
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", id);
    query.bindValue(":name", name.trimmed());
    if (!query.exec()) {
        const QSqlError error = query.lastError();
        logger_.error(op, "sql exec error", {{"error", error.text()}});
        if (error.databaseText().contains("UNIQUE constraint failed")) {
            return Rc::ErrDuplicate;
        }
        return Rc::ErrExecQuery;
    }
    return Rc::Ok;
}

Rc Database::deleteProfile(const QString& id) {
    const char op[] = "Database::deleteProfile";

    QSqlQuery referenceQuery(db);
    bool ok = referenceQuery.prepare(
        "SELECT 1 FROM game_record_participants WHERE profile_id = :id LIMIT 1");
    if (!ok) {
        logger_.error(op, "reference sql prepare error", {{"error", referenceQuery.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }

    referenceQuery.bindValue(":id", id);
    if (!referenceQuery.exec()) {
        logger_.error(op, "reference sql exec error", {{"error", referenceQuery.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (referenceQuery.next()) {
        return Rc::ErrReferenced;
    }

    QSqlQuery query(db);
    ok = query.prepare("DELETE FROM player_profiles WHERE id = :id");
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", id);
    if (!query.exec()) {
        const QSqlError error = query.lastError();
        logger_.error(op, "sql exec error", {{"error", error.text()}});
        if (error.databaseText().contains("FOREIGN KEY constraint failed", Qt::CaseInsensitive)) {
            return Rc::ErrReferenced;
        }
        return Rc::ErrExecQuery;
    }
    if (query.numRowsAffected() == 0) {
        logger_.warning(op, "profile not found", {{"profile_id", id}});
        return Rc::ErrNotFound;
    }
    return Rc::Ok;
}

Rc Database::getGameHistory(QVector<models::GameRecord>& games,
                            const QString& sortBy,
                            quint32 limit,
                            quint32 offset) {
    const char op[] = "Database::getGameHistory";

    QString orderColumn = "created_at";
    if (sortBy == "played_at") {
        orderColumn = "played_at";
    }

    QSqlQuery query(db);
    bool ok = query.prepare(QString("WITH history_page AS ("
                                    "SELECT id, mode, winning_team, map_id, played_at, created_at "
                                    "FROM game_records "
                                    "ORDER BY %1 DESC, id "
                                    "LIMIT :limit OFFSET :offset"
                                    ") "
                                    "SELECT "
                                    "hp.id, hp.mode, hp.winning_team, "
                                    "hp.map_id, m.name, hp.played_at, hp.created_at, "
                                    "grp.position, grp.team, "
                                    "grp.profile_id, pp.name, "
                                    "grp.hero_id, h.name, h.img_path, grp.hero_remaining_hp "
                                    "FROM history_page hp "
                                    "JOIN game_record_participants grp ON grp.game_id = hp.id "
                                    "JOIN player_profiles pp ON pp.id = grp.profile_id "
                                    "LEFT JOIN heroes h ON h.id = grp.hero_id "
                                    "LEFT JOIN maps m ON m.id = hp.map_id "
                                    "ORDER BY hp.%1 DESC, hp.id, grp.position")
                                .arg(orderColumn));
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":limit", limit);
    query.bindValue(":offset", offset);
    if (!query.exec()) {
        logger_.error(op, "sql exec error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        const QString gameId = query.value(0).toString();
        if (games.isEmpty() || games.constLast().id != gameId) {
            models::GameRecord game;
            game.id = gameId;
            game.mode = query.value(1).toString();
            game.winningTeam = query.value(2).toUInt();
            game.mapId = query.value(3);
            game.mapName = query.value(4);
            game.playedAt = query.value(5);
            game.createdAt = query.value(6).toString();
            games.append(std::move(game));
        }

        models::GameRecordParticipant participant;
        participant.position = query.value(7).toUInt();
        participant.team = query.value(8).toUInt();
        participant.profileId = query.value(9).toString();
        participant.profileName = query.value(10).toString();
        participant.heroId = query.value(11).toULongLong();
        participant.heroName = query.value(12).toString();
        participant.heroImgPath = query.value(13).toString();
        participant.heroRemainingHp = query.value(14);
        games.last().participants.append(std::move(participant));
    }

    return Rc::Ok;
}

Rc Database::createGameRecord(const models::GameRecordInput& game) {
    const char op[] = "Database::createGameRecord";
    const QString gameId = QUuid::createUuid().toString(QUuid::WithoutBraces);

    if (!db.transaction()) {
        logger_.error(op, "can't start transaction", {{"error", db.lastError().text()}});
        return Rc::ErrExecQuery;
    }

    QSqlQuery query(db);
    bool ok = query.prepare("INSERT INTO game_records ("
                            "id, mode, map_id, winning_team, played_at"
                            ") VALUES ("
                            ":id, :mode, :map_id, :winning_team, :played_at"
                            ")");
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        db.rollback();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", gameId);
    query.bindValue(":mode", game.mode);
    query.bindValue(":map_id", game.mapId);
    query.bindValue(":winning_team", game.winningTeam);
    query.bindValue(":played_at", game.playedAt.isEmpty() ? QVariant() : QVariant(game.playedAt));

    if (!query.exec()) {
        logger_.error(op, "sql exec error", {{"error", query.lastError().text()}});
        db.rollback();
        return Rc::ErrExecQuery;
    }

    QSqlQuery participantQuery(db);
    ok = participantQuery.prepare(
        "INSERT INTO game_record_participants ("
        "game_id, position, team, profile_id, hero_id, hero_remaining_hp"
        ") VALUES ("
        ":game_id, :position, :team, :profile_id, :hero_id, :hero_remaining_hp"
        ")");
    if (!ok) {
        logger_.error(op, "participant sql prepare error", {{"error", participantQuery.lastError().text()}});
        db.rollback();
        return Rc::ErrPrepareQuery;
    }

    for (const auto& participant : game.participants) {
        participantQuery.bindValue(":game_id", gameId);
        participantQuery.bindValue(":position", participant.position);
        participantQuery.bindValue(":team", participant.team);
        participantQuery.bindValue(":profile_id", participant.profileId);
        if (participant.heroId != 0) {
            participantQuery.bindValue(":hero_id", participant.heroId);
        } else {
            participantQuery.bindValue(":hero_id", QVariant());
        }
        participantQuery.bindValue(":hero_remaining_hp", participant.heroRemainingHp);
        if (!participantQuery.exec()) {
            logger_.error(op, "participant sql exec error", {{"error", participantQuery.lastError().text()}});
            db.rollback();
            return Rc::ErrExecQuery;
        }
    }

    if (!db.commit()) {
        logger_.error(op, "can't commit game record", {{"error", db.lastError().text()}});
        db.rollback();
        return Rc::ErrExecQuery;
    }

    return Rc::Ok;
}

Rc Database::deleteGameRecord(const QString& id) {
    const char op[] = "Database::deleteGameRecord";

    QSqlQuery query;
    bool ok = query.prepare("DELETE FROM game_records WHERE id = :id");
    if (!ok) {
        logger_.error(op, "sql prepare error", {{"error", query.lastError().text()}});
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", id);
    if (!query.exec()) {
        logger_.error(op, "sql exec error", {{"error", query.lastError().text()}});
        return Rc::ErrExecQuery;
    }
    if (query.numRowsAffected() == 0) {
        logger_.warning(op, "game record not found", {{"game_id", id}});
        return Rc::ErrNotFound;
    }
    return Rc::Ok;
}
