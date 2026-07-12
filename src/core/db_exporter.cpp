#include "db_exporter.h"

#include <QDir>
#include <QFile>
#include <QStandardPaths>

Rc DbExporter::exportDb(Database& db, const QUrl& to) const {
    ScopedDatabaseClose guard(db);

    QFile source(db.path());
    if (!source.open(QIODevice::ReadOnly)) {
        return Rc::ErrOpenFile;
    }

    const QString destinationPath =
        to.isLocalFile() ? to.toLocalFile() : to.toString(QUrl::FullyEncoded);

    QFile destination(destinationPath);

    if (!destination.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
        return Rc::ErrCreateFile;
    }

    constexpr qint64 chunkSize = 1024 * 1024;

    while (!source.atEnd()) {
        const QByteArray chunk = source.read(chunkSize);

        if (chunk.isEmpty() && source.error() != QFileDevice::NoError) {
            return Rc::ErrReadFile;
        }

        qint64 totalWritten = 0;

        while (totalWritten < chunk.size()) {
            const qint64 written =
                destination.write(chunk.constData() + totalWritten, chunk.size() - totalWritten);

            if (written <= 0) {
                return Rc::ErrWriteFile;
            }

            totalWritten += written;
        }
    }

    if (!destination.flush()) {
        return Rc::ErrWriteFile;
    }

    return Rc::Ok;
}