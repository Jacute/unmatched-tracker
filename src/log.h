#pragma once

#include <QString>
#include <QVariantMap>

enum LogLevel {
    DEBUG,
    INFO,
    WARNING,
    ERROR
};

class Logger {
  public:
    Logger(LogLevel level);
    ~Logger() = default;

    void debug(const char* tag, const QString& msg, const QVariantMap& args = {}) const;
    void info(const char* tag, const QString& msg, const QVariantMap& args = {}) const;
    void warning(const char* tag, const QString& msg, const QVariantMap& args = {}) const;
    void error(const char* tag, const QString& msg, const QVariantMap& args = {}) const;
    void error(const char* tag,
               const QString& msg,
               const QString& error,
               const QVariantMap& args = {}) const;

  private:
    LogLevel level_;

    void log(
        const char* tag,
        const QString& msg,
        LogLevel level = LogLevel::INFO,
        const QVariantMap& args = {}
    ) const;
};
