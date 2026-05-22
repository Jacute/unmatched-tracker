#include <QDebug>

#include "log.h"

QDebug log(const char* tag) {
    return qDebug().noquote() << "[" << tag << "]";
}