#include "config.h"

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>

Config::Config(const QString &path) {
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Can't open file";
        return;
    }
    QByteArray data = file.readAll();
    file.close();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    
    QJsonObject obj = doc.object();
    QJsonObject dbObj = obj["db"].toObject();

    db.dbName_ = dbObj["name"].toString();  
    for (const QJsonValue &v : dbObj["migrations"].toArray()) {
        db.migrationFiles.append(v.toString());
    }
}