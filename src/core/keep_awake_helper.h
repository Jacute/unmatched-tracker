#ifndef KEEPAWAKEHELPER_H

#define KEEPAWAKEHELPER_H

#include <QCoreApplication>
#include <QJniObject>

#include "../log.h"

class KeepAwakeHelper : public QObject {
    Q_OBJECT
  public:
    explicit KeepAwakeHelper(const Logger& logger) : logger_(logger) {}
    ~KeepAwakeHelper() = default;
    KeepAwakeHelper(KeepAwakeHelper&) = delete;
    KeepAwakeHelper& operator=(KeepAwakeHelper&) = delete;
    KeepAwakeHelper(KeepAwakeHelper&&) = delete;
    KeepAwakeHelper& operator=(KeepAwakeHelper&&) = delete;

    Q_INVOKABLE void enable() const;
    Q_INVOKABLE void disable() const;

  private:
    void set(bool enabled) const;
    bool isKeepScreenOn() const;
    const Logger& logger_;
};

#endif // KEEPAWAKEHELPER_H
