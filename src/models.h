#pragma once

#include <cstdint>
#include <memory>

#include <QDate>
#include <QString>
#include <QVariant>
#include <QVector>

namespace models {
struct GameSetShort {
    quint64 id;
    QString name;
    QString imgPath;
    QDate releasedAt;
};

struct Hero {
    quint64 id;
    QString name;
    QString imgPath;
    quint64 setId;
};

struct GameMap {
    quint64 id;
    QString name;
    quint64 setId;
    QString imgPath;
};

struct GameSet : public GameSetShort {
    QVector<Hero> heroes;
    QVector<GameMap> maps;
};

struct Card {
    quint64 id;
    QString name;
    QString description;
    quint64 count;
    QString imgPath;
    quint64 heroId;
    quint64 cardTypeId;
};

struct PlayerProfile {
    quint64 id;
    QString name;
    QString createdAt;
};

struct GameRecordPlayerInput {
    quint64 profileId;
    quint64 heroId;
    QVariant heroRemainingHp;
};

struct GameRecordPlayer {
    quint64 profileId;
    QString profileName;
    quint64 heroId;
    QString heroName;
    QVariant heroRemainingHp;
};

struct GameRecordInput {
    GameRecordPlayerInput player1;
    GameRecordPlayerInput player2;
    QVariant mapId;
    QVariant player1Won;
    QString playedAt;
};

struct GameRecord {
    QString id;
    GameRecordPlayer player1;
    GameRecordPlayer player2;
    QVariant mapId;
    QVariant mapName;
    QVariant player1Won;
    QVariant playedAt;
    QString createdAt;
};
} // namespace models
