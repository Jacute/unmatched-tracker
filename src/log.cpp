#include <QDebug>

#include "log.h"

QDebug ldebug(const char* tag) {
    return qDebug().noquote() << "[" << tag << "]";
}

QDebug lwarn(const char* tag) {
    return qWarning().noquote() << "[" << tag << "]";
}

QDebug linfo(const char* tag) {
    return qInfo().noquote() << "[" << tag << "]";
}

QDebug lerr(const char* tag) {
    return qCritical().noquote() << "[" << tag << "]";
}