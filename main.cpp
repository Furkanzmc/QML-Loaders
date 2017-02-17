#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
// Local
#include "QMLManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

#ifdef QT_DEBUG
    QMLManager manager(&engine);
    manager.setMainQMLFile("file:///E:/Development/SourceTree/GitHub/QML-Loaders/qml/main.qml");
    engine.rootContext()->setContextProperty("QM", &manager);
    engine.rootContext()->setContextProperty("QML_DEBUG", true);
    engine.load(QUrl(QStringLiteral("file:///E:/Development/SourceTree/GitHub/QML-Loaders/qml/main.qml")));
#else
    engine.rootContext()->setContextProperty("QM", false);
    engine.rootContext()->setContextProperty("QML_DEBUG", false);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
#endif // QT_DEBUG

    return app.exec();
}
