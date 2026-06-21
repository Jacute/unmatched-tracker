#include "filecache.h"

#include <QCryptographicHash>
#include <QFile>
#include <QFileInfo>
#include <QSaveFile>
#include <QStandardPaths>

#include <utility>

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

QByteArray FileCache::read(const QString &key) const {
    QFile file(filePath(key));
    if (!file.open(QIODevice::ReadOnly)) {
        return {};
    }
    return file.readAll();
}

bool FileCache::write(const QString &key, const QByteArray &data) const {
    if (!ensureCacheDir()) {
        return false;
    }

    QSaveFile file(filePath(key));
    if (!file.open(QIODevice::WriteOnly)) {
        return false;
    }

    if (file.write(data) != data.size()) {
        return false;
    }

    return file.commit();
}

bool FileCache::remove(const QString &key) const {
    const QString path = filePath(key);
    if (!QFileInfo::exists(path)) {
        return true;
    }
    return QFile::remove(path);
}

bool FileCache::clear() const {
    QDir dir(cacheDir_);
    if (!dir.exists()) {
        return true;
    }
    return dir.removeRecursively() && ensureCacheDir();
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

bool FileCache::ensureCacheDir() const {
    QDir dir(cacheDir_);
    if (dir.exists()) {
        return true;
    }
    return dir.mkpath(".");
}
