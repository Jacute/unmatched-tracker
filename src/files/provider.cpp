#include "provider.h"
#include "../log.h"

namespace {
void normalizeQmlUrl(QString& path) {
    constexpr const char* qrcPrefix = "qrc";

    if (path.startsWith(qrcPrefix)) {
        path.remove(0, QString(qrcPrefix).size());
    }
}
} // namespace

File::File(const FileCache& cache, const Api& api)
    : cache_(cache),
      api_(api) {
}

Rc File::getCached(const QString& path, QString& sourceUrl) const {
    if (!cache_.exists(path)) {
        return Rc::ErrNotFound;
    }

    sourceUrl = cache_.fileUrl(path).toString();
    normalizeQmlUrl(sourceUrl);
    return Rc::Ok;
}

Rc File::get(const QString& path, QString& sourceUrl) {
    if (getCached(path, sourceUrl) == Rc::Ok) {
        return Rc::Ok;
    }

    QByteArray data;
    Rc rc = api_.getAsset(path, data);
    if (rc != Rc::Ok) {
        return rc;
    }
    rc = cache_.write(path, data);
    if (rc != Rc::Ok) {
        return rc;
    }
    sourceUrl = cache_.fileUrl(path).toString();
    normalizeQmlUrl(sourceUrl);
    return Rc::Ok;
}
