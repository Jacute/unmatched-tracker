#include <QDebug>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

const QString defaultFontPath = ":/Tracker/ui/assets/fonts/BebasNeue-Regular.ttf";
const QString mainPath = "qrc:/Tracker/ui/Main.qml";

void addImportPathes(QQmlApplicationEngine &engine) {
    engine.addImportPath("qrc:/");
    engine.addImportPath("qrc:/Tracker/ui");
    engine.addImportPath("qrc:/Tracker/ui/Tracker");
    engine.addImportPath("qrc:/Tracker/ui/components");
    engine.addImportPath("qrc:/Tracker/ui/views");
    qDebug() << "Import paths added";
    qDebug() << "Import paths:" << engine.importPathList();
}

void loadResources(QGuiApplication &app) {
    int fontId = QFontDatabase::addApplicationFont(defaultFontPath);

    if (fontId == -1) {
        qDebug() << "Font not added, error code: " << fontId;
        return;
    }
    qDebug() << "Font " << " added, error code: " << fontId;
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    if (!fontFamilies.isEmpty()) {
        QFont defaultFont(fontFamilies.first());
        defaultFont.setPointSize(12);
        app.setFont(defaultFont);
    }
}

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    loadResources(app);
    addImportPathes(engine);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     [](const QUrl &url) {
                         qDebug() << "=== OBJECT CREATION FAILED for:" << url;
                         QCoreApplication::exit(-1);
                     });

    const QUrl url(mainPath);
    qDebug() << "Loading:" << url;
    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "=== No root objects loaded ===";
        return -1;
    }

    qDebug() << "Application running successfully";

    return app.exec();
}