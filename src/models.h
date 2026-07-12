#pragma once

#include <cstdint>
#include <memory>

#include <QDate>
#include <QDebug>
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
    quint8 hp;
    quint8 move;
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

struct GameRecordParticipantInput {
    quint8 position;
    quint8 team;
    quint64 profileId;
    quint64 heroId;
    QVariant heroRemainingHp;
};

inline QDebug operator<<(QDebug debug, const GameRecordParticipantInput& participant) {
    QDebugStateSaver saver(debug);
    debug.nospace() << "GameRecordParticipantInput(position="
                    << static_cast<quint32>(participant.position)
                    << ", team=" << static_cast<quint32>(participant.team)
                    << ", profileId=" << participant.profileId << ", heroId=" << participant.heroId
                    << ", heroRemainingHp=" << participant.heroRemainingHp << ')';
    return debug;
}

struct GameRecordParticipant {
    quint8 position;
    quint8 team;
    quint64 profileId;
    QString profileName;
    quint64 heroId;
    QString heroName;
    QString heroImgPath;
    QVariant heroRemainingHp;
};

struct GameRecordInput {
    QString mode;
    QVector<GameRecordParticipantInput> participants;
    QVariant mapId;
    quint8 winningTeam;
    QString playedAt;
};

struct GameRecord {
    QString id;
    QString mode;
    QVector<GameRecordParticipant> participants;
    QVariant mapId;
    QVariant mapName;
    quint8 winningTeam;
    QVariant playedAt;
    QString createdAt;
};
} // namespace models
