#pragma once

#include "../db/db.h"
#include "../models.h"
#include "db_exporter.h"
#include "fileprovider.h"

#include <QObject>
#include <QThreadPool>
#include <QVariantMap>
#include <QVector>

class Core : public QObject {
    Q_OBJECT

  public:
    explicit Core(Database&, DbExporter&, FileProvider*);
    ~Core() = default;
    Core(Core&) = delete;
    Core& operator=(Core&) = delete;
    Core(Core&&) = delete;
    Core& operator=(Core&&) = delete;

    Q_INVOKABLE QVariantList getSets() const;
    Q_INVOKABLE QVariantList getHeroes() const;
    Q_INVOKABLE QVariantList getHeroesBySetId(quint64 setId) const;
    Q_INVOKABLE QVariantList getMaps() const;
    Q_INVOKABLE QVariantList getSHM() const;
    Q_INVOKABLE QVariantList getCardsByHeroId(quint64 heroId) const;
    Q_INVOKABLE QVariantList getProfiles() const;
    Q_INVOKABLE QVariantMap createProfile(const QString& name) const;
    Q_INVOKABLE QVariantMap deleteProfile(quint64 id) const;
    Q_INVOKABLE QVariantList getGameHistory(const QString& sortBy) const;
    Q_INVOKABLE QVariantMap createGameRecord(const QVariantMap& game) const;
    Q_INVOKABLE QVariantMap deleteGameRecord(const QString& id) const;

    Q_INVOKABLE QString getImage(const QString& path) const;
    Q_INVOKABLE void requestImage(const QString& path);

    Q_INVOKABLE QVariantMap exportDb(const QUrl& to) const;

  signals:
    void imageReady(const QString& path, const QString& sourceUrl);
    void imageFailed(const QString& path);

  private:
    Database& db_;
    DbExporter& dbExporter_;
    FileProvider* provider_;
    QThreadPool imageThreadPool_;
};
