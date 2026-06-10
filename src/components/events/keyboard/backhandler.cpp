#include "backhandler.h"
#include "../../../log.h"

#include <QDebug>
#include <QGuiApplication>

BackHandler::BackHandler(QObject *parent)
    : QObject(parent),
      m_enabled(true) {
    qApp->installNativeEventFilter(this);
}

BackHandler::~BackHandler() {
    qApp->removeNativeEventFilter(this);
}

void BackHandler::setEnabled(bool enabled) {
    if (m_enabled != enabled) {
        m_enabled = enabled;
        emit enabledChanged();
    }
}

bool BackHandler::nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) {
    Q_UNUSED(result)

#ifdef Q_OS_ANDROID
    if (eventType == "android_native_event") {
        // Обработка Android Back Button
        // Структура специфична для Android
        return handleBackButton();
    }
#endif

#ifdef Q_OS_WIN
    if (eventType == "windows_generic_MSG") {
        MSG *msg = static_cast<MSG *>(message);
        if (msg->message == WM_KEYDOWN && msg->wParam == VK_BACK) {
            return handleBackButton();
        }
    }
#endif

#ifdef Q_OS_MAC
    if (eventType == "mac_generic_NSEvent") {
        // Обработка для macOS
    }
#endif

    return false;
}

bool BackHandler::handleBackButton() {
    const char op[] = "BackHandler::handleBackButton";

    if (m_enabled) {
        linfo(op) << "[BackHandler] Back button pressed";
        emit backPressed();
        return true;
    }
    return false;
}