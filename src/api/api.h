#ifndef API_H
#define API_H

#include <QByteArray>
#include <QString>

class Api {
  private:
    QString assetsBaseUrl_;

    QByteArray get(const QString &path);

  public:
    Api(const QString &assetsBaseUrl);
    ~Api();

    Api(const Api &) = delete;
    Api &operator=(const Api &) = delete;
    Api(Api &&) = delete;
    Api &operator=(Api &&) = delete;

    size_t getAsset(const QString &path, char *out);
};

#endif
