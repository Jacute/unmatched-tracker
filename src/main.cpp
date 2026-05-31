#include "components/render/imagerounded.h"
#include "db/db.h"
#include "config.h"
#include "backend/backend.h"

#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStandardPaths>
#include <QQmlContext>
#include <QDir>
#include <memory>

const QString rscPath = ":/qt/qml/Tracker";
const QString uiPath = rscPath + "/ui";
const QString defaultFontPath = rscPath + "/ui/assets/fonts/BebasNeue-Regular.ttf";
const QString mainQmlPath = uiPath + "/Main.qml";
const QString cfgPath = rscPath + "/config.json";

void loadResources(QGuiApplication &app) {
    int fontId = QFontDatabase::addApplicationFont(defaultFontPath);
    if (fontId == -1) {
        qDebug() << "Font not added, error code: " << fontId;
        return;
    }

    qDebug() << "Font " << defaultFontPath << " added";
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

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Config cfg(cfgPath);

    loadResources(app);
    loadQMLComponents();

    QString path = QStandardPaths::writableLocation(
        QStandardPaths::AppDataLocation
    );
    QDir().mkpath(path);
    const QString dbPath = path + "/app.db";
    Database db(dbPath, cfg.db.dbName_);
    db.open();
    db.migrate(cfg.db.migrationFiles);
    Backend backend(db);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     [](const QUrl &url) {
                         qDebug() << "=== OBJECT CREATION FAILED for:" << url;
                         QCoreApplication::exit(-1);
                     });
    engine.rootContext()->setContextProperty("backend", &backend);
    qDebug() << "Loading:" << mainQmlPath;
    engine.load(mainQmlPath);

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "=== No root objects loaded ===";
        return -1;
    }

    qDebug() << "Application running successfully";

    int rc = app.exec();
    if (rc != 0) {
        qWarning() << "Application closed with error code: " << rc;
    }
    db.close();
}