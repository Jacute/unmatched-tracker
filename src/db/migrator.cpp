#include "db.h"

#include <QFile>
#include <QSqlQuery>
#include <QSqlError>

Rc Database::executeSqlFile(const QString& path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open SQL file:" << path;
        return Rc::ErrCantOpenFile;
    }

    QString sql = QString::fromUtf8(file.readAll());
    file.close();

    QStringList queries = sql.split(';', Qt::SkipEmptyParts);

    QSqlQuery query;

    for (QString q : queries) {
        q = q.trimmed();
        if (q.isEmpty())
            continue;

        if (!query.exec(q)) {
            qWarning() << "SQL error:" << query.lastError().text();
            qWarning() << "Query:" << q;
            return Rc::ErrCantExecQuery;
        }
    }

    return Rc::Ok;
}

void Database::migrate(QVector<QString> migrationFiles) {
    int fails = 0;
    for (const auto &mf : migrationFiles) {
        if (executeSqlFile(mf) != Rc::Ok) {
            qWarning() << "can't execute sql file: " << mf;
            fails++;
        }
    }

    if (fails != 0) {
        qDebug() << "Migrations applied with " << fails << " fails";
        return;
    }
    qDebug() << "Migrations successfully applied";
};