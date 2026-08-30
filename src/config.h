#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVector>

#include "log.h"

struct DatabaseConfig {
    QString dbName_;
    QVector<QString> migrationFiles;
};

class Config {
  public:
    Config(const Logger& logger, const QString& path);
    ~Config() = default;

    DatabaseConfig db;
    QString assetsBaseUrl;
    QString cachePath;

  private:
    const Logger& logger_;
};

QDebug operator<<(QDebug debug, const Config& config);
