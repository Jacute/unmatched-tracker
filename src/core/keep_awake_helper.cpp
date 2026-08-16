#include "keep_awake_helper.h"
#include "../log.h"

#include <QCoreApplication>
#include <QJniObject>

static constexpr jint FLAG_KEEP_SCREEN_ON = 0x00000080;

void KeepAwakeHelper::set(bool enabled) const {
    QNativeInterface::QAndroidApplication::runOnAndroidMainThread([enabled]() {
        QJniObject activity = QNativeInterface::QAndroidApplication::context();

        if (!activity.isValid())
            return;

        QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");

        if (!window.isValid())
            return;

        if (enabled) {
            window.callMethod<void>("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
        } else {
            window.callMethod<void>("clearFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
        }
    });
}

bool KeepAwakeHelper::isKeepScreenOn() const {
    QJniObject activity = QNativeInterface::QAndroidApplication::context();

    if (!activity.isValid())
        return false;

    QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");

    if (!window.isValid())
        return false;

    QJniObject attributes =
        window.callObjectMethod("getAttributes", "()Landroid/view/WindowManager$LayoutParams;");

    if (!attributes.isValid())
        return false;

    const jint flags = attributes.getField<jint>("flags");

    return (flags & FLAG_KEEP_SCREEN_ON) != 0;
}

void KeepAwakeHelper::enable() const {
    const char* op = "KeepAwakeHelper::enable";
    if (isKeepScreenOn()) {
        lwarn(op) << "KeepAwake already enabled";
        return;
    }
    set(true);
    linfo(op) << "KeepAwake successfully enabled";
}

void KeepAwakeHelper::disable() const {
    const char* op = "KeepAwakeHelper::disable";
    if (!isKeepScreenOn()) {
        lwarn(op) << "KeepAwake already disabled";
        return;
    }
    set(false);
    linfo(op) << "KeepAwake successfully disabled";
}