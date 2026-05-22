#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "components/render/imagerounded.h"

const QString defaultFontPath = ":/qt/qml/Tracker/ui/assets/fonts/BebasNeue-Regular.ttf";
const QString mainPath = "qrc:/qt/qml/Tracker/ui/Main.qml";

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
    loadResources(app);
    loadQMLComponents();

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     [](const QUrl &url) {
                         qDebug() << "=== OBJECT CREATION FAILED for:" << url;
                         QCoreApplication::exit(-1);
                     });

    const QUrl url(mainPath);
    qDebug() << "Loading:" << url;
    engine.load(mainPath);

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "=== No root objects loaded ===";
        return -1;
    }

    qDebug() << "Application running successfully";

    return app.exec();
}