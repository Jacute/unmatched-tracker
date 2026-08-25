#include "api.h"

#include "../log.h"
#include "../rc.h"

#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTimer>
#include <QUrl>

namespace {
constexpr int requestTimeoutMs = 30000;
const char* timeoutProperty = "timedOut";

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

QTimer* replyWithTimeout(QNetworkReply* reply) {
    QTimer* timer = new QTimer(reply);
    timer->setSingleShot(true);
    timer->start(requestTimeoutMs);
    QObject::connect(
        timer,
        &QTimer::timeout,
        timer,
        [reply] {
            reply->setProperty(timeoutProperty, true);
            reply->abort();
        }
    );
    return timer;
}
} // namespace

Api::Api(const QString& baseUrl)
    : baseUrl_(baseUrl), manager_() {
}

Api::~Api() = default;

void Api::get(
    const QUrl& url,
    ReqFinishedCallback onFinished
) {
    // prepare request
    QNetworkRequest request(url);
    request.setAttribute(QNetworkRequest::RedirectPolicyAttribute,
                         QNetworkRequest::NoLessSafeRedirectPolicy);
    request.setRawHeader("User-Agent", QByteArray("unmatched-tracker:") + QByteArray(APP_VERSION));

    // send request
    QNetworkReply* reply = manager_.get(request);
    QTimer* timer = replyWithTimeout(reply);

    QObject::connect(
        reply,
        &QNetworkReply::finished,
        reply,
        [
            timer,
            reply,
            onFinished = std::move(onFinished)
        ] {
            timer->stop();
            onFinished(reply);
        }
    );
}

void Api::getAsset(
    const QString& path,
    AssetCallback onFinished
) {
    const char op[] = "Api::getAsset";
    const QUrl url = buildUrl(baseUrl_, path);
    if (!url.isValid() || url.scheme().isEmpty()) {
        onFinished("", Rc::ErrInvalidUrl);
        return;
    }

    get(
        url,
        [
            url = std::move(url),
            onFinished = std::move(onFinished)
        ](QNetworkReply* reply) {
            reply->deleteLater();

            const int statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
            if (reply->error() != QNetworkReply::NoError) {
                if (reply->property(timeoutProperty).toBool()) {
                    onFinished(QByteArray(), Rc::ErrNetworkTimeout);
                    return;
                }
                onFinished(QByteArray(), Rc::ErrNetworkRequest);
                return;
            }
            if (statusCode != 200) {
                onFinished(QByteArray(), Rc::ErrInvalidStatusCode);
                return;
            }

            const QString contentType = reply->header(QNetworkRequest::ContentTypeHeader).toString();
            if (!isValidImageContentType(contentType)) {
                onFinished(QByteArray(), Rc::ErrInvalidContentType);
                return;
            }

            // TODO: add check by MIME type
            
            onFinished(std::move(reply->readAll()), Rc::Ok);
        }
    );
}
