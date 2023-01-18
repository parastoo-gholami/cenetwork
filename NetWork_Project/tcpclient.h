#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QFile>
#include <QStandardPaths>
#include <QMetaType>
class tcpClient : public QObject
{
    Q_OBJECT
public:
    explicit tcpClient(QObject *parent = nullptr);
signals:
    void login_message(const QByteArray &message);
    void signup_message(const QByteArray &message);
    void get_logged_in_UserName(QByteArray liu);
    void get_chatslist(QByteArray chtslist);
    void get_Message(QByteArray mr);
    void search_result(QByteArray sr);
    void get_selected_chat_message(QByteArray CM);
    void selectReceiverchange();
    void message_state(QByteArray info);
    void new_online_user(QByteArray user);
    void new_offline_user(QByteArray user);
private slots:
    void onReadyRead();
public slots:
    void onSignupSubmitClicked(QString UserName,QString Password,QString email);
    void onSigninSubmitClicked(QString UserName,QString Password);
    void onSearchBoxClicked(QString txt);
    void onSendMessageCLicked(QString content,QString time);
    void send_signal_to_change_messages_state(QString whosend,QString toWho);
    void selectReceiver(QString rcvr);
    void select_chat(QString sc);
    void send_signal_to_get_chats(QString whosend,QString toWho);
    void send_signal_to_get_attachment(QString name,QString path);
    QString get_file_size();
    QString get_selected_chat();
//    void onUpdateChatList(QString sender,QString newUser);
    QString getReceiver();
    void send_attachment(QString filepath,QString sender,QString towho,QString time);
private:
    QTcpSocket socket;
    QByteArray logged_in_UserName;
    QByteArray message_receiver;
    QString selected_chat = "null";
    QString filesize;
};

#endif // TCPCLIENT_H
