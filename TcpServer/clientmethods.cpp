#include "clientmethods.h"

clientMethods::clientMethods(QObject *parent,QTcpSocket *cl)
    : QObject{parent}
{
    client = cl;
    connect(client, &QTcpSocket::readyRead,this,&clientMethods::onReadyRead);
    connect(this, &clientMethods::newMessage,this,&clientMethods::onNewMessage);
}
void clientMethods::Set_Client(QTcpSocket *cl)
{
    client = cl;
}
QTcpSocket *clientMethods::Get_client()
{
    return client;
}
void clientMethods::Set_QHash(QHash<QString, QTcpSocket*> *All_CLients)
{
    _clients = All_CLients;
}
void clientMethods::Set_QMap(QMap<QString,QString> *Active_Clients)
{
    activeClients = Active_Clients;
}
void clientMethods::onReadyRead()
{
    QTcpSocket* client = reinterpret_cast<QTcpSocket*>(sender());
    if (client == nullptr)
    {
        return;
    }
    QByteArray buffer;
    buffer = client->readAll();
    qInfo() << QString::fromStdString(buffer.toStdString());
    QString header = QString::fromStdString(buffer.mid(0,128).toStdString());
    QString fileType = header.split(",")[0].split(":")[1];
    buffer = buffer.mid(128);
    if(fileType=="message")
    {
        QStringList sl = header.split(",");
        QString whosend = sl[2].split(":")[1];
        QString towho = sl[1].split(":")[1];
        QString time = sl[3].split(":")[1] + ":" + sl[3].split(":")[2].split("|")[0];
        QByteArray header = QString::fromStdString("").toUtf8();
        update_personal_chat_file(whosend,towho,QString::fromStdString(buffer.toStdString()),time,false);
        header.prepend(QString("message|").toUtf8());
        header.resize(128);
        QString message = (QString("%1:%2:%3:%4:%5").arg("m",towho,whosend,QString::fromStdString(buffer.toStdString()),time));
        QByteArray message1 = QByteArray::fromStdString(message.toStdString());
        message1.prepend(header);
        emit newMessage(message1);
    }
    else if (fileType == "attchment")
    {
        QStringList sl = header.split(",");
        QString whosend = sl[2].split(':')[1];
        QString toWho = sl[1].split(':')[1];
        QString filename = sl[3].split(':')[1];
        QString filesize = sl[4].split(':')[1];
        QString time = QString(sl[5].split(':')[1] + ':' +sl[5].split(':')[2].split('|')[0]);
        QString filepath = whosend + "To" + toWho + filename;
        qInfo() << sl;
        qInfo() << time;
        QFile file (filepath);
        file.open(QIODevice::WriteOnly);
        file.write(buffer);
        file.close();
        update_personal_chat_file(whosend,toWho,QString(filename + ',' + filesize + ',' + filepath),time,true);
        QByteArray header = (QString("atchmnt|").toUtf8());
        header.resize(128);
        QString message =  (QString("%1:%2:%3:%4:%5").arg("a",toWho,whosend,QString(filename + ',' + filesize + ',' + filepath),time));
        QByteArray message1 = QByteArray::fromStdString(message.toStdString());
        message1.prepend(header);
        emit newMessage(message1);
    }
    else if (fileType == "get_attchmnt")
    {
        QString path = QString::fromStdString(buffer.toStdString());
        QFile file(path);
        if (file.open(QIODevice::ReadOnly))
        {
           QByteArray ba = file.readAll();
           qInfo() << "file transfer";
           long long receiver = client->socketDescriptor();
           for (const auto &client : qAsConst(*_clients))
           {
               if(client->socketDescriptor() == receiver)
               {
                   QByteArray head;
                   head.prepend(QString("get_file," + header.split(',')[1].split(':')[1].split('|')[0] + '|').toUtf8());
                   head.resize(128);
                   ba.prepend(head);
                   client->write(ba);
                   client->flush();
                   qInfo() << "sent atchmnt";
                   break;
               }
           }
        }
    }
    else if (fileType == "register")
    {
        bool emailisExist = false,usernameisExist = false;
        QFile file("usernames");
        QTextStream ts(&file);
        QString s = QString::fromStdString(buffer.toStdString());
        QStringList sl = s.split(',');
        if (file.exists())
        {
            file.open(QFile::ReadOnly | QFile::Text);
            while (!ts.atEnd())
            {
                QStringList info = ts.readLine().split(',');
                if (info[0] == sl[0])
                {
                    usernameisExist = true;
                    break;
                }
                if (info[2] == sl[2])
                {
                    emailisExist = true;
                    break;
                }
            }
            file.close();
            if (usernameisExist == true)
            {
                sendMessage("Snack|",client,"usernameExist");
            }
            else if (emailisExist == true)
            {
                sendMessage("Snack|",client,"emailExist");
            }
            else
            {
                file.open(QFile::Append | QFile::Text);
                ts << sl[0].toLower() << "," << sl[1].toLower() << ',' << sl[2].toLower() << '\n';
                sendMessage("Sack|",client,"Signed up");
                file.close();
            }
        }
        else
        {
            file.open(QFile::Append | QFile::Text);
            ts << sl[0].toLower() << "," << sl[1].toLower() << ',' << sl[2].toLower() << '\n';
            sendMessage("Sack|",client,"Signed up");
            file.close();
        }
    }
    else if (fileType == "login")
    {
        bool isExist = false;
        QFile file("usernames");
        QTextStream ts(&file);
        QString state;
        QStringList sl;
        QStringList login_info = QString::fromStdString(buffer.toStdString()).split(',');
        file.open(QFile::ReadOnly | QFile::Text);
        while (!ts.atEnd())
        {
            sl = ts.readLine().split(',');
            if (sl[0].toLower() == login_info[0].toLower())
            {
                isExist = true;
                if (sl[1].toLower() == login_info[1].toLower())
                {
                    state = "Logged in";
                }
                else
                {
                    state = "Password is incorrect";
                }
            }
        }
        if (isExist == false)
        {
            state = "UserName is not exist";
        }
        file.close();
        if (state == "Logged in")
        {
            activeClients->insert(login_info[0].toLower(),getClientKey(client));
            QString chatlistname = login_info[0].toLower() + "_chatlist";
            QString chatList_users = "";
            QFile chatlist(chatlistname);
            QTextStream cl_ts(&chatlist);
            chatlist.open(QFile::ReadOnly | QFile::Text);
            QString result = login_info[0].toLower() + "|";
            while (!cl_ts.atEnd())
            {
                QString chat = cl_ts.readLine();
                chatList_users += chat;
                chatList_users += ',';
                result += chat;
                QString file_name_1 = chat +"To"+ login_info[0].toLower();
                QString file_name_2 = login_info[0].toLower() + "To" + chat;
                QFile file1(file_name_1);
                QFile file2(file_name_2);
                int newMessage_cnt = 0;
                QString lastMessage = "";
                if (file1.exists())
                {
                    QTextStream ts_1(&file1);
                    file1.open(QFile::ReadOnly | QFile::Text);
                    while(!ts_1.atEnd())
                    {
                        QStringList sl = ts_1.readLine().split(':');
                        if (sl[4] == "unread")
                        {
                            if (sl[1] != login_info[0].toLower())
                            {
                                newMessage_cnt += 1;
                            }
                        }
                        if (sl[0] == 'm')
                        {
                            lastMessage = sl[5];
                        }
                        else
                        {
                            lastMessage = sl[5].split(',')[0];
                        }
                    }
                }
                if (file2.exists())
                {
                    QTextStream ts_2(&file2);
                    file2.open(QFile::ReadOnly | QFile::Text);
                    while(!ts_2.atEnd())
                    {
                        QStringList sl = ts_2.readLine().split(':');
                        if (sl[4] == "unread")
                        {
                            if (sl[1] != login_info[0].toLower())
                            {
                                newMessage_cnt += 1;
                            }
                        }
                        if (sl[0] == 'm')
                        {
                            lastMessage = sl[5];
                        }
                        else
                        {
                            lastMessage = sl[5].split(',')[0];
                        }                    }
                }
                result += "(*)" + QString::number(newMessage_cnt) + "(*)" + lastMessage;
                if (activeClients->contains(chat) == true)
                {
                    result += "(*)";
                    result += "Online";
                }
                else
                {
                    result += "(*)";
                    result += "Offline";
                }
                result += ',';
            }
            if (result[result.length()-1] != '|')
            {
                result.replace(result.length()-1, 1, "");
            }
            chatlist.close();
            sendMessage("Lack|",client,result);
            for (int i = 0 ;i < 10000; i++);
            inform_i_am_online(login_info[0].toLower(),chatList_users);
        }
        else if (state == "Password is incorrect")
        {
            sendMessage("Lnack|",client,"PII");
        }
        else if (state == "UserName is not exist")
        {
            sendMessage("Lnack|",client,"UINE");
        }
    }
    else if (fileType == "search")
    {
        QFile file("usernames");
        QTextStream ts(&file);
        QStringList sl;
        bool first = true;
        QString result = "";
        QString user_info = QString::fromStdString(buffer.toStdString());
        file.open(QFile::ReadOnly | QFile::Text);
        while (!ts.atEnd())
        {
            sl = ts.readLine().split(',');
            if (sl[0].toLower().startsWith(user_info.toLower()))
            {
                qInfo() << user_info;
                if (first == true)
                {
                    first = false;
                }
                else
                {
                    result += ',';
                }
                result += sl[0];
                //break;
            }
        }
        sendMessage("search|",client,result);
        file.close();
    }
    else if (fileType == "get_chats")
    {
        QStringList sl = header.split(",");
        QString whosend = sl[2].split(":")[1].split('|')[0];
        QString toWho = sl[1].split(":")[1];
        QString messages = "";
        QString chat_file_name = whosend + "To" + toWho;
        QString chat_file_name1 = toWho + "To" + whosend;
        QFile chat_file(chat_file_name);
        QFile chat_file1(chat_file_name1);
        QTextStream ts(&chat_file);
        QTextStream ts1(&chat_file1);
        if (chat_file.exists()== true)
        {
            chat_file.open(QFile::ReadOnly | QFile::Text);
            while(!ts.atEnd())
            {
                messages += ts.readLine();
                messages += "|^|";
            }
            chat_file.close();
        }
        if (chat_file1.exists() == true)
        {
            chat_file1.open(QFile::ReadOnly | QFile::Text);
            while(!ts1.atEnd())
            {
                messages += ts1.readLine();
                messages += "|^|";
            }
            chat_file1.close();
        }
        if (messages != "")
        {
            messages.replace(messages.length()-3,3,"");
            qInfo() << messages;
            sendMessage(QString("privatechats,chatname:%1|").arg(sl[1].split(":")[1]),client,messages);
        }
    }
    else if (fileType == "change_message_state")
    {
        QStringList sl = header.split(",");
        QString whosend = sl[2].split(":")[1].split('|')[0];
        QString toWho = sl[1].split(":")[1];
        QString file_name_1 = whosend + "To" + toWho;
        QString file_name_2 = toWho + "To" + whosend;
        QFile file1(file_name_1);
        QFile file2(file_name_2);
        if (file1.exists())
        {
            QFile tmp(QString(file_name_1 + "tmp"));
            QTextStream ts_f1(&file1);
            QTextStream ts_tmp(&tmp);
            file1.open(QFile::ReadOnly | QFile::Text);
            tmp.open(QFile::WriteOnly | QFile::Text);
            while (!ts_f1.atEnd())
            {
                QStringList sl = ts_f1.readLine().split(':');
                if (toWho == sl[1])
                {
                    ts_tmp << sl[0] << ":" << sl[1] << ":" << sl[2] << ":" << sl[3] << ":" << "read" << ":" << sl[5] << '\n';
                }
                else
                {
                    ts_tmp << sl[0] << ":" << sl[1] << ":" << sl[2] << ":" <<sl[3] << ":" << sl[4] << ":" << sl[5] << '\n';
                }
            }
            file1.close();
            file1.remove();
            tmp.close();
            tmp.rename(file_name_1);
        }
        if (file2.exists())
        {
            QFile tmp(QString(file_name_2 + "tmp"));
            QTextStream ts_f2(&file2);
            QTextStream ts_tmp(&tmp);
            file2.open(QFile::ReadOnly | QFile::Text);
            tmp.open(QFile::WriteOnly | QFile::Text);
            while (!ts_f2.atEnd())
            {
                QStringList sl = ts_f2.readLine().split(':');
                if (toWho == sl[1])
                {
                    ts_tmp << sl[0] << ":" << sl[1] << ":" << sl[2] << ":" << sl[3] << ":" << "read" << ":" << sl[5] << '\n';
                }
                else
                {
                    ts_tmp << sl[0] << ":" << sl[1] << ":" << sl[2] << ":" <<sl[3] << ":" << sl[4] << ":" << sl[5] << '\n';
                }
            }
            file2.close();
            file2.remove();
            tmp.close();
            tmp.rename(file_name_2);
        }
        inform_update_of_message_state(whosend,toWho);
    }
}
void clientMethods::inform_i_am_online(QString iam, QString chatlist)
{
    QByteArray header = (QString("i_am_online|")).toUtf8();
    QByteArray buffer = iam.toUtf8();
    header.resize(128);
    buffer.prepend(header);
    QStringList sl = chatlist.split(',');
    for (int i = 0; i < sl.length(); i++)
    {
        QString send_inform_to_who = "";
        for (auto [key, value] : activeClients->asKeyValueRange())
        {
            if (key == sl[i])
            {
                send_inform_to_who = value;
            }
        }
        if (send_inform_to_who != "")
        {
            for (const auto &client : qAsConst(*_clients))
            {
                if (getClientKey(client) == send_inform_to_who)
                {
                    qInfo() << "sent";
                    client->write(buffer);
                    client->flush();
                }
            }
        }
    }
}
void clientMethods::inform_update_of_message_state(QString whosend,QString toWho)
{
    QByteArray header = (QString("inform_message_state|")).toUtf8();
    QByteArray buffer = QString(whosend).toUtf8();
    header.resize(128);
    buffer.prepend(header);
    QString towhoinfo = "";
    for (auto [key, value] : activeClients->asKeyValueRange())
    {
        if (key == toWho)
        {
            towhoinfo = value;
        }
    }
    for (const auto &client : qAsConst(*_clients))
    {
        if (getClientKey(client) == towhoinfo)
        {
            qInfo() << "sent";
            client->write(buffer);
            client->flush();
        }
    }
}
void clientMethods::sendMessage(const QString type,const QTcpSocket *client,const QString &message)
{
    long long receiver = client->socketDescriptor();
    for (const auto &client : qAsConst(*_clients))
    {
        if(client->socketDescriptor() == receiver)
        {
            QByteArray header;
            header.prepend(QString("%1").arg(type).toUtf8());
            header.resize(128);
            QByteArray byteArray = message.toUtf8();
            byteArray.prepend(header);
            client->write(byteArray);
            client->flush();
            qInfo() << "sent atchmnt";
            break;
        }
    }
}
void clientMethods::update_personal_chat_file(QString whosend,QString toWho,QString message,QString time,bool is_atchmnt)
{
    qInfo() << "started" << whosend << ":" << toWho;
    QFile file(whosend + "To" + toWho);
    QFile file1(toWho + "To" + whosend);
    QTextStream ts(&file);
    QTextStream ts1(&file1);
    bool chat_exist = false;
    if (file.exists())
    {
        file.open(QFile::Append | QFile::Text);
        if (is_atchmnt == false)
        {
            ts << "m:" << whosend << ":" << time << ":" << "unread" <<":" << message << '\n';
        }
        else
        {
            ts << "a:" << whosend << ':' << time << ':' << "unread" << ':' << message << '\n';
        }
        file.close();
        chat_exist = true;
    }
    else if (file1.exists())
    {
        file1.open(QFile::Append | QFile::Text);
        if (is_atchmnt == false)
        {
            ts1 << "m:" << whosend << ":" << time << ":" << "unread" <<":" << message << '\n';
        }
        else
        {
            ts1 << "a:" << whosend << ':' << time << ':' << "unread" << ':' << message << '\n';
        }
        file1.close();
        chat_exist = true;
    }
    else
    {
        file.open(QFile::Append | QFile::Text);
        if (is_atchmnt == false)
        {
            ts << "m:" << whosend << ":" << time << ":" << "unread" <<":" << message << '\n';
        }
        else
        {
            ts << "a:" << whosend << ':' << time << ':' << "unread" << ':' << message << '\n';
        }
        file.close();
    }
    if (chat_exist == false)
    {
        qInfo() << "didnt exist";
        QString Sender_chatlist_name = whosend + "_chatlist";
        QString receiver_chatlist_name = toWho + "_chatlist";
        QFile chatlist(Sender_chatlist_name);
        QFile chatlist1(receiver_chatlist_name);
        QTextStream cl_ts1(&chatlist1);
        QTextStream cl_ts(&chatlist);
        QTextStream checker1(&chatlist1);
        QTextStream checker(&chatlist);
        chatlist.open(QFile::ReadOnly | QFile::Text);
        bool error = false;
        while(!checker.atEnd())
        {
            QString username = checker.readLine();
            if (username == toWho)
            {
                error = true;
                break;
            }
        }
        chatlist.close();
        chatlist1.open(QFile::ReadOnly | QFile::Text);
        while (!checker1.atEnd())
        {
            QString username = checker1.readLine();
            if (username == whosend)
            {
                error = true;
                break;
            }
        }
        chatlist1.close();
        if (error == false)
        {
            chatlist.open(QFile::Append | QFile::Text);
            cl_ts  << toWho << '\n';
            chatlist.close();
            chatlist1.open(QFile::Append | QFile::Text);
            cl_ts1 << whosend << '\n';
            chatlist1.close();
        }
    }
    return;
}
void clientMethods::onNewMessage(const QByteArray &ba)
{
    QByteArray buffer = ba;
    qInfo() << QString::fromStdString(buffer.toStdString());
    QString towho = "",towhoinfo = "";
    buffer = buffer.mid(128);
    towho = QString::fromStdString(buffer.toStdString()).split(":")[1];
    for (auto [key, value] : activeClients->asKeyValueRange())
    {
        if (key == towho)
        {
            towhoinfo = value;
        }
    }
    qInfo() << towho << towhoinfo;
    for (const auto &client : qAsConst(*_clients))
    {
        if (getClientKey(client) == towhoinfo)
        {
            qInfo() << "sent";
            client->write(ba);
            client->flush();
        }
    }
}

QString clientMethods::getClientKey(const QTcpSocket *client) const
{
    return client->peerAddress().toString().append(":").append(QString::number(client->peerPort()));
}
