#include "api.h"

#include "../log.h"

#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTimer>
#include <QUrl>

#include <cstring>

namespace {
constexpr int requestTimeoutMs = 30000;

QUrl buildUrl(const QString &baseUrl, const QString &path) {
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
} // namespace

Api::Api(const QString &assetsBaseUrl)
    : assetsBaseUrl_(assetsBaseUrl) {
}

Api::~Api() = default;

QByteArray Api::get(const QString &path) {
    const char op[] = "Api::get";
    const QUrl url = buildUrl(assetsBaseUrl_, path);
    if (!url.isValid() || url.scheme().isEmpty()) {
        lwarn(op) << "invalid asset url: " << url.toString();
        return {};
    }

    QNetworkAccessManager manager;
    QNetworkRequest request(url);
    request.setAttribute(QNetworkRequest::RedirectPolicyAttribute,
                         QNetworkRequest::NoLessSafeRedirectPolicy);
    request.setRawHeader("User-Agent", "unmatched-tracker");

    QNetworkReply *reply = manager.get(request);
    QEventLoop loop;
    QTimer timeout;
    timeout.setSingleShot(true);

    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    QObject::connect(&timeout, &QTimer::timeout, reply, &QNetworkReply::abort);
    QObject::connect(&timeout, &QTimer::timeout, &loop, &QEventLoop::quit);

    timeout.start(requestTimeoutMs);
    loop.exec();

    if (!timeout.isActive()) {
        lwarn(op) << "request timed out: " << url.toString();
        reply->deleteLater();
        return {};
    }
    timeout.stop();

    const int statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    if (reply->error() != QNetworkReply::NoError || statusCode >= 400) {
        lwarn(op) << "request failed: " << url.toString() << "status: " << statusCode
                  << "error: " << reply->errorString();
        reply->deleteLater();
        return {};
    }

    const QByteArray data = reply->readAll();
    reply->deleteLater();
    return data;
}

size_t Api::getAsset(const QString &path, char *out) {
    if (out == nullptr) {
        return 0;
    }

    const QByteArray data = get(path);
    if (data.isEmpty()) {
        return 0;
    }

    std::memcpy(out, data.constData(), static_cast<size_t>(data.size()));
    return static_cast<size_t>(data.size());
}
