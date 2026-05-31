#include "backend.h"


Backend::Backend(Database &db, QObject *parent)
    : db_(db), QObject(parent) {};

QVariantList Backend::getHeroes() {
    QVector<models::Hero> heroes {
        {1, "Dracula", "qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/heroes/dracula/avatar.webp", 1},
        {2, "Sherlock Holmes", "qrc:/qt/qml/Tracker/ui/assets/img/set/cobble_fog/heroes/sherlock_holmes/avatar.webp", 1}
    };

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