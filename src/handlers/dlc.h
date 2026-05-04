#ifndef DLC_H
#define DLC_H

#include <QObject>
#include <QString>

class Menu : public QObject {
    Q_OBJECT
    Q_PROPERTY(type name READ name WRITE setName NOTIFY nameChanged FINAL)
};

#endif
