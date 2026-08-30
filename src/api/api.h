#ifndef API_H
#define API_H

#include "../rc.h"
#include "../log.h"

#include <QByteArray>
#include <QString>
#include <QNetworkAccessManager>

#include <functional>

class Api {
  public:
    using AssetCallback = std::function<void(QByteArray, Rc)>;
    using ReqFinishedCallback = std::function<void(QNetworkReply*, Rc)>;

  private:
    QString baseUrl_;
    QNetworkAccessManager manager_;
    const Logger& logger_;

    void get(
        const QUrl& url,
        ReqFinishedCallback onFinished
    );

  public:
    Api(const Logger& logger, const QString& baseUrl);
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
