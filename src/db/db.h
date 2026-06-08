#pragma once

#include "../models.h"
#include "../rc.h"

#include <QObject>
#include <QSqlDatabase>
#include <QVector>

class Database : public QObject {
  public:
    Database(const QString &dbPath, const QString &dbName);

    Rc open();
    void close();

    void migrate(const QVector<QString> &migrationFiles);

    Rc getSets(QVector<models::GameSetShort> &sets);
    Rc getHeroes(QVector<models::Hero> &heroes);
    Rc getMaps(QVector<models::GameMap> &maps);

    // @brief Get all sets, heroes and maps that refer to them
    // @param[out] Reference to vector with game sets
    // @return Return code
    Rc getSHM(QVector<models::GameSet> &sets);

  private:
    Rc executeSqlFile(const QString &path);

    QSqlDatabase db;
    QString dbPath_;
    QString dbName_;
};