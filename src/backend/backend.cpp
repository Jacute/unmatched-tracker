#include "backend.h"
#include "../log.h"


Backend::Backend(Database &db, QObject *parent)
    : db_(db), QObject(parent) {};

QVariantList Backend::getHeroes() {
    const char op[] = "Backend::getHeroes";

    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroes(heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "heroes got from db";

    QVariantList list;
    for (const auto &h : heroes) {
        QVariantMap obj;
        obj["id"] = h.id;
        obj["name"] = h.name;
        obj["img_path"] = h.imgPath;
        obj["set_id"] = h.setId;

        list.append(obj);
    }
    return list;
}

QVariantList Backend::getMaps() {
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
        obj["name"] = m.name;
        obj["img_path"] = m.imgPath;
        obj["set_id"] = m.setId;

        list.append(obj);
    }
    return list;
}

QVariantList Backend::getSets() {
    const char op[] = "Backend::getSets";

    QVector<models::GameSet> sets;
    Rc rc = db_.getSets(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "sets got from db";

    QVariantList list;
    for (const auto &s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = s.name;
        obj["img_path"] = s.imgPath;

        list.append(obj);
    }
    return list;
}