#ifndef API_H
#define API_H

#include "../rc.h"

#include <QByteArray>
#include <QString>

class Api {
  private:
    QString baseUrl_;

    Rc get(const QString& path, QByteArray& out, QString& contentType) const;

  public:
    Api(const QString& baseUrl);
    ~Api();

    Api(const Api&) = delete;
    Api& operator=(const Api&) = delete;
    Api(Api&&) = delete;
    Api& operator=(Api&&) = delete;

    Rc getAsset(const QString& path, QByteArray& out) const;
};

#endif
