#pragma once

#include "../db/db.h"
#include "../models.h"
#include "db_exporter.h"
#include "fileprovider.h"

#include <QHash>
#include <QObject>
#include <QSet>
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
    Q_INVOKABLE QVariantMap getProfileStats(const QString& profileId,
                                            const QString& gameMode) const;
    Q_INVOKABLE QString getDefaultProfileId() const;
    Q_INVOKABLE QVariantMap setDefaultProfileId(const QString& profileId) const;
    Q_INVOKABLE QVariantMap createProfile(const QString& name) const;
    Q_INVOKABLE QVariantMap deleteProfile(const QString& id) const;
    Q_INVOKABLE QVariantList getGameHistory(const QString& sortBy,
                                            quint32 limit,
                                            quint32 offset) const;
    Q_INVOKABLE QVariantMap createGameRecord(const QVariantMap& game) const;
    Q_INVOKABLE QVariantMap deleteGameRecord(const QString& id) const;

    // @brief Get image from storage/api (sync)
    // @param[in] path Http path of file in REST api
    // @return Return url - Local url of file which starts with file://
    Q_INVOKABLE QString getImage(const QString& path) const;
    // @brief Get image from storage/api (async). Url of file returns in signal.
    // @param[in] path Http path of file in REST api
    Q_INVOKABLE void requestImage(const QString& path);

    // @brief Get image from storage/api (async). Url of file returns in signal.
    // @param[in] to Url where the file will be uploaded. Starts with content://
    Q_INVOKABLE QVariantMap exportDb(const QUrl& to) const;

    Q_INVOKABLE QVariantMap saveRandomizerConfig(const QVariantList& heroes,
                                                 const QVariantList& maps) const;
    Q_INVOKABLE QVariantMap loadRandomizerConfig() const;

    // @brief Get version and source revision used to build the application.
    Q_INVOKABLE QVariantMap getBuildInfo() const;

  signals:
    // @brief Signal of successfully loaded image
    // @param[out] path Http path of file in REST api
    // @param[out] sourceUrl Local url of file which starts with file://
    void imageReady(const QString& path, const QString& sourceUrl);
    // @brief Signal of failed image loading
    // @param[out] path Http path of file in REST api
    void imageFailed(const QString& path);

  private:
    Database& db_;
    DbExporter& dbExporter_;
    FileProvider* provider_;
    QThreadPool imageThreadPool_; // threads for loading images
    QSet<QString> pendingImages_; // set of images is loading now
};
