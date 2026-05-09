#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    qDebug() << "=== Application started ===";
    
    QQmlApplicationEngine engine;
    
    engine.addImportPath("qrc:/");
    engine.addImportPath("qrc:/Tracker/ui");
    engine.addImportPath("qrc:/Tracker/ui/common");
    engine.addImportPath("qrc:/Tracker/ui/components");
    engine.addImportPath("qrc:/Tracker/ui/views");
    
    qDebug() << "Import paths added";
    qDebug() << "Import paths:" << engine.importPathList();
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        [](const QUrl &url) {
            qDebug() << "=== OBJECT CREATION FAILED for:" << url;
            QCoreApplication::exit(-1);
        });
    
    const QUrl url(QStringLiteral("qrc:/Tracker/ui/Main.qml"));
    qDebug() << "Loading:" << url;
    
    engine.load(url);
    
    if (engine.rootObjects().isEmpty()) {
        qDebug() << "=== No root objects loaded ===";
        return -1;
    }
    
    qDebug() << "Application running successfully";
    
    return app.exec();
}