#ifndef CLIENTMETHODS_H
#define CLIENTMETHODS_H

#include <QObject>
#include <QTcpSocket>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDir>
class clientMethods : public QObject
{
    Q_OBJECT
public:
    explicit clientMethods(QObject *parent = nullptr,QTcpSocket *cl = nullptr);

signals:
    void newMessage(const QByteArray &message);
public slots :
    QTcpSocket *Get_client();
    void Set_Client(QTcpSocket *cl);
    void Set_QHash(QHash<QString, QTcpSocket*> *All_CLients);
    void Set_QMap(QMap<QString,QString> *Active_Clients);
private slots :
    void sendMessage(const QString type,const QTcpSocket *client, const QString &message);
    void onReadyRead();
    void onNewMessage(const QByteArray &ba);
    void inform_update_of_message_state(QString whosend,QString toWho);
    void update_personal_chat_file(QString whosend,QString toWho,QString message,QString time,bool is_atchmnt);
    void inform_i_am_online(QString iam, QString chatlist);
private:
    QString getClientKey(const QTcpSocket *client) const;
private:
    QHash<QString, QTcpSocket*> *_clients;
    QMap<QString,QString> *activeClients;
    QTcpSocket *client;
};

#endif // CLIENTMETHODS_H
