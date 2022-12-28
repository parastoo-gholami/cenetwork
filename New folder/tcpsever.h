#ifndef TCPSEVER_H
#define TCPSEVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QHash>
class TCPSever : public QObject
{
    Q_OBJECT
public:
    explicit TCPSever(QObject *parent = nullptr);
private:
    QTcpServer Sever;
    QHash<QString, QTcpSocket*> Clients;

signals:

public slots:
};

#endif // TCPSEVER_H
