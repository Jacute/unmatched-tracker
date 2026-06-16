#pragma once

#include <cstdint>
#include <memory>

#include <QDate>
#include <QString>
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
} // namespace models
