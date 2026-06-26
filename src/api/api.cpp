#include "api.h"

#include "../log.h"
#include "../rc.h"

#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTimer>
#include <QUrl>

namespace {
constexpr int requestTimeoutMs = 4000;

QUrl buildUrl(const QString& baseUrl, const QString& path) {
    const QUrl absoluteUrl(path);
    if (absoluteUrl.isValid() && !absoluteUrl.scheme().isEmpty()) {
        return absoluteUrl;
    }

    QString url = baseUrl;
    if (!path.isEmpty()) {
        if (url.endsWith('/') && path.startsWith('/')) {
            url.chop(1);
        } else if (!url.endsWith('/') && !path.startsWith('/')) {
            url += '/';
        }
        url += path;
    }

    return QUrl(url);
}

bool isValidImageContentType(const QString& contentType) {
    const QString normalized = contentType.section(';', 0, 0).trimmed().toLower();
    return normalized == "image/jpeg" || normalized == "image/png" || normalized == "image/webp" ||
           normalized == "image/gif";
}
} // namespace

Api::Api(const QString& baseUrl)
    : baseUrl_(baseUrl) {
}

Api::~Api() = default;

Rc Api::get(const QString& path, QByteArray& out, QString& contentType, int& statusCode) const {
    const char op[] = "Api::get";
    const QUrl url = buildUrl(baseUrl_, path);
    if (!url.isValid() || url.scheme().isEmpty()) {
        lwarn(op) << "invalid asset url: " << url.toString();
        return Rc::ErrInvalidUrl;
    }

    // prepare request
    QNetworkAccessManager manager;
    QNetworkRequest request(url);
    request.setAttribute(QNetworkRequest::RedirectPolicyAttribute,
                         QNetworkRequest::NoLessSafeRedirectPolicy);
    request.setRawHeader("User-Agent", QByteArray("unmatched-tracker:") + QByteArray(APP_VERSION));

    QNetworkReply* reply = manager.get(request);
    QEventLoop loop;
    QTimer timeout;
    timeout.setSingleShot(true);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    QObject::connect(&timeout, &QTimer::timeout, reply, &QNetworkReply::abort);
    QObject::connect(&timeout, &QTimer::timeout, &loop, &QEventLoop::quit);

    // start request and timer
    timeout.start(requestTimeoutMs);
    loop.exec();
    if (!timeout.isActive()) {
        lwarn(op) << "request timed out: " << url.toString();
        reply->deleteLater();
        return Rc::ErrNetworkTimeout;
    }
    timeout.stop();

    statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    if (reply->error() != QNetworkReply::NoError) {
        lwarn(op) << "request failed: " << url.toString() << "status: " << statusCode
                  << "error: " << reply->errorString();
        reply->deleteLater();
        return Rc::ErrNetworkRequest;
    }

    contentType = reply->header(QNetworkRequest::ContentTypeHeader).toString();
    out = reply->readAll();
    reply->deleteLater();

    linfo(op) << "request success " << url.toString();

    return Rc::Ok;
}

Rc Api::getAsset(const QString& path, QByteArray& out) const {
    QString contentType;
    int statusCode;
    Rc rc = get(path, out, contentType, statusCode);
    if (rc != Rc::Ok) {
        return rc;
    }
    if (statusCode != 200) {
        return Rc::ErrInvalidStatusCode;
    }

    if (!isValidImageContentType(contentType)) {
        return Rc::ErrInvalidContentType;
    }

    // TODO: add check by MIME type

    return Rc::Ok;
}
