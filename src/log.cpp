#include "log.h"

#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

namespace {
void writeLog(LogLevel level, const QString& message) {
    switch (level) {
    case LogLevel::DEBUG:
        qDebug().noquote().nospace() << message;
        break;
    case LogLevel::INFO:
        qInfo().noquote().nospace() << message;
        break;
    case LogLevel::WARNING:
        qWarning().noquote().nospace() << message;
        break;
    case LogLevel::ERROR:
        qCritical().noquote().nospace() << message;
        break;
    }
}
} // namespace

Logger::Logger(LogLevel level)
    : level_(level) {
}

void Logger::log(
    const QString& tag,
    const QString& msg,
    LogLevel level,
    const QVariantMap& args
) const {
    if (level < level_) {
        return;
    }
    QVariantMap logMap = args;
    logMap.insert("message", msg);
    logMap.insert("op", tag);

    const QByteArray json =
        QJsonDocument(QJsonObject::fromVariantMap(logMap)).toJson(QJsonDocument::Compact);
    writeLog(level, QString::fromUtf8(json));
}

void Logger::debug(const QString& tag, const QString& msg, const QVariantMap& args) const {
    log(tag, msg, LogLevel::DEBUG, args);
}

void Logger::info(const QString& tag, const QString& msg, const QVariantMap& args) const {
    log(tag, msg, LogLevel::INFO, args);
}

void Logger::warning(const QString& tag, const QString& msg, const QVariantMap& args) const {
    log(tag, msg, LogLevel::WARNING, args);
}

void Logger::error(const QString& tag, const QString& msg, const QVariantMap& args) const {
    log(tag, msg, LogLevel::ERROR, args);
}

void Logger::error(
    const QString& tag,
    const QString& msg,
    const QString& error,
    const QVariantMap& args
) const {
    QVariantMap context = args;
    context.insert("error", error);
    log(tag, msg, LogLevel::ERROR, context);
}
