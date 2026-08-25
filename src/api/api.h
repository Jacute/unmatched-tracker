#ifndef API_H
#define API_H

#include "../rc.h"

#include <QByteArray>
#include <QString>
#include <QNetworkAccessManager>

#include <functional>

class Api {
  public:
    using AssetCallback = std::function<void(QByteArray, Rc)>;
    using ReqFinishedCallback = std::function<void(QNetworkReply*)>;

  private:
    QString baseUrl_;
    QNetworkAccessManager manager_;

    void get(
        const QUrl& url,
        ReqFinishedCallback onFinished
    );

  public:
    Api(const QString& baseUrl);
    ~Api();

    Api(const Api&) = delete;
    Api& operator=(const Api&) = delete;
    Api(Api&&) = delete;
    Api& operator=(Api&&) = delete;

    void getAsset(
        const QString& path,
        AssetCallback onFinished
    );
};

#endif
