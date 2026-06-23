#include "filecache.h"

#include <QCryptographicHash>
#include <QFile>
#include <QFileInfo>
#include <QSaveFile>
#include <QStandardPaths>

FileCache::FileCache()
    : cacheDir_(defaultCacheDir()) {
    ensureCacheDir();
}

QString FileCache::cacheDir() const {
    return cacheDir_;
}

QString FileCache::filePath(const QString &key) const {
    return QDir(cacheDir_).filePath(fileNameForKey(key));
}

QUrl FileCache::fileUrl(const QString &key) const {
    return QUrl::fromLocalFile(filePath(key));
}

bool FileCache::exists(const QString &key) const {
    return QFileInfo::exists(filePath(key));
}

Rc FileCache::read(const QString &key, QByteArray &out) const {
    QFile file(filePath(key));
    if (!file.open(QIODevice::ReadOnly)) {
        return Rc::ErrOpenFile;
    }

    out = file.readAll();
    if (file.error() != QFileDevice::NoError) {
        return Rc::ErrReadFile;
    }

    return Rc::Ok;
}

Rc FileCache::write(const QString &key, const QByteArray &data) const {
    const Rc rc = ensureCacheDir();
    if (rc != Rc::Ok) {
        return rc;
    }

    QSaveFile file(filePath(key));
    if (!file.open(QIODevice::WriteOnly)) {
        return Rc::ErrOpenFile;
    }

    if (file.write(data) != data.size()) {
        return Rc::ErrWriteFile;
    }

    if (!file.commit()) {
        return Rc::ErrCommitFile;
    }

    return Rc::Ok;
}

Rc FileCache::remove(const QString &key) const {
    const QString path = filePath(key);
    if (!QFileInfo::exists(path)) {
        return Rc::Ok;
    }

    if (!QFile::remove(path)) {
        return Rc::ErrRemoveFile;
    }

    return Rc::Ok;
}

Rc FileCache::clear() const {
    QDir dir(cacheDir_);
    if (!dir.exists()) {
        return ensureCacheDir();
    }

    if (!dir.removeRecursively()) {
        return Rc::ErrClearCache;
    }

    return ensureCacheDir();
}

QString FileCache::defaultCacheDir() {
    const QString root = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    return QDir(root).filePath("images");
}

QString FileCache::fileNameForKey(const QString &key) {
    const QByteArray hash =
        QCryptographicHash::hash(key.toUtf8(), QCryptographicHash::Sha256).toHex();

    QString suffix = QFileInfo(QUrl(key).path()).suffix().toLower();
    if (suffix.isEmpty()) {
        suffix = QFileInfo(key).suffix().toLower();
    }

    if (suffix.isEmpty()) {
        return QString::fromLatin1(hash);
    }
    return QString::fromLatin1(hash) + "." + suffix;
}

Rc FileCache::ensureCacheDir() const {
    QDir dir(cacheDir_);
    if (dir.exists()) {
        return Rc::Ok;
    }
    if (!dir.mkpath(".")) {
        return Rc::ErrCreateCacheDir;
    }
    return Rc::Ok;
}
