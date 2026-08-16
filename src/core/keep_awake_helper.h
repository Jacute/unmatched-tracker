#ifndef KEEPAWAKEHELPER_H

#define KEEPAWAKEHELPER_H

#include <QCoreApplication>
#include <QJniObject>

class KeepAwakeHelper : public QObject {
    Q_OBJECT
  public:
    KeepAwakeHelper() = default;
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
};

#endif // KEEPAWAKEHELPER_H
