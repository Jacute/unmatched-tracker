#include "config.h"
#include "log.h"

#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

Config::Config(const QString &path) {
    const char op[] = "Config::Config";

    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        lwarn(op) << "Can't open file " << path;
        return;
    }
    QByteArray data = file.readAll();
    ldebug(op) << "config data " << data;
    file.close();
    QJsonDocument doc = QJsonDocument::fromJson(data);

    QJsonObject obj = doc.object();
    assetsBaseUrl = obj["assets_base_url"].toString();
    QJsonObject dbObj = obj["db"].toObject();

    db.dbName_ = dbObj["name"].toString();
    for (const QJsonValue &v : dbObj["migrations"].toArray()) {
        db.migrationFiles.append(v.toString());
    }
}