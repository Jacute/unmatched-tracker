#pragma once

#include "../db/db.h"
#include "../models.h"

#include <QObject>
#include <QVector>

class Backend : public QObject {
    Q_OBJECT

public:
    explicit Backend(Database &db, QObject *parent = nullptr);

    Q_INVOKABLE QVariantList getHeroes();
    Q_INVOKABLE QVariantList getMaps();
    // Q_INVOKABLE QVector<models::GameSet> getSets();

private:
    Database &db_;
};