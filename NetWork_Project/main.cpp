#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "tcpclient.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/NetWork_Project/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    tcpClient client;
    engine.rootContext()->setContextProperty("client", &client);
    engine.load(url);

    return app.exec();
}
//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
