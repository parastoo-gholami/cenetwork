#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QHash>
#include <QMap>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <clientmethods.h>
class tcpserver : public QObject
{
    Q_OBJECT
public:
    explicit tcpserver(QObject *parent = nullptr);

signals:
public slots :
private slots :
    void onNewConnection();
    void onDisconnected();
private:
    QString getClientKey(const QTcpSocket *client);
private:
    QTcpServer _server;
    QHash<QString, QTcpSocket*> _clients;
    QMap<QString,QString> activeClients;
    QMap<QString,clientMethods*> CM_list;
};

#endif // TCPSERVER_H
