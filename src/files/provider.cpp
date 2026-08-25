#include "provider.h"
#include "../log.h"

#include <QNetworkReply>

namespace {
void normalizeQmlUrl(QString& path) {
    constexpr const char* qrcPrefix = "qrc";

    if (path.startsWith(qrcPrefix)) {
        path.remove(0, QString(qrcPrefix).size());
    }
}
} // namespace

File::File(const FileCache& cache, Api& api)
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

void File::get(
    const QString& path,
    FileCallback onFile
) {
    const char* op = "File::get";
    QString sourceUrl;
    // cache check not async
    if (getCached(path, sourceUrl) == Rc::Ok) {
        onFile(sourceUrl, Rc::Ok);
        return;
    }

    api_.getAsset(
        path,
        [
            this,
            op,
            path,
            onFile = std::move(onFile)
        ](QByteArray data, Rc rc) {
            if (rc != Rc::Ok) {
                onFile("", rc);
                return;
            }
            rc = cache_.write(path, data);
            if (rc != Rc::Ok) {
                onFile("", rc);
                return;
            }
            QString sourceUrl = cache_.fileUrl(path).toString();
            normalizeQmlUrl(sourceUrl);
            onFile(sourceUrl, Rc::Ok);
        }
    );
}
