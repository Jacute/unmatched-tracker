#pragma once

#include <cstdint>

#include <QString>

namespace models {
    struct GameSet {
        quint64 id;
        QString name;
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
} // namespace models