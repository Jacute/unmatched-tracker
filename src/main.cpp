#include "api/api.h"
#include "components/render/imagerounded.h"
#include "config.h"
#include "core/core.h"
#include "core/db_exporter.h"
#include "db/db.h"
#include "files/filecache.h"
#include "files/provider.h"
#include "log.h"

#include <QDir>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths>
#include <memory>

const QString rscPath = ":/qt/qml/Tracker";
const QString uiPath = rscPath + "/ui";
const QString defaultFontPath = uiPath + "/assets/fonts/BebasNeue-Regular.ttf";
const QString mainQmlPath = uiPath + "/Main.qml";
const QString cfgPath = rscPath + "/src/config.json";

void loadResources(QGuiApplication& app) {
    const char op[] = "loadResources";

    int fontId = QFontDatabase::addApplicationFont(defaultFontPath);
    if (fontId == -1) {
        lwarn(op) << "Font " << defaultFontPath << " not loaded, error code: " << fontId;
        return;
    }

    ldebug(op) << "Font " << defaultFontPath << " added";
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    if (!fontFamilies.isEmpty()) {
        QFont defaultFont(fontFamilies.first());
        defaultFont.setPointSize(12);
        app.setFont(defaultFont);
    }
}

void loadQMLComponents() {
    qmlRegisterType<ImageRounded>("Render", 1, 0, "ImageRounded");
}

int main(int argc, char* argv[]) {
    const char op[] = "main";

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Config cfg(cfgPath);

    loadResources(app);
    loadQMLComponents();

    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(path);
    const QString dbPath = path + "/app.db";
    Database db(dbPath, cfg.db.dbName_);
    DbExporter dbExporter;
    db.open();
    db.migrate(cfg.db.migrationFiles);

    const QString apiBaseUrl = cfg.assetsBaseUrl.isEmpty() ? QString(API_URL) : cfg.assetsBaseUrl;
    Api api(apiBaseUrl);
    FileCache cache;
    File fileProvider(cache, api);

    Core core(db, dbExporter, &fileProvider);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, [&op](const QUrl& url) {
        ldebug(op) << "object creation failed:" << url;
        QCoreApplication::exit(-1);
    });
    engine.rootContext()->setContextProperty("core", &core);
    ldebug(op) << "Loading:" << mainQmlPath;
    engine.load(mainQmlPath);

    if (engine.rootObjects().isEmpty()) {
        ldebug(op) << "=== No root objects loaded ===";
        return -1;
    }

    ldebug(op) << "Application running successfully";

    int rc = app.exec();
    if (rc != 0) {
        lwarn(op) << "Application closed with error code: " << rc;
    }
    db.close();
}
