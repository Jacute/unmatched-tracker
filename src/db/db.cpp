#include "db.h"
#include "../rc.h"
#include "../log.h"

#include <QDir>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QStandardPaths>

Database::Database(const QString &dbPath, const QString &dbName)
    : dbPath_(dbPath), dbName_(dbName) {

}

Rc Database::open() {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath_);

    if (!db.open()) {
        qDebug() << "DB error:"
                 << db.lastError().text();
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
        return Rc::ErrCantExecQuery;
    }

    while (query.next()) {
        models::Hero hero;
        hero.id = query.value(0).toUInt();
        hero.name = query.value(1).toString();
        hero.setId = query.value(2).toUInt();
        hero.imgPath = query.value(3).toString();
        heroes.append(std::move(hero));
    }
    return Rc::Ok;
}

