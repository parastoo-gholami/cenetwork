#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "tcpserver.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/TcpServer/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    tcpserver tcpServer;
    engine.rootContext()->setContextProperty("server",&tcpServer);

    engine.load(url);

    return app.exec();
}
