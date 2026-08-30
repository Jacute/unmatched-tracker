#include "api/api.h"
#include "config.h"
#include "core/core.h"
#include "core/db_exporter.h"
#include "core/keep_awake_helper.h"
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
#include <QSslSocket>
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

int main(int argc, char* argv[]) {
    const char op[] = "main";

    QGuiApplication app(argc, argv);
    QCoreApplication::setOrganizationName("jacute");
    QCoreApplication::setApplicationName("Unmatched Tracker");
    QCoreApplication::setApplicationVersion(QStringLiteral(APP_VERSION));
    QQmlApplicationEngine engine;

    Config cfg(cfgPath);

    loadResources(app);

    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(path);
    const QString dbPath = path + "/app.db";
    Database db(dbPath, cfg.db.dbName_);
    DbExporter dbExporter;
    Rc rc = db.open();
    if (rc != Rc::Ok) {
        lerr(op) << "database open error: " << rc2str(rc);
        return static_cast<int>(rc);
    }

    db.migrate(cfg.db.migrationFiles);

    const QString apiBaseUrl =
        cfg.assetsBaseUrl.isEmpty() ? QStringLiteral(API_URL) : cfg.assetsBaseUrl;

    Api api(apiBaseUrl);
    FileCache cache;
    File fileProvider(cache, api);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, [&op](const QUrl& url) {
        ldebug(op) << "object creation failed:" << url;
        QCoreApplication::exit(-1);
    });

    Core core(db, dbExporter, &fileProvider);
    KeepAwakeHelper keepAwakeHelper;
    engine.rootContext()->setContextProperty("core", &core);
    engine.rootContext()->setContextProperty("keepAwakeHelper", &keepAwakeHelper);

    ldebug(op) << "Loading:" << mainQmlPath;
    engine.load(mainQmlPath);

    if (engine.rootObjects().isEmpty()) {
        ldebug(op) << "=== No root objects loaded ===";
        return -1;
    }

    QVariantMap buildInfo = core.getBuildInfo();
    ldebug(op) << "Application running successfully with config: " << cfg;
    linfo(op) << "SSL supported: " << QSslSocket::supportsSsl();
    linfo(op) << "Build SSL: " << QSslSocket::sslLibraryBuildVersionString();
    linfo(op) << "Runtime SSL: " << QSslSocket::sslLibraryVersionString();
    linfo(op) << "App version: " << buildInfo["version"].toString();
    linfo(op) << "App build hash: " << buildInfo["commit"].toString();

    int appRc = app.exec();
    if (appRc != 0) {
        lerr(op) << "Application closed with error code: " << appRc;
    }
    db.close();
}
