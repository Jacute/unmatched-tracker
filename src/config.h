#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVector>

struct DatabaseConfig {
    QString dbName_;
    QVector<QString> migrationFiles;
};

class Config {
  public:
    Config(const QString& path);
    ~Config() = default;

    DatabaseConfig db;
    QString assetsBaseUrl;
    QString cachePath;
};

QDebug operator<<(QDebug debug, const Config& config);
