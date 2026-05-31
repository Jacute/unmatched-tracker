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