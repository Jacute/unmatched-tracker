#include "backend.h"
#include "../log.h"

Backend::Backend(Database &db, QObject *parent)
    : db_(db),
      QObject(parent){};

static QVariantList mapHeroesQml(const QVector<models::Hero> &heroes) {
    QVariantList list;
    for (const auto &h : heroes) {
        QVariantMap obj;
        obj["id"] = h.id;
        obj["name"] = std::move(h.name);
        obj["img_path"] = std::move(h.imgPath);
        obj["set_id"] = h.setId;

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Backend::getHeroes() const {
    const char op[] = "Backend::getHeroes";

    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroes(heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "heroes got from db";

    return mapHeroesQml(heroes);
}

QVariantList Backend::getHeroesBySetId(quint64 setId) const {
    const char op[] = "Backend::getHeroesBySetId";

    linfo(op) << "getting heroes by set id";
    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroesBySetId(setId, heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    linfo(op) << "heroes by set id got successfully";

    return mapHeroesQml(heroes);
}

QVariantList Backend::getMaps() const {
    const char op[] = "Backend::getMaps";

    QVector<models::GameMap> maps;
    Rc rc = db_.getMaps(maps);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "heroes got from db";

    QVariantList list;
    for (const auto &m : maps) {
        QVariantMap obj;
        obj["id"] = m.id;
        obj["name"] = std::move(m.name);
        obj["img_path"] = std::move(m.imgPath);
        obj["set_id"] = m.setId;

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Backend::getSets() const {
    const char op[] = "Backend::getSets";

    QVector<models::GameSetShort> sets;
    Rc rc = db_.getSets(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "short sets got from db";

    QVariantList list;
    for (const auto &s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = std::move(s.name);
        obj["img_path"] = std::move(s.imgPath);

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Backend::getSHM() const {
    const char op[] = "Backend::getSHM";

    QVector<models::GameSet> sets;
    Rc rc = db_.getSHM(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "sets got from db";

    QVariantList list;
    for (const auto &s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = std::move(s.name);
        obj["img_path"] = std::move(s.imgPath);
        obj["released_at"] = std::move(s.releasedAt);

        QVariantList heroes;
        for (const auto &h : s.heroes) {
            QVariantMap hObj;
            hObj["id"] = h.id;
            hObj["name"] = std::move(h.name);
            hObj["img_path"] = std::move(h.imgPath);
            heroes.append(std::move(hObj));
        }
        obj["heroes"] = std::move(heroes);

        QVariantList maps;
        for (const auto &m : s.maps) {
            QVariantMap mObj;
            mObj["id"] = m.id;
            mObj["name"] = std::move(m.name);
            mObj["img_path"] = std::move(m.imgPath);
            maps.append(std::move(mObj));
        }
        obj["maps"] = std::move(maps);

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Backend::getCardsByHeroId(quint64 heroId) const {
    const char op[] = "Backend::getCardsByHeroId";

    QVector<models::Card> cards;
    Rc rc = db_.getCardsByHeroId(heroId, cards);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "cards by hero id got from db";

    QVariantList list;
    for (const auto &c : cards) {
        QVariantMap obj;
        obj["id"] = c.id;
        obj["name"] = c.name;
        obj["description"] = c.description;
        obj["count"] = c.count;
        obj["img_path"] = c.imgPath;
        obj["hero_id"] = c.heroId;
        obj["card_type_id"] = c.cardTypeId;
    }
    return list;
}