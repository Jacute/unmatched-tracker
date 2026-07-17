#pragma once

#include "../models.h"
#include "../rc.h"

#include <QObject>
#include <QSqlDatabase>
#include <QVector>

class Database : public QObject {
  public:
    Database(const QString& dbPath, const QString& dbName);

    Rc open();
    void close();
    void migrate(const QVector<QString>& migrationFiles);

    // @brief Get all game sets
    // @param[out] sets Reference to vector with game sets
    // @return Return code
    Rc getSets(QVector<models::GameSetShort>& sets);
    // @brief Get all heroes
    // @param[out] heroes Reference to vector with heroes
    // @return Return code
    Rc getHeroes(QVector<models::Hero>& heroes);
    // @brief Get all maps
    // @param[out] maps Reference to vector with game maps
    // @return Return code
    Rc getMaps(QVector<models::GameMap>& maps);
    // @brief Get all sets, heroes and maps that refer to them
    // @param[out] sets Reference to vector with game sets
    // @return Return code
    Rc getSHM(QVector<models::GameSet>& sets);
    // @brief Get heroes by set id
    // @param[in] setId
    // @param[out] heroes Reference to vector with heroes
    // @return Return code
    Rc getHeroesBySetId(quint64 setId, QVector<models::Hero>& heroes);
    // @brief Get cards by hero id
    // @param[in] heroId
    // @param[out] cards Reference to vector with cards
    // @return Return code
    Rc getCardsByHeroId(quint64 heroId, QVector<models::Card>& cards);
    Rc getProfiles(QVector<models::PlayerProfile>& profiles);
    Rc getProfileStats(const QString& profileId,
                       const QString& gameMode,
                       models::ProfileStats& stats);
    Rc createProfile(const QString& name);
    Rc deleteProfile(const QString& id);
    Rc getGameHistory(QVector<models::GameRecord>& games,
                      const QString& sortBy,
                      quint32 limit,
                      quint32 offset);
    Rc createGameRecord(const models::GameRecordInput& game);
    Rc deleteGameRecord(const QString& id);

    QString path() const;

  private:
    Rc executeSqlFile(const QString& path);

    QSqlDatabase db;
    QString dbPath_;
    QString dbName_;
};

class ScopedDatabaseClose final {
  public:
    explicit ScopedDatabaseClose(Database& db);
    ~ScopedDatabaseClose();

    ScopedDatabaseClose(const ScopedDatabaseClose&) = delete;
    ScopedDatabaseClose& operator=(const ScopedDatabaseClose&) = delete;
    ScopedDatabaseClose(ScopedDatabaseClose&&) = delete;
    ScopedDatabaseClose& operator=(ScopedDatabaseClose&&) = delete;

  private:
    Database& db_;
};
