#include "db.h"
#include "../log.h"
#include "../rc.h"

#include <QDebug>
#include <QDir>
#include <QSqlError>
#include <QSqlQuery>
#include <QStandardPaths>

Database::Database(const QString &dbPath, const QString &dbName)
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

Rc Database::getHeroes(QVector<models::Hero> &heroes) {
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

Rc Database::getHeroesBySetId(quint64 setId, QVector<models::Hero> &heroes) {
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

Rc Database::getMaps(QVector<models::GameMap> &maps) {
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

Rc Database::getSets(QVector<models::GameSetShort> &sets) {
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

Rc Database::getSHM(QVector<models::GameSet> &sets) {
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

Rc Database::getCardsByHeroId(quint64 heroId, QVector<models::Card> &cards) {
    const char op[] = "Database::getCardsByHeroId";

    QSqlQuery query;

    bool ok = query.prepare("SELECT id, name, description, count, img_path, hero_id, card_type_id "
                            "FROM cards WHERE hero_id = :heroId");
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