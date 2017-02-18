#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>
// Local
#include "src/QMLManager.h"
#include "src/ScreenHelper.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ScreenHelper screenHelper;
    engine.rootContext()->setContextProperty("SH", &screenHelper);

#if defined(QT_DEBUG) && defined(_WIN32)
    QMLManager manager(&engine);
    manager.setMainQMLFile("file:///E:/Development/SourceTree/GitHub/QML-Loaders/Demo/qml/main.qml");
    engine.rootContext()->setContextProperty("QM", &manager);
    engine.rootContext()->setContextProperty("QML_DEBUG", true);
    engine.load(QUrl(QStringLiteral("file:///E:/Development/SourceTree/GitHub/QML-Loaders/Demo/qml/main.qml")));
#else
    engine.rootContext()->setContextProperty("QM", nullptr);
    engine.rootContext()->setContextProperty("QML_DEBUG", false);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
#endif // QT_DEBUG

    return app.exec();
}
