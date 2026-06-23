#ifndef FILECACHE_H
#define FILECACHE_H

#include "../rc.h"

#include <QByteArray>
#include <QDir>
#include <QString>
#include <QUrl>

class FileCache {
  public:
    FileCache();
    ~FileCache() = default;

    QString cacheDir() const;
    QString filePath(const QString &key) const;
    QUrl fileUrl(const QString &key) const;

    bool exists(const QString &key) const;
    Rc read(const QString &key, QByteArray &out) const;
    Rc write(const QString &key, const QByteArray &data) const;
    Rc remove(const QString &key) const;
    Rc clear() const;

  private:
    QString cacheDir_;

    static QString defaultCacheDir();
    static QString fileNameForKey(const QString &key);
    Rc ensureCacheDir() const;
};

#endif
