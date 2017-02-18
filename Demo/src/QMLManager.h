#pragma once
#include <QObject>
#include <QQmlApplicationEngine>
#include <QTimer>
#include <QQuickWindow>
#include <QDebug>
// STD
#include <functional>

/**
 * @brief The QMLManager is a helper class to reload QML on runtime. To use it, pass the QQmlApplicationEngine pointer and call the reload function when you need.
 * For more information about runtime reloading go here -> http://www.slideshare.net/ICSinc/how-best-to-realize-a-runtime-reload-of-qml
 * @code
 *     // in main.cpp
 *     QMLManager manager(&engine);
 *     manager.setMainQMLFile("file:///E:/Development/Playground/Live-QML/qml/main.qml");
 *     engine.rootContext()->setContextProperty("QM", &manager);
 * @endcode
 *
 * Pass the `QQuickWindow` to `QMLManager`, then use QM.relad() to reload at runtime!
 * @code
 *     Window {
 *         id: mainWindow
 *         Component.onCompleted: QM.setWindow(mainWindow)
 *
 *         MouseArea {
 *             anchors.fill: parent
 *             onClicked: {
 *                 QM.reload();
 *             }
 *         }
 *     }
 * @endcode
 */
class QMLManager : public QObject
{
    Q_OBJECT

public:
    explicit QMLManager(QQmlApplicationEngine *engine, QObject *parent = 0)
        : QObject(parent)
        , m_Engine(engine)
        , m_Window(nullptr)
    {

    }

    Q_INVOKABLE void reload(float delay = 0.f)
    {
        if (delay == 0.f) {
            reloadCache();
        }
        else {
            QTimer::singleShot(delay * 1000, this, &QMLManager::reloadCache);
        }
    }

    Q_INVOKABLE void setWindow(QQuickWindow *window)
    {
        m_Window = window;
    }

    Q_INVOKABLE QString MainQMLFile() const
    {
        return m_MainQMLFile;
    }

    Q_INVOKABLE void setMainQMLFile(const QString &file)
    {
        m_MainQMLFile = file;
    }

private:
    QQmlApplicationEngine *m_Engine;
    QQuickWindow *m_Window;
    QString m_MainQMLFile;

private:
    void reloadCache()
    {
        if (m_MainQMLFile.length() == 0) {
            qDebug() << "m_MainQMLFile is empty.";
            return;
        }

        if (m_Window) {
            m_Window->close();
        }

        m_Engine->clearComponentCache();
        m_Engine->load(QUrl(m_MainQMLFile));
    }
};
