#include "db.h"
#include "../rc.h"

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

Rc Database::getMaps(QVector<models::GameMap> &maps) {
    return Rc::Ok;
}

