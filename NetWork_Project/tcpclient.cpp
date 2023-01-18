#include "tcpclient.h"

tcpClient::tcpClient(QObject *parent)
    : QObject{parent}
{
    socket.connectToHost(QHostAddress::LocalHost,45000);
    connect(&socket, &QTcpSocket::readyRead,this,&tcpClient::onReadyRead);
    if(socket.waitForConnected())
    {
        qInfo() << ("Connected to Server");
    }
    else
    {
        qInfo() << "DisConnected";
    }

}
void tcpClient::onSignupSubmitClicked(QString UserName,QString Password,QString email)
{
    QString str = UserName + ',' + Password + ',' + email;
    QByteArray header;
    header.prepend(QString("fileType:register,fileName:null,fileSize:%1").arg(str.size()).toUtf8());
    header.resize(128);
    QByteArray byteArray = str.toUtf8();
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
void tcpClient::onSigninSubmitClicked(QString UserName,QString Password)
{
    QString str = UserName + ',' + Password;
    QByteArray header;
    header.prepend(QString("fileType:login,fileName:null,fileSize:%1").arg(str.size()).toUtf8());
    header.resize(128);
    QByteArray byteArray = str.toUtf8();
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
void tcpClient::onReadyRead()
{
    QTcpSocket* client = reinterpret_cast<QTcpSocket*>(sender());
    if (client == nullptr)
    {
        return;
    }
    QStringList header;
    QByteArray buffer;
    buffer = client->readAll();
    header = QString ::fromStdString(buffer.mid(0,128).toStdString()).split('|');
    buffer = buffer.mid(128);
    qInfo() << header[0];
    //qInfo() << header << "," << QString::fromStdString(buffer.toStdString());
    if (header[0] == "Sack")
    {
        emit signup_message(header[0].toUtf8());
    }
    else if (header[0] == "Lack")
    {
        QString str = QString::fromStdString(buffer.toStdString());
        QString sign_in_username = "";
        QString chatslist_info = "";
        if (str[str.length() - 1] == '|')
        {
            sign_in_username = str;
            sign_in_username = sign_in_username.replace(sign_in_username.length()-1,1,"");
        }
        else
        {
            sign_in_username = QString::fromStdString(buffer.toStdString()).split('|')[0];
            chatslist_info = QString::fromStdString(buffer.toStdString()).split('|')[1];
        }
        logged_in_UserName = sign_in_username.toUtf8();
        emit login_message(header[0].toUtf8());
        emit get_logged_in_UserName(logged_in_UserName);
        emit get_chatslist(chatslist_info.toUtf8());
    }
    else if (header[0] == "Snack")
    {
        emit signup_message(buffer);
    }
    else if (header[0] == "Lnack")
    {
        emit login_message(buffer);
    }
    else if (header[0] == "search")
    {
        emit search_result(buffer);
    }
    else if (header[0] == "message" || header[0] == "atchmnt")
    {
        emit get_Message(buffer);
        if (selected_chat == QString::fromStdString(buffer.toStdString()).split(':')[2])
        {
            send_signal_to_change_messages_state(logged_in_UserName,selected_chat);
        }
    }
    if (header[0].split(',')[0] == "privatechats")
    {
        buffer.prepend(QString(header[0].split(',')[1].split(':')[1] + "$!$").toUtf8());
        qInfo() << QString::fromStdString(buffer.toStdString());
        emit get_selected_chat_message(buffer);
    }
    else if (header[0] == "inform_message_state")
    {
        emit message_state(buffer);
    }
    else if (header[0] == "i_am_online")
    {
        emit new_online_user(buffer);
    }
    else if (header[0] == "i_am_offline")
    {
        emit new_offline_user(buffer);
    }
    else if (header[0].split(',')[0] == "get_file")
    {
        qInfo() << "start";
        //QString name = QString::fromStdString(buffer.toStdString()).split(',')[0];
        //QString data = QString::fromStdString(buffer.toStdString()).split(',')[1];
        QFile file(header[0].split(',')[1]);
        if (file.open(QIODevice::WriteOnly))
        {
            file.write(buffer);
            file.close();
            qInfo() << "done";
        }
    }
}
void tcpClient::onSearchBoxClicked(QString txt)
{
    QString str = txt;
    QByteArray header;
    header.prepend(QString("fileType:search,fileName:null,fileSize:%1").arg(str.size()).toUtf8());
    header.resize(128);
    QByteArray byteArray = str.toUtf8();
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
void tcpClient::onSendMessageCLicked(QString content,QString time)
{
    QString str = content;
    QByteArray header;
    header.prepend(QString("fileType:message,receiver:%1,sender:%2,time:%3|").arg(message_receiver,logged_in_UserName,time).toUtf8());
    header.resize(128);
    QByteArray byteArray = str.toUtf8();
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
void tcpClient::selectReceiver(QString rcvr)
{
    message_receiver = rcvr.toUtf8();
    emit selectReceiverchange();
}
void tcpClient::select_chat(QString sc)
{
    selected_chat = sc;
}
QString tcpClient::get_selected_chat()
{
    return selected_chat;
}
QString tcpClient::getReceiver()
{
    return QString::fromStdString(message_receiver.toStdString());
}
void tcpClient::send_signal_to_get_chats(QString whosend,QString toWho)
{
    QByteArray header;
    header.prepend(QString("fileType:get_chats,receiver:%1,sender:%2|").arg(toWho,whosend).toUtf8());
    header.resize(128);
    QByteArray byteArray;
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
void tcpClient::send_signal_to_change_messages_state(QString whosend,QString toWho)
{
    QByteArray header;
    header.prepend(QString("fileType:change_message_state,receiver:%1,sender:%2|").arg(toWho,whosend).toUtf8());
    header.resize(128);
    QByteArray byteArray;
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
void tcpClient::send_attachment(QString filepath,QString sender,QString towho,QString time)
{
    if(filepath.isEmpty() == false)
    {
        qInfo() << filepath;
        QFile file(QString("///"+filepath.split("///")[1]));
        if (file.open(QIODevice::ReadOnly))
        {
            QStringList sl = filepath.split("///")[1].split('/');
            QString filename = sl[sl.length()-1];
            filesize = QString::number(file.size());
            QByteArray header = QString("fileType:attchment,receiver:%1,sender:%2,filename:%3,filesize:%4,time:%5|").arg(towho,sender,filename,QString::number(file.size()),time).toUtf8();
            header.resize(128);
            QByteArray buffer = file.readAll();
            buffer.prepend(header);
            socket.write(buffer);
            socket.flush();
            file.close();
        }
        else
        {
            qInfo() << "WTF";
        }
    }
    else
    {
        qInfo() << "failed to send atch";
    }
}
void tcpClient::send_signal_to_get_attachment(QString name,QString path)
{
    QByteArray header;
    header.prepend(QString("fileType:get_attchmnt,filename:%1|").arg(name).toUtf8());
    header.resize(128);
    QByteArray byteArray = path.toUtf8();
    byteArray.prepend(header);
    socket.write(byteArray);
    socket.flush();
}
QString tcpClient::get_file_size()
{
    return filesize;
}
