#ifndef FILECACHE_H
#define FILECACHE_H

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
    QByteArray read(const QString &key) const;
    bool write(const QString &key, const QByteArray &data) const;
    bool remove(const QString &key) const;
    bool clear() const;

  private:
    QString cacheDir_;

    static QString defaultCacheDir();
    static QString fileNameForKey(const QString &key);
    bool ensureCacheDir() const;
};

#endif
