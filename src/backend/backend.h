#pragma once

#include "../db/db.h"
#include "../models.h"

#include <QObject>
#include <QVector>

class Backend : public QObject {
    Q_OBJECT

  public:
    explicit Backend(Database &db, QObject *parent = nullptr);

    Q_INVOKABLE QVariantList getSets() const;
    Q_INVOKABLE QVariantList getHeroes() const;
    Q_INVOKABLE QVariantList getHeroesBySetId(quint64 setId) const;
    Q_INVOKABLE QVariantList getMaps() const;
    Q_INVOKABLE QVariantList getSHM() const;
    Q_INVOKABLE QVariantList getCardsByHeroId(quint64 heroId) const;

  private:
    Database &db_;
};