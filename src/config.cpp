#include "config.h"
#include "log.h"

#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

Config::Config(const Logger& logger, const QString& path)
    : logger_(logger) {
    const char op[] = "Config::Config";

    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        logger_.warning(op, "can't open config file", {{"path", path}});
        return;
    }
    QByteArray data = file.readAll();
    logger_.debug(op, "config loaded", {{"path", path}});
    file.close();
    QJsonDocument doc = QJsonDocument::fromJson(data);

    QJsonObject obj = doc.object();
    assetsBaseUrl = obj["assets_base_url"].toString();
    cachePath = obj["cache_path"].toString();
    QJsonObject dbObj = obj["db"].toObject();

    db.dbName_ = dbObj["name"].toString();
    for (const QJsonValue& v : dbObj["migrations"].toArray()) {
        db.migrationFiles.append(v.toString());
    }
}

QDebug operator<<(QDebug debug, const Config& config) {
    QJsonArray migrations;
    for (const QString& migration : config.db.migrationFiles) {
        migrations.append(migration);
    }

    QJsonObject db;
    db.insert("name", config.db.dbName_);
    db.insert("migrations", migrations);

    QJsonObject data;
    data.insert("db", db);
    data.insert("assets_base_url", config.assetsBaseUrl);
    data.insert("cache_path", config.cachePath);

    QDebugStateSaver saver(debug);
    debug.noquote().nospace()
        << QString::fromUtf8(QJsonDocument(data).toJson(QJsonDocument::Compact));
    return debug;
}
