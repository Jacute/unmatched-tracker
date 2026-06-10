#ifndef BACKHANDLER_H
#define BACKHANDLER_H

#include <QAbstractNativeEventFilter>
#include <QKeyEvent>
#include <QObject>

class BackHandler : public QObject, public QAbstractNativeEventFilter {
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)

  public:
    explicit BackHandler(QObject *parent = nullptr);
    ~BackHandler();

    bool enabled() const {
        return m_enabled;
    }
    void setEnabled(bool enabled);

    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) override;

  signals:
    void backPressed();
    void enabledChanged();

  private:
    bool m_enabled;
    bool handleBackButton();
};

#endif // BACKHANDLER_H