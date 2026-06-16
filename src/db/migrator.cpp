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

    QSqlQuery migrationQuery;
    if (!migrationQuery.exec("CREATE TABLE IF NOT EXISTS schema_migrations ("
                             "path TEXT PRIMARY KEY,"
                             "applied_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP"
                             ")")) {
        lwarn(op) << "can't initialize schema_migrations: " << migrationQuery.lastError().text();
        return;
    }

    int fails = 0;
    for (const auto &mf : migrationFiles) {
        if (!migrationQuery.prepare("SELECT 1 FROM schema_migrations WHERE path = :path")) {
            lwarn(op) << "can't prepare migration check: " << migrationQuery.lastError().text();
            fails++;
            continue;
        }
        migrationQuery.bindValue(":path", mf);
        if (!migrationQuery.exec()) {
            lwarn(op) << "can't check migration: " << migrationQuery.lastError().text();
            fails++;
            continue;
        }
        if (migrationQuery.next()) {
            ldebug(op) << "Skipping already applied sql file " << mf;
            migrationQuery.finish();
            continue;
        }
        migrationQuery.finish();

        // Transaction for commands in one file
        ldebug(op) << "Executing sql file " << mf;
        if (!db.transaction()) {
            lwarn(op) << "can't start migration transaction: " << db.lastError().text();
            fails++;
            continue;
        }
        if (executeSqlFile(mf) != Rc::Ok) {
            db.rollback();
            lwarn(op) << "can't execute sql file: " << mf;
            fails++;
            continue;
        }

        if (!migrationQuery.prepare("INSERT INTO schema_migrations (path) VALUES (:path)")) {
            db.rollback();
            lwarn(op) << "can't prepare migration record: " << migrationQuery.lastError().text();
            fails++;
            continue;
        }
        migrationQuery.bindValue(":path", mf);
        if (!migrationQuery.exec()) {
            db.rollback();
            lwarn(op) << "can't record migration: " << migrationQuery.lastError().text();
            fails++;
            continue;
        }
        if (!db.commit()) {
            lwarn(op) << "can't commit migration: " << db.lastError().text();
            fails++;
        }
    }

    if (fails != 0) {
        ldebug(op) << "migrations applied with " << fails << " fails";
        return;
    }
    ldebug(op) << "migrations successfully applied";
};
