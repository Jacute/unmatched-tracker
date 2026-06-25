#include "core.h"
#include "../log.h"
#include "errors.h"

#include <QPointer>

Core::Core(Database& db, FileProvider* fp)
    : db_(db),
      provider_(fp),
      QObject(nullptr) {
    imageThreadPool_.setMaxThreadCount(6);
};

static QVariantList mapHeroesQml(const QVector<models::Hero>& heroes) {
    QVariantList list;
    for (const auto& h : heroes) {
        QVariantMap obj;
        obj["id"] = h.id;
        obj["name"] = std::move(h.name);
        obj["img_path"] = std::move(h.imgPath);
        obj["set_id"] = h.setId;

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Core::getHeroes() const {
    const char op[] = "Core::getHeroes";

    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroes(heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "heroes got from db";

    return mapHeroesQml(heroes);
}

QVariantList Core::getHeroesBySetId(quint64 setId) const {
    const char op[] = "Core::getHeroesBySetId";

    linfo(op) << "getting heroes by set id";
    QVector<models::Hero> heroes;
    Rc rc = db_.getHeroesBySetId(setId, heroes);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    linfo(op) << "heroes by set id got successfully";

    return mapHeroesQml(heroes);
}

QVariantList Core::getMaps() const {
    const char op[] = "Core::getMaps";

    QVector<models::GameMap> maps;
    Rc rc = db_.getMaps(maps);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "heroes got from db";

    QVariantList list;
    for (const auto& m : maps) {
        QVariantMap obj;
        obj["id"] = m.id;
        obj["name"] = std::move(m.name);
        obj["img_path"] = std::move(m.imgPath);
        obj["set_id"] = m.setId;

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Core::getSets() const {
    const char op[] = "Core::getSets";

    QVector<models::GameSetShort> sets;
    Rc rc = db_.getSets(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "short sets got from db";

    QVariantList list;
    for (const auto& s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = std::move(s.name);
        obj["img_path"] = std::move(s.imgPath);

        list.append(std::move(obj));
    }
    return list;
}

QVariantList Core::getSHM() const {
    const char op[] = "Core::getSHM";

    QVector<models::GameSet> sets;
    Rc rc = db_.getSHM(sets);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "sets got from db";

    QVariantList list;
    for (const auto& s : sets) {
        QVariantMap obj;
        obj["id"] = s.id;
        obj["name"] = std::move(s.name);
        obj["img_path"] = std::move(s.imgPath);
        obj["released_at"] = std::move(s.releasedAt);

        QVariantList heroes;
        for (const auto& h : s.heroes) {
            QVariantMap hObj;
            hObj["id"] = h.id;
            hObj["name"] = std::move(h.name);
            hObj["img_path"] = std::move(h.imgPath);
            heroes.append(std::move(hObj));
        }
        obj["heroes"] = std::move(heroes);

        QVariantList maps;
        for (const auto& m : s.maps) {
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

QVariantList Core::getCardsByHeroId(quint64 heroId) const {
    const char op[] = "Core::getCardsByHeroId";

    QVector<models::Card> cards;
    Rc rc = db_.getCardsByHeroId(heroId, cards);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "cards by hero id got from db";

    QVariantList list;
    for (const auto& c : cards) {
        QVariantMap obj;
        obj["id"] = c.id;
        obj["name"] = c.name;
        obj["description"] = c.description;
        obj["count"] = c.count;
        obj["img_path"] = c.imgPath;
        obj["hero_id"] = c.heroId;
        obj["card_type_id"] = c.cardTypeId;
        list.append(obj);
    }
    return list;
}

QVariantList Core::getProfiles() const {
    const char op[] = "Core::getProfiles";

    QVector<models::PlayerProfile> profiles;
    Rc rc = db_.getProfiles(profiles);
    if (rc != Rc::Ok) {
        return QVariantList{};
    }
    ldebug(op) << "profiles got from db";

    QVariantList list;
    for (const auto& p : profiles) {
        QVariantMap obj;
        obj["id"] = p.id;
        obj["name"] = p.name;
        obj["created_at"] = p.createdAt;
        list.append(std::move(obj));
    }
    return list;
}

QVariantMap Core::createProfile(const QString& name) const {
    const char op[] = "Core::createProfile";
    QVariantMap result;
    result["ok"] = false;

    const QString trimmedName = name.trimmed();
    if (trimmedName.isEmpty()) {
        lwarn(op) << "profile name is empty";
        result["error"] = err_profile::EmptyName;
        return result;
    }

    if (trimmedName.size() > 256) {
        lwarn(op) << "profile name is long";
        result["error"] = err_profile::NameTooLong;
        return result;
    }

    Rc rc = db_.createProfile(trimmedName);
    switch (rc) {
    case Rc::Ok:
        result["ok"] = true;
        result["error"] = err::None;
        break;
    case Rc::ErrDuplicate:
        result["error"] = err_profile::DuplicateName;
        break;
    default:
        result["error"] = err::DbError;
        break;
    }
    return result;
}

QVariantMap Core::deleteProfile(quint64 id) const {
    const char op[] = "Core::deleteProfile";
    QVariantMap result;
    result["ok"] = false;

    Rc rc = db_.deleteProfile(id);
    // TODO: refactor this -> throw error events to frontend using signal
    switch (rc) {
    case Rc::Ok:
        linfo(op) << "profile with id " << id << " successfully deleted";
        result["ok"] = true;
        result["error"] = err::None;
        break;
    case Rc::ErrNotFound:
        lerr(op) << "error profile not found: " << id;
        result["error"] = err_profile::NotFound;
        break;
    default:
        result["error"] = err::DbError;
        break;
    }

    return result;
}

QString Core::getImage(const QString& path) const {
    const char op[] = "Core::getImage";
    QString sourceUrl;
    Rc rc = provider_->get(path, sourceUrl);
    if (rc != Rc::Ok) {
        lerr(op) << "error getting image: " << path;
        // TODO: throw error event to fronted using signal
        return ""; // TODO: add placeholder image
    }
    linfo(op) << "image got successfully url=" << sourceUrl;
    return sourceUrl;
}

void Core::requestImage(const QString& path) {
    QPointer<Core> self(this);
    FileProvider* provider = provider_;

    imageThreadPool_.start([self, provider, path]() {
        QString sourceUrl;
        Rc rc = provider->get(path, sourceUrl);

        if (!self) {
            return;
        }

        QMetaObject::invokeMethod(
            self,
            [self, path, sourceUrl, rc]() {
                if (!self) {
                    return;
                }

                if (rc != Rc::Ok) {
                    lerr("Core::requestImage") << "error getting image: " << path;
                    emit self->imageFailed(path);
                    return;
                }

                linfo("Core::requestImage") << "image got successfully url=" << sourceUrl;
                emit self->imageReady(path, sourceUrl);
            },
            Qt::QueuedConnection);
    });
}
