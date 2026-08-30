#pragma once

#include <QObject>
#include <QString>
#include <QVariantMap>

enum LogLevel {
    DEBUG,
    INFO,
    WARNING,
    ERROR
};

class Logger : public QObject {
    Q_OBJECT

  public:
    Logger(LogLevel level);
    ~Logger() = default;

    Q_INVOKABLE void debug(const QString& tag, const QString& msg, const QVariantMap& args = {}) const;
    Q_INVOKABLE void info(const QString& tag, const QString& msg, const QVariantMap& args = {}) const;
    Q_INVOKABLE void warning(const QString& tag, const QString& msg, const QVariantMap& args = {}) const;
    Q_INVOKABLE void error(const QString& tag, const QString& msg, const QVariantMap& args = {}) const;
    void error(const QString& tag,
               const QString& msg,
               const QString& error,
               const QVariantMap& args = {}) const;

  private:
    LogLevel level_;

    void log(
        const QString& tag,
        const QString& msg,
        LogLevel level = LogLevel::INFO,
        const QVariantMap& args = {}
    ) const;
};
