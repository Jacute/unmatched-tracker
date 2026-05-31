#pragma once

#include "../rc.h"
#include "../models.h"

#include <QObject>
#include <QSqlDatabase>
#include <QVector>

class Database : public QObject
{
public:
    Database(const QString &dbPath, const QString &dbName);

    Rc open();
    void close();

    void migrate(QVector<QString> migrationFiles);

    Rc getHeroes(QVector<models::Hero> &heroes);
    Rc getSets(QVector<models::GameSet> &sets);
    Rc getMaps(QVector<models::GameMap> &maps);
private:
    Rc executeSqlFile(const QString &path);

    QSqlDatabase db;
    QString dbPath_;
    QString dbName_;
};