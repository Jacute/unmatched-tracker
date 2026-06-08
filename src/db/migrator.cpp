#include "../log.h"
#include "db.h"

#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

Rc Database::executeSqlFile(const QString &path) {
    const char op[] = "Database::executeSqlFile";

    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open SQL file:" << path;
        return Rc::ErrOpenFile;
    }

    QString sql = QString::fromUtf8(file.readAll());
    file.close();

    QStringList queries = sql.split(';', Qt::SkipEmptyParts);

    QSqlQuery query;

    for (QString q : queries) {
        q = q.trimmed();
        if (q.isEmpty())
            continue;
        ldebug(op) << "Executing sql query " << q;
        if (!query.exec(q)) {
            qWarning() << "sql error: " << query.lastError().text();
            return Rc::ErrExecQuery;
        }
    }

    return Rc::Ok;
}

void Database::migrate(const QVector<QString> &migrationFiles) {
    const char op[] = "Database::migrate";

    int fails = 0;
    for (const auto &mf : migrationFiles) {
        ldebug(op) << "Executing sql file " << mf;
        if (executeSqlFile(mf) != Rc::Ok) {
            lwarn(op) << "can't execute sql file: " << mf;
            fails++;
        }
    }

    if (fails != 0) {
        ldebug(op) << "migrations applied with " << fails << " fails";
        return;
    }
    ldebug(op) << "migrations successfully applied";
};