#pragma once

#include "../db/db.h"
#include "../models.h"

#include <QObject>
#include <QVariantMap>
#include <QVector>

class Core : public QObject {
    Q_OBJECT

  public:
    explicit Core(Database &db, QObject *parent = nullptr);

    Q_INVOKABLE QVariantList getSets() const;
    Q_INVOKABLE QVariantList getHeroes() const;
    Q_INVOKABLE QVariantList getHeroesBySetId(quint64 setId) const;
    Q_INVOKABLE QVariantList getMaps() const;
    Q_INVOKABLE QVariantList getSHM() const;
    Q_INVOKABLE QVariantList getCardsByHeroId(quint64 heroId) const;
    Q_INVOKABLE QVariantList getProfiles() const;
    Q_INVOKABLE QVariantMap createProfile(const QString &name);
    Q_INVOKABLE QVariantMap deleteProfile(quint64 id);

  private:
    Database &db_;
};
