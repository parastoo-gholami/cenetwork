#include "tcpserver.h"
tcpserver::tcpserver(QObject *parent)
    : QObject{parent}
{
    connect(&_server , &QTcpServer::newConnection , this , &tcpserver::onNewConnection);
    if (_server.listen(QHostAddress::Any,45000))//127.0.0.1
    {
        qInfo() << "lisening...";
    }
}
void tcpserver::onNewConnection()
{
    const auto client = _server.nextPendingConnection();
    clientMethods *client_Method = new clientMethods(nullptr,client);
    if (client == nullptr)
    {
        delete client_Method;
        return ;
    }
    qInfo() << "New Client connected.";
    _clients.insert(getClientKey(client), client);
    client_Method->Set_QHash(&_clients);
    client_Method->Set_QMap(&activeClients);
    CM_list.insert(getClientKey(client),client_Method);
//    class_map.insert(getClientKey(client),client_Method);
    connect(client, &QTcpSocket::disconnected,this,&tcpserver::onDisconnected);
}
void tcpserver::onDisconnected()
{
    QTcpSocket* client = reinterpret_cast<QTcpSocket*>(sender());
    if (client == nullptr)
    {
        return;
    }
    QString User_name = "";
    for (auto [key, value] : activeClients.asKeyValueRange())
    {
        if (value == getClientKey(client))
        {
            User_name = key;
        }
    }
    QString file_name = User_name + "_chatlist";
    QByteArray header = QString("i_am_offline|").toUtf8();
    QByteArray buffer = User_name.toUtf8();
    header.resize(128);
    buffer.prepend(header);
    QFile chatlist_file(file_name);
    QTextStream t_s(&chatlist_file);
    QStringList sl;
    chatlist_file.open(QFile::ReadOnly | QFile::Text);
    while (!t_s.atEnd())
    {
        sl.append(t_s.readLine());
    }
    chatlist_file.close();
    for (int i = 0; i < sl.length(); i++)
    {
        QString send_to_who = "";
        for (auto [key, value] : activeClients.asKeyValueRange())
        {
            if (key == sl[i])
            {
                send_to_who = value;
            }
        }
        if (send_to_who != "")
        {
            for (const auto &client : qAsConst(_clients))
            {
                if (getClientKey(client) == send_to_who)
                {
                    qInfo() << "sent";
                    client->write(buffer);
                    client->flush();
                }
            }
        }
    }
    delete CM_list[getClientKey(client)];
    CM_list.remove(getClientKey(client));
    _clients.remove(this->getClientKey(client));
    activeClients.remove(User_name);

}
QString tcpserver::getClientKey(const QTcpSocket *client)
{
    return client->peerAddress().toString().append(":").append(QString::number(client->peerPort()));
}
