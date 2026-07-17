#include "db.h"
#include "../log.h"
#include "../rc.h"

#include <QDebug>
#include <QDir>
#include <QSqlError>
#include <QSqlQuery>
#include <QStandardPaths>
#include <QUuid>

Database::Database(const QString& dbPath, const QString& dbName)
    : dbPath_(dbPath),
      dbName_(dbName) {
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
        qDebug() << "DB error:" << db.lastError().text();
        return Rc::ErrCreateDb;
    }

    QSqlQuery foreignKeysQuery(db);
    if (!foreignKeysQuery.exec("PRAGMA foreign_keys = ON")) {
        qDebug() << "Can't enable foreign keys:" << foreignKeysQuery.lastError().text();
        db.close();
        return Rc::ErrExecQuery;
    }

    qDebug() << "Database path:" << dbPath_;

    return Rc::Ok;
}

void Database::close() {
    db.close();
}

QString Database::path() const {
    return dbPath_;
}

ScopedDatabaseClose::ScopedDatabaseClose(Database& db)
    : db_(db) {
    db_.close();
}

ScopedDatabaseClose::~ScopedDatabaseClose() {
    const char op[] = "ScopedDatabaseClose::~ScopedDatabaseClose";
    const Rc rc = db_.open();
    if (rc != Rc::Ok) {
        lerr(op) << "can't reopen database: " << rc2str(rc);
    }
}

Rc Database::getHeroes(QVector<models::Hero>& heroes) {
    const char op[] = "Database::getHeroes";

    QSqlQuery query;

    bool ok = query.exec("SELECT id, name, hp, move, set_id, img_path FROM heroes");
    if (!ok) {
        lwarn(op) << "sql error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::Hero hero;
        hero.id = query.value(0).toULongLong();
        hero.name = query.value(1).toString();
        hero.hp = query.value(2).toUInt();
        hero.move = query.value(3).toUInt();
        hero.setId = query.value(4).toUInt();
        hero.imgPath = query.value(5).toString();
        heroes.append(std::move(hero));
    }
    return Rc::Ok;
}

Rc Database::getHeroesBySetId(quint64 setId, QVector<models::Hero>& heroes) {
    const char op[] = "Database::getHeroesBySetId";

    QSqlQuery query;

    bool ok = query.prepare(
        "SELECT id, name, hp, move, set_id, img_path FROM heroes WHERE set_id = :setId");
    if (!ok) {
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    query.bindValue(":setId", setId);
    if (!query.exec()) {
        lwarn(op) << "sql execute error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::Hero hero;
        hero.id = query.value(0).toULongLong();
        hero.name = query.value(1).toString();
        hero.hp = query.value(2).toUInt();
        hero.move = query.value(3).toUInt();
        hero.setId = query.value(4).toUInt();
        hero.imgPath = query.value(5).toString();
        heroes.append(std::move(hero));
    }
    return Rc::Ok;
}

Rc Database::getMaps(QVector<models::GameMap>& maps) {
    const char op[] = "Database::getMaps";

    QSqlQuery query;

    bool ok = query.exec("SELECT id, name, set_id, img_path FROM maps");
    if (!ok) {
        lwarn(op) << "sql error: " << query.lastError().text();
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
        lwarn(op) << "sql error: " << query.lastError().text();
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
        lwarn(op) << "set sql error: " << query.lastError().text();
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
            lwarn(op) << "hero sql prepare error: " << heroQuery.lastError().text();
            return Rc::ErrPrepareQuery;
        }
        heroQuery.bindValue(":setId", set.id);
        if (!heroQuery.exec()) {
            lwarn(op) << "hero sql exec error: " << heroQuery.lastError().text();
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
        ldebug(op) << "set " << set.name << "heroes length " << heroes.size();
        set.heroes = std::move(heroes);

        QSqlQuery mapQuery;
        ok = mapQuery.prepare("SELECT id, name, img_path FROM maps WHERE set_id = :setId");
        if (!ok) {
            lwarn(op) << "map sql prepare error: " << mapQuery.lastError().text();
            return Rc::ErrPrepareQuery;
        }
        mapQuery.bindValue(":setId", set.id);
        if (!mapQuery.exec()) {
            lwarn(op) << "map sql exec error: " << mapQuery.lastError().text();
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
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }
    query.bindValue(":heroId", heroId);
    if (!query.exec()) {
        lwarn(op) << "sql exec error: " << query.lastError().text();
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
        lwarn(op) << "sql error: " << query.lastError().text();
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

Rc Database::getProfileStats(const QString& profileId,
                             const QString& gameMode,
                             models::ProfileStats& stats) {
    const char op[] = "Database::getProfileStats";

    QSqlQuery profileQuery(db);
    if (!profileQuery.prepare("SELECT 1 FROM player_profiles WHERE id = :profile_id")) {
        lwarn(op) << "profile sql prepare error: " << profileQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    profileQuery.bindValue(":profile_id", profileId);
    if (!profileQuery.exec()) {
        lwarn(op) << "profile sql exec error: " << profileQuery.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (!profileQuery.next()) {
        return Rc::ErrNotFound;
    }

    QSqlQuery totalsQuery(db);
    if (!totalsQuery.prepare(
            "SELECT COUNT(*), "
            "COALESCE(SUM(CASE WHEN grp.team = gr.winning_team THEN 1 ELSE 0 END), 0), "
            "AVG(CASE WHEN grp.team = gr.winning_team THEN grp.hero_remaining_hp END) "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "WHERE grp.profile_id = :profile_id AND gr.mode = :game_mode")) {
        lwarn(op) << "totals sql prepare error: " << totalsQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    totalsQuery.bindValue(":profile_id", profileId);
    totalsQuery.bindValue(":game_mode", gameMode);
    if (!totalsQuery.exec() || !totalsQuery.next()) {
        lwarn(op) << "totals sql exec error: " << totalsQuery.lastError().text();
        return Rc::ErrExecQuery;
    }
    stats.gamesPlayed = totalsQuery.value(0).toULongLong();
    stats.gamesWon = totalsQuery.value(1).toULongLong();
    stats.averageWinningHp = totalsQuery.value(2);

    QSqlQuery heroQuery(db);
    if (!heroQuery.prepare(
            "SELECT h.id, h.name, h.img_path, COUNT(*) AS games_played, "
            "COALESCE(SUM(CASE WHEN grp.team = gr.winning_team THEN 1 ELSE 0 END), 0) "
            "AS games_won "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "JOIN heroes h ON h.id = grp.hero_id "
            "WHERE grp.profile_id = :profile_id AND gr.mode = :game_mode "
            "GROUP BY h.id, h.name, h.img_path "
            "ORDER BY games_played DESC, games_won DESC, h.name COLLATE NOCASE "
            "LIMIT 1")) {
        lwarn(op) << "hero sql prepare error: " << heroQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    heroQuery.bindValue(":profile_id", profileId);
    heroQuery.bindValue(":game_mode", gameMode);
    if (!heroQuery.exec()) {
        lwarn(op) << "hero sql exec error: " << heroQuery.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (heroQuery.next()) {
        stats.favoriteHeroId = heroQuery.value(0).toULongLong();
        stats.favoriteHeroName = heroQuery.value(1).toString();
        stats.favoriteHeroImgPath = heroQuery.value(2).toString();
        stats.favoriteHeroGames = heroQuery.value(3).toULongLong();
        stats.favoriteHeroWins = heroQuery.value(4).toULongLong();
    }

    QSqlQuery mapQuery(db);
    if (!mapQuery.prepare(
            "SELECT m.id, m.name, m.img_path, COUNT(*) AS games_played "
            "FROM game_record_participants grp "
            "JOIN game_records gr ON gr.id = grp.game_id "
            "JOIN maps m ON m.id = gr.map_id "
            "WHERE grp.profile_id = :profile_id AND gr.mode = :game_mode "
            "GROUP BY m.id, m.name, m.img_path "
            "ORDER BY games_played DESC, m.name COLLATE NOCASE "
            "LIMIT 1")) {
        lwarn(op) << "map sql prepare error: " << mapQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }
    mapQuery.bindValue(":profile_id", profileId);
    mapQuery.bindValue(":game_mode", gameMode);
    if (!mapQuery.exec()) {
        lwarn(op) << "map sql exec error: " << mapQuery.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (mapQuery.next()) {
        stats.favoriteMapId = mapQuery.value(0).toULongLong();
        stats.favoriteMapName = mapQuery.value(1).toString();
        stats.favoriteMapImgPath = mapQuery.value(2).toString();
        stats.favoriteMapGames = mapQuery.value(3).toULongLong();
    }

    return Rc::Ok;
}

Rc Database::createProfile(const QString& name) {
    const char op[] = "Database::createProfile";
    const QString id = QUuid::createUuid().toString(QUuid::WithoutBraces);

    QSqlQuery query;
    bool ok = query.prepare("INSERT INTO player_profiles (id, name) VALUES (:id, :name)");
    if (!ok) {
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", id);
    query.bindValue(":name", name.trimmed());
    if (!query.exec()) {
        const QSqlError error = query.lastError();
        lwarn(op) << "sql exec error: " << error.text();
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
        lwarn(op) << "reference sql prepare error: " << referenceQuery.lastError().text();
        return Rc::ErrPrepareQuery;
    }

    referenceQuery.bindValue(":id", id);
    if (!referenceQuery.exec()) {
        lwarn(op) << "reference sql exec error: " << referenceQuery.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (referenceQuery.next()) {
        return Rc::ErrReferenced;
    }

    QSqlQuery query(db);
    ok = query.prepare("DELETE FROM player_profiles WHERE id = :id");
    if (!ok) {
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", id);
    if (!query.exec()) {
        const QSqlError error = query.lastError();
        lwarn(op) << "sql exec error: " << error.text();
        if (error.databaseText().contains("FOREIGN KEY constraint failed",
                                          Qt::CaseInsensitive)) {
            return Rc::ErrReferenced;
        }
        return Rc::ErrExecQuery;
    }
    if (query.numRowsAffected() == 0) {
        lwarn(op) << "profile not found: " << id;
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
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":limit", limit);
    query.bindValue(":offset", offset);
    if (!query.exec()) {
        lwarn(op) << "sql exec error: " << query.lastError().text();
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
        lwarn(op) << "can't start transaction: " << db.lastError().text();
        return Rc::ErrExecQuery;
    }

    QSqlQuery query(db);
    bool ok = query.prepare("INSERT INTO game_records ("
                            "id, mode, map_id, winning_team, played_at"
                            ") VALUES ("
                            ":id, :mode, :map_id, :winning_team, :played_at"
                            ")");
    if (!ok) {
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        db.rollback();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", gameId);
    query.bindValue(":mode", game.mode);
    query.bindValue(":map_id", game.mapId);
    query.bindValue(":winning_team", game.winningTeam);
    query.bindValue(":played_at", game.playedAt.isEmpty() ? QVariant() : QVariant(game.playedAt));

    if (!query.exec()) {
        lwarn(op) << "sql exec error: " << query.lastError().text();
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
        lwarn(op) << "participant sql prepare error: " << participantQuery.lastError().text();
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
            lwarn(op) << "participant sql exec error: " << participantQuery.lastError().text();
            db.rollback();
            return Rc::ErrExecQuery;
        }
    }

    if (!db.commit()) {
        lwarn(op) << "can't commit game record: " << db.lastError().text();
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
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", id);
    if (!query.exec()) {
        lwarn(op) << "sql exec error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }
    if (query.numRowsAffected() == 0) {
        lwarn(op) << "game record not found: " << id;
        return Rc::ErrNotFound;
    }
    return Rc::Ok;
}
