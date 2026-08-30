#include "../log.h"
#include "db.h"

#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

Rc Database::executeSqlFile(const QString &path) {
    const char op[] = "Database::executeSqlFile";

    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        logger_.error(op, "cannot open SQL file", {{"path", path}});
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
        logger_.debug(op, "executing SQL query", {{"query", q}});
        if (!query.exec(q)) {
            logger_.error(op, "SQL query failed",
                        {{"error", query.lastError().text()}});
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
        logger_.error(op, "can't initialize schema migrations",
                    {{"error", migrationQuery.lastError().text()}});
        return;
    }

    int fails = 0;
    for (const auto &mf : migrationFiles) {
        if (!migrationQuery.prepare("SELECT 1 FROM schema_migrations WHERE path = :path")) {
            logger_.error(op, "can't prepare migration check",
                        {{"error", migrationQuery.lastError().text()}, {"path", mf}});
            fails++;
            continue;
        }
        migrationQuery.bindValue(":path", mf);
        if (!migrationQuery.exec()) {
            logger_.error(op, "can't check migration",
                        {{"error", migrationQuery.lastError().text()}, {"path", mf}});
            fails++;
            continue;
        }
        if (migrationQuery.next()) {
            logger_.debug(op, "migration already applied", {{"path", mf}});
            migrationQuery.finish();
            continue;
        }
        migrationQuery.finish();

        // Transaction for commands in one file
        logger_.debug(op, "applying migration", {{"path", mf}});
        if (!db.transaction()) {
            logger_.error(op, "can't start migration transaction",
                        {{"error", db.lastError().text()}, {"path", mf}});
            fails++;
            continue;
        }
        if (executeSqlFile(mf) != Rc::Ok) {
            db.rollback();
            logger_.error(op, "can't execute migration", {{"path", mf}});
            fails++;
            continue;
        }

        if (!migrationQuery.prepare("INSERT INTO schema_migrations (path) VALUES (:path)")) {
            db.rollback();
            logger_.error(op, "can't prepare migration record",
                        {{"error", migrationQuery.lastError().text()}, {"path", mf}});
            fails++;
            continue;
        }
        migrationQuery.bindValue(":path", mf);
        if (!migrationQuery.exec()) {
            db.rollback();
            logger_.error(op, "can't record migration",
                        {{"error", migrationQuery.lastError().text()}, {"path", mf}});
            fails++;
            continue;
        }
        if (!db.commit()) {
            logger_.error(op, "can't commit migration",
                        {{"error", db.lastError().text()}, {"path", mf}});
            fails++;
        }
    }

    if (fails != 0) {
        logger_.error(op, "migrations completed with failures",
                      QVariantMap{{"failures", fails}});
        return;
    }
    logger_.debug(op, "migrations successfully applied");
};
