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
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath_);

    if (!db.open()) {
        qDebug() << "DB error:" << db.lastError().text();
        return Rc::ErrCreateDb;
    }

    qDebug() << "Database path:" << dbPath_;

    return Rc::Ok;
}

void Database::close() {
    db.close();
}

Rc Database::getHeroes(QVector<models::Hero>& heroes) {
    const char op[] = "Database::getHeroes";

    QSqlQuery query;

    bool ok = query.exec("SELECT id, name, set_id, img_path FROM heroes");
    if (!ok) {
        lwarn(op) << "sql error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::Hero hero;
        hero.id = query.value(0).toULongLong();
        hero.name = query.value(1).toString();
        hero.setId = query.value(2).toUInt();
        hero.imgPath = query.value(3).toString();
        heroes.append(std::move(hero));
    }
    return Rc::Ok;
}

Rc Database::getHeroesBySetId(quint64 setId, QVector<models::Hero>& heroes) {
    const char op[] = "Database::getHeroesBySetId";

    QSqlQuery query;

    bool ok = query.prepare("SELECT id, name, img_path FROM heroes WHERE set_id = :setId");
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
        hero.imgPath = query.value(2).toString();
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
        ok = heroQuery.prepare("SELECT id, name, img_path FROM heroes WHERE set_id = :setId");
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
            hero.imgPath = heroQuery.value(2).toString();
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
        profile.id = query.value(0).toULongLong();
        profile.name = query.value(1).toString();
        profile.createdAt = query.value(2).toString();
        profiles.append(std::move(profile));
    }
    return Rc::Ok;
}

Rc Database::createProfile(const QString& name) {
    const char op[] = "Database::createProfile";

    QSqlQuery query;
    bool ok = query.prepare("INSERT INTO player_profiles (name) VALUES (:name)");
    if (!ok) {
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }

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

Rc Database::deleteProfile(quint64 id) {
    const char op[] = "Database::deleteProfile";

    QSqlQuery query;
    bool ok = query.prepare("DELETE FROM player_profiles WHERE id = :id");
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
        lwarn(op) << "profile not found: " << id;
        return Rc::ErrNotFound;
    }
    return Rc::Ok;
}

Rc Database::getGameHistory(QVector<models::GameRecord>& games, const QString& sortBy) {
    const char op[] = "Database::getGameHistory";

    QString orderBy = "gr.created_at DESC";
    if (sortBy == "played_at") {
        orderBy = "gr.played_at DESC";
    }

    QSqlQuery query;
    bool ok = query.exec(QString("SELECT "
                                 "gr.id, "
                                 "gr.player1_profile_id, p1.name, gr.player1_hero_id, h1.name, "
                                 "gr.player2_profile_id, p2.name, gr.player2_hero_id, h2.name, "
                                 "gr.map_id, m.name, "
                                 "gr.player1_won, "
                                 "gr.hero1_remaining_hp, gr.hero2_remaining_hp, "
                                 "gr.played_at, gr.created_at "
                                 "FROM game_records gr "
                                 "JOIN player_profiles p1 ON p1.id = gr.player1_profile_id "
                                 "JOIN heroes h1 ON h1.id = gr.player1_hero_id "
                                 "JOIN player_profiles p2 ON p2.id = gr.player2_profile_id "
                                 "JOIN heroes h2 ON h2.id = gr.player2_hero_id "
                                 "LEFT JOIN maps m ON m.id = gr.map_id "
                                 "ORDER BY %1")
                             .arg(orderBy));
    if (!ok) {
        lwarn(op) << "sql error: " << query.lastError().text();
        return Rc::ErrExecQuery;
    }

    while (query.next()) {
        models::GameRecord game;
        game.id = query.value(0).toString();
        game.player1.profileId = query.value(1).toULongLong();
        game.player1.profileName = query.value(2).toString();
        game.player1.heroId = query.value(3).toULongLong();
        game.player1.heroName = query.value(4).toString();
        game.player2.profileId = query.value(5).toULongLong();
        game.player2.profileName = query.value(6).toString();
        game.player2.heroId = query.value(7).toULongLong();
        game.player2.heroName = query.value(8).toString();
        game.mapId = query.value(9);
        game.mapName = query.value(10);
        game.player1Won = query.value(11);
        game.player1.heroRemainingHp = query.value(12);
        game.player2.heroRemainingHp = query.value(13);
        game.playedAt = query.value(14);
        game.createdAt = query.value(15).toString();
        games.append(std::move(game));
    }

    return Rc::Ok;
}

Rc Database::createGameRecord(const models::GameRecordInput& game) {
    const char op[] = "Database::createGameRecord";

    QSqlQuery query;
    bool ok = query.prepare("INSERT INTO game_records ("
                            "id, "
                            "player1_profile_id, player1_hero_id, "
                            "player2_profile_id, player2_hero_id, "
                            "map_id, player1_won, "
                            "hero1_remaining_hp, hero2_remaining_hp, played_at"
                            ") VALUES ("
                            ":id, "
                            ":player1_profile_id, :player1_hero_id, "
                            ":player2_profile_id, :player2_hero_id, "
                            ":map_id, :player1_won, "
                            ":hero1_remaining_hp, :hero2_remaining_hp, :played_at"
                            ")");
    if (!ok) {
        lwarn(op) << "sql prepare error: " << query.lastError().text();
        return Rc::ErrPrepareQuery;
    }

    query.bindValue(":id", QUuid::createUuid().toString(QUuid::WithoutBraces));
    query.bindValue(":player1_profile_id", game.player1.profileId);
    query.bindValue(":player1_hero_id", game.player1.heroId);
    query.bindValue(":player2_profile_id", game.player2.profileId);
    query.bindValue(":player2_hero_id", game.player2.heroId);
    query.bindValue(":map_id", game.mapId);
    query.bindValue(":player1_won", game.player1Won);
    query.bindValue(":hero1_remaining_hp", game.player1.heroRemainingHp);
    query.bindValue(":hero2_remaining_hp", game.player2.heroRemainingHp);
    query.bindValue(":played_at", game.playedAt.isEmpty() ? QVariant() : QVariant(game.playedAt));

    if (!query.exec()) {
        lwarn(op) << "sql exec error: " << query.lastError().text();
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
