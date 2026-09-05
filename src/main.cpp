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

void loadResources(const Logger& logger, QGuiApplication& app) {
    const char op[] = "loadResources";

    int fontId = QFontDatabase::addApplicationFont(defaultFontPath);
    if (fontId == -1) {
        logger.warning(op, "font not loaded", {{"font_ret", fontId}});
        return;
    }

    logger.debug(op, "font loaded", {{"font_path", defaultFontPath}});
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
#ifdef NDEBUG
    Logger logger(LogLevel::INFO);
#else
    Logger logger(LogLevel::DEBUG);
#endif
    QCoreApplication::setOrganizationName("jacute");
    QCoreApplication::setApplicationName("Unmatched Tracker");
    QCoreApplication::setApplicationVersion(QStringLiteral(APP_VERSION));
    QQmlApplicationEngine engine;

    Config cfg(logger, cfgPath);

    loadResources(logger, app);

    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(path);
    const QString dbPath = path + "/app.db";
    Database db(logger, dbPath, cfg.db.dbName_);
    DbExporter dbExporter(logger);
    Rc rc = db.open();
    if (rc != Rc::Ok) {
        logger.error(op, "database open error", rc2str(rc));
        return static_cast<int>(rc);
    }

    db.migrate(cfg.db.migrationFiles);

    const QString apiBaseUrl =
        cfg.assetsBaseUrl.isEmpty() ? QStringLiteral(API_URL) : cfg.assetsBaseUrl;

    Api api(logger, apiBaseUrl);
    FileCache cache;
    File fileProvider(cache, api);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, [&logger, &op](const QUrl& url) {
        logger.warning(op, "object creation failed", {{"url", url}});
        QCoreApplication::exit(-1);
    });

    Core core(logger, db, dbExporter, &fileProvider);
    KeepAwakeHelper keepAwakeHelper(logger);
    engine.rootContext()->setContextProperty("core", &core);
    engine.rootContext()->setContextProperty("logger", &logger);
    engine.rootContext()->setContextProperty("keepAwakeHelper", &keepAwakeHelper);

    logger.debug(
        op, "Loading main qml", {
            {"main_qml_path", mainQmlPath}
        }
    );
    engine.load(mainQmlPath);

    if (engine.rootObjects().isEmpty()) {
        logger.warning(op, "=== No root objects loaded ===");
        return -1;
    }

    QVariantMap buildInfo = core.getBuildInfo();
    logger.debug(op, "application running",
               {{"assets_base_url", cfg.assetsBaseUrl}, {"db_name", cfg.db.dbName_}});
    logger.info(op, "SSL support checked",
               {{"supported", QSslSocket::supportsSsl()},
                {"build_version", QSslSocket::sslLibraryBuildVersionString()},
                {"runtime_version", QSslSocket::sslLibraryVersionString()}});
    logger.info(op, "build info",
               {{"version", buildInfo["version"]}, {"commit", buildInfo["commit"]}});

    int appRc = app.exec();
    if (appRc != 0) {
        logger.error(op, "application closed with error", QString::number(appRc));
    }
    db.close();
}
