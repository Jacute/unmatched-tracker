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
} // namespace models