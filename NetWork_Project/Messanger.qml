import QtQuick
import QtQuick.Window 2.11
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Dialogs
import QtCore
Window {
    id : windo
    visible: true
    property string usernm: ""
    property string searchr: ""
    property string selected_chat: "null"
    property var chatlist : []
    property var allchats : new Map();
    property var onlineUsers: []
    property var files: new Map();
    //function
    function find(model, criteria,lstmsg) {
      for(var cnt = 0; cnt < model.count; ++cnt)
          if (criteria(model.get(cnt)))
          {
              model.set(cnt,{username : model.get(cnt).username,
                            lastmessage : lstmsg,cntr : model.get(cnt).cntr,
                            is_visible : model.get(cnt).is_visible,
                            is_enabled : model.get(cnt).is_enabled})
          }
      return
    }
    function change_cntr(model, criteria) {
      for(var cnt = 0; cnt < model.count; ++cnt)
          if (criteria(model.get(cnt)))
          {
              let tmp = model.get(cnt).cntr
              let x = parseInt(tmp)
              x += 1
              if (x > 0)
              {
                  model.set(cnt,{username : model.get(cnt).username,
                                lastmessage : model.get(cnt).lastmessage,
                                cntr : x.toString(),is_visible : true,
                                is_enabled : model.get(cnt).is_enabled})
              }
          }
      return null
    }
    function change_message_state(model, criteria) {
      for(var cnt = 0; cnt < model.count; ++cnt)
          if (criteria(model.get(cnt)))
          {
              model.set(cnt,{mygod : model.get(cnt).mygod,
                            message : model.get(cnt).message,
                            sendertxt : model.get(cnt).sendertxt,
                            currtime : model.get(cnt).currtime,
                            is_read : true,newRectCheck_visiblity : true})
          }
      return null
    }
    function convert_to_zero(model, criteria) {
      for(var cnt = 0; cnt < model.count; ++cnt)
          if (criteria(model.get(cnt)))
          {
              let tmp = model.get(cnt).cntr
              let x = parseInt(tmp)
              if (x > 0)
              {
                  model.set(cnt,{username : model.get(cnt).username,
                                lastmessage : model.get(cnt).lastmessage,
                                cntr : "0",
                                is_visible : false,
                                is_enabled : model.get(cnt).is_enabled})
                  return
              }
          }
      return
    }
    //function
    title: qsTr("Messanger")
    visibility: Window.FullScreen//"FullScreen"
    Connections {
        target: client
        property string totalmsg: ""
        property bool tmp: false
        function onMessage_state(info)
        {
            let whosend = info + ""
            let tmp = ""
            let messages = allchats.get(whosend).split("|^|")
            for (let i = 0; i < messages.length; i++)
            {
                let message_split = messages[i].split(':')
                tmp += message_split[0] + ':' + message_split[1] + ':' + message_split[2] + ':' + message_split[3] + ':' + 'read' + ':'
                tmp += message_split[5] + "|^|"
            }
            tmp = tmp.substring(0,tmp.length-3)
            allchats.set(whosend,tmp)
            if (selected_chat === whosend)
            {
                change_message_state(lmchat, function(item) {
                    if (item.sendertxt === usernm)
                    {
                        return true
                    }
                    return false
                })
            }
        }
        function onGet_selected_chat_message(msg)
        {
            let message = msg + ""
            console.log("1:" + message);
            let messageArray = message.split("$!$")
            allchats.set(messageArray[0],messageArray[1])
            let split_chat_message = messageArray[1].split("|^|")
            let every_message = []
            for (let j = 0; j < split_chat_message.length; j++)
            {
                every_message = split_chat_message[j].split(':')
                let is_readed = false
                if (every_message[4] === "read")
                {
                    is_readed = true
                }
                if (usernm === every_message[1])
                {
                    if (every_message[0] === 'm')
                    {
                        lmchat.append(
                                    {
                                        mygod : true,
                                        message : every_message[5],
                                        sendertxt : every_message[1],
                                        currtime : every_message[2] + ':' +every_message[3],
                                        is_read : is_readed,
                                        newRectCheck_visiblity : true,
                                        is_an_attachment : false
                                    } )
                    }
                    else
                    {
                        let file_info = every_message[5].split(',')
                        lmchat.append(
                                    {
                                        mygod : true,
                                        message : file_info[0],
                                        sendertxt : every_message[1],
                                        currtime : every_message[2] + ':' +every_message[3],
                                        is_read : is_readed,
                                        newRectCheck_visiblity : true,
                                        is_an_attachment : true
                                    } )
                        files.set(file_info[0],file_info[2])
                    }
                }
                else
                {
                    if (every_message[0] === 'm')
                    {
                        lmchat.append(
                                    {
                                        mygod : false,
                                        message : every_message[5],
                                        sendertxt : every_message[1],
                                        currtime : every_message[2] + ':' +every_message[3],
                                        is_read : is_readed,
                                        newRectCheck_visiblity : false,
                                        is_an_attachment : false
                                    } )
                    }
                    else
                    {
                        let file_info = every_message[5].split(',')
                        lmchat.append(
                                    {
                                        mygod : true,
                                        message : file_info[0],
                                        sendertxt : every_message[1],
                                        currtime : every_message[2] + ':' +every_message[3],
                                        is_read : is_readed,
                                        newRectCheck_visiblity : true,
                                        is_an_attachment : true
                                    } )
                        files.set(file_info[0],file_info[2])
                    }
                }
            }
            convert_to_zero(lmchats, function(item) {
                if (item.username === selected_chat)
                {
                    return true
                }
                return false
            })
            bro.positionViewAtEnd()
        }
        function onGet_Message(msg)//m/a,towho,whosend,msg,time
        {
            totalmsg = msg + "";
            if (totalmsg !== "")
            {
                let msgsplited = totalmsg.split(":");
                if (msgsplited[2] !== usernm)
                {
                    if (selected_chat === msgsplited[2])
                    {
                        if (msgsplited[0] === "m")
                        {
                            lmchat.append(
                                        {
                                            mygod : false,
                                            message : msgsplited[3],
                                            sendertxt : msgsplited[2],
                                            currtime : msgsplited[4] + ':' +msgsplited[5],
                                            is_readed : false,
                                            newRectCheck_visiblity : false,
                                            is_an_attachment : false
                                        } )
                            let tmp = allchats.get(msgsplited[2])
                            tmp += "|^|"
                            tmp += "m:" + msgsplited[2] + ':' + msgsplited[4] + ':' + msgsplited[5] + ':' + "unread" + ':' + msgsplited[3]
                            allchats.set(msgsplited[2],tmp)
                        }
                        else
                        {
                            let file_info = msgsplited[3].split(',')
                            lmchat.append(
                                        {
                                            mygod : false,
                                            message : file_info[0],
                                            sendertxt : msgsplited[2],
                                            currtime : msgsplited[4] + ':' +msgsplited[5],
                                            is_readed : false,
                                            newRectCheck_visiblity : false,
                                            is_an_attachment : true
                                        } )
                            let tmp = allchats.get(msgsplited[2])
                            tmp += "|^|"
                            tmp += 'a' + ':' + msgsplited[2] + ':' + msgsplited[4] + ':' + msgsplited[5] + ':' + "unread" + ':' + msgsplited[3]
                            allchats.set(msgsplited[2],tmp)
                            files.set(file_info[0],file_info[2])
                        }
                    }
                    else
                    {
                        let is_chat_exist = false
                        for (let i = 0; i < chatlist.length;i++)
                        {
                            if (msgsplited[2] === chatlist[i])
                            {
                                is_chat_exist = true
                                break
                            }
                        }
                        if (is_chat_exist === false)
                        {
                            if (msgsplited[0] === "m")
                            {
                                chatlist.push(msgsplited[2])
                                lmchats.append(
                                            {
                                             username : msgsplited[2],
                                             lastmessage : msgsplited[3],
                                             cntr : "0",
                                             is_visible : false,
                                             is_enabled : true
                                            })
                            }
                            else
                            {
                                chatlist.push(msgsplited[2])
                                let file_info = msgsplited[3].split(',')
                                lmchats.append(
                                            {
                                             username : msgsplited[2],
                                             lastmessage : file_info[0],
                                             cntr : "0",
                                             is_visible : false,
                                             is_enabled : true
                                            })
                            }
                        }
                        else
                        {
                            if (allchats.has(msgsplited[2]))
                            {
                                if (msgsplited[0] === "m")
                                {
                                    let tmp = allchats.get(msgsplited[2])
                                    tmp += "|^|"
                                    tmp += "m:" + msgsplited[2] + ':' + msgsplited[4] + ':' + msgsplited[5] + ':' + "unread" + ':' + msgsplited[3]
                                    allchats.set(msgsplited[2],tmp)
                                }
                                else
                                {
                                    let tmp = allchats.get(msgsplited[2])
                                    tmp += "|^|"
                                    tmp += 'a' + ':' + msgsplited[2] + ':' + msgsplited[4] + ':' + msgsplited[5] + ':' + "unread" + ':' + msgsplited[3]
                                    allchats.set(msgsplited[2],tmp)
                                    files.set(file_info[0],file_info[2])
                                }
                            }
                        }
                        change_cntr(lmchats, function(item) {
                            if (item.username === msgsplited[2])
                            {
                                return true
                            }
                            return false
                        })
                    }
                    if (msgsplited[0] === "m")
                    {
                        find(lmchats, function(item) {
                            if (item.username === msgsplited[2])
                            {
                                return true
                            }
                            return false
                        },msgsplited[3])
                    }
                    else
                    {
                        find(lmchats, function(item) {
                            if (item.username === msgsplited[2])
                            {
                                return true
                            }
                            return false
                        },msgsplited[3].split(',')[0])
                    }
                }
            }
        }
        property var searchrs: []
        function onSearch_result(sr)
        {
            searchr = sr + "";
            if (searchr !== "" && searchr !== usernm)
            {
                searchrs = searchr.split(',')
                for (let i = 0; i < searchrs.length; i++)
                {
                    lmsearch.append({
                                        username : searchrs[i]
                                    })
                }
            }
        }
        function onGet_logged_in_UserName(logged_in_UserName)
        {
            usernm = logged_in_UserName + "";
        }
        property string cl_info: ""
        function onGet_chatslist(chtlist_info)
        {
            cl_info = chtlist_info + ""
            if (cl_info !== "")
            {
                var cl_info_list = cl_info.split(',')
                for (let i = 0; i < cl_info_list.length; i++)
                {
                    let split_chatlist_info = cl_info_list[i].split("(*)")
                    let vis = false
                    if (parseInt(split_chatlist_info[1]) > 0)
                    {
                        vis = true
                    }
                    lmchats.append(
                                {
                                    username : split_chatlist_info[0],
                                    lastmessage : split_chatlist_info[2],
                                    cntr : split_chatlist_info[1],
                                    is_visible : vis,
                                    is_enabled : true
                                })
                    chatlist.push(split_chatlist_info[0])
                    if (split_chatlist_info[3] === "Online")
                    {
                        onlineUsers.push(split_chatlist_info[0])
                    }
                }
            }
        }
        function onSelectReceiverchange()
        {
            lmchat.clear();
        }
        function onNew_online_user(user)
        {
            let user_who_logged_in_recently = user + ""
            if (selected_chat === user_who_logged_in_recently)
            {
               status_txt.text = "Online"
            }
            onlineUsers.push(user_who_logged_in_recently)
        }
        function onNew_offline_user(user)
        {
            let user_who_disconnected_recently = user + ""
            if (selected_chat === user_who_disconnected_recently)
            {
                status_txt.text = "Offline"
            }
            let index = onlineUsers.indexOf(user_who_disconnected_recently)
            if (index > -1)
            {
                onlineUsers.splice(index,1)
            }
        }
    }
    Rectangle{
        id:asli
        anchors.fill: parent
        Image {
            id: exit
            source: "qrc:/icons/power.png"
            x:windo.width-60
            y:10
            height: 50
            width:50
            MouseArea{
                anchors.fill:parent
                onClicked: {
                    windo.close();
                }
            }
        }
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color : "#25081c"
            }
            GradientStop {
                position: 0.70;
                color : "black"
            }
        }
        Rectangle{
            id:bigrect
            anchors.centerIn: asli
            width: asli.width -175
            height: asli.height -175
            color: "#cc10202b"
            radius: 10
            Column
            {
                id:leftbutton
                y:50
                MButton
                {
                    buttonText : "Chats"

                    onButtonClicked:
                    {
                        console.log("Clicked on contacts from main file")
                    }

                }
                MLine{}
                MButton
                {
                    buttonText : "Groups"
                    onButtonClicked:
                    {
                        console.log("Clicked on groups from main file")
                    }
                }
                MLine{}
            }
        }
        Rectangle
        {
            id:rect
            radius: 20
            width:bigrect.width -150
            anchors.rightMargin: 1
            anchors.topMargin: 1
            anchors.bottomMargin: 1
            anchors.right: bigrect.right
            height: bigrect.height
            anchors.top: bigrect.top
            anchors.bottom: bigrect.bottom
            color : "#b3332e4f"
            border.color: "#04101c"
            border.width : 1
            Rectangle
            {
                id:search
                width: 530
                height:50
                color : "transparent"
                opacity:0.5
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 10
                TextField
                {
                    id:searchbox
                    x : 15
                    width: 220
                    height: 50
                    //anchors.centerIn: parent
                    selectByMouse: true
                    wrapMode: TextInput.WrapAnywhere
                    font.pointSize: 15
                    placeholderText: qsTr("Search...")
                    background: Rectangle
                    {
                        color: "#cc5f7980"
                        radius : 10
                    }
                    onContentSizeChanged: {
                        lmsearch.clear();
                        if (searchbox.text !== "")
                        {
                            client.onSearchBoxClicked(searchbox.text);
                        }
                    }
                }
                Image {
                    anchors.left: search.right
                    y : 15
                    id: searchicon
                    anchors.centerIn: parent
                    source: "qrc:/icons/search(1).png"
                    width: 45
                    height: 45
                    z : 1
                }
            }
            Rectangle {
                id : lvbackground
                border.color: "#162527"
                anchors.top: search.bottom
                border.width: 1
                color : "#661f363d"
                y:70
                radius: 10
                width: 290
                height: 200
                anchors.left: parent.left
                anchors.leftMargin: 5
                ListView
                {
                    anchors.fill: parent
                    anchors.margins: 3
                    id : lv
                    clip:true
                    spacing: 2
                    model:ListModel
                    {
                        id :lmsearch
                    }
                    delegate: Rectangle
                    {
                        width: 284
                        height : 70
                        color : "#cc10202b"
                        radius : 10
                        Rectangle {
                            id : chatprofilesearch
                            y : 5
                            x : 5
                            width : 60
                            height : 60
                            radius: 100
                            color : "#1c525e"
                        }
                        Text {
                            id: chatheadsearch
                            text: username
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            color : "white"
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                color = "#322d4f"
                            }
                            onExited: {
                                color = "#cc10202b"
                            }
                            onClicked:
                            {
                                if (selected_chat !== chatheadsearch.text)
                                {
                                    console.log("Clicked on search "+chatheadsearch.text)
                                    client.select_chat(chatheadsearch.text)
                                    selected_chat = chatheadsearch.text
                                    send_chats.visible = true
                                    info_of_selected_chat.visible = true
                                    chatbackground.visible = true
                                    client.selectReceiver(chatheadsearch.text)
                                    let is_online = false
                                    for (let i = 0; i < onlineUsers.length; i++)
                                    {
                                        if (selected_chat === onlineUsers[i])
                                        {
                                            status_txt.text = "Online"
                                            is_online = true
                                            break
                                        }
                                    }
                                    if (is_online === false)
                                    {
                                        status_txt.text = "Offline"
                                    }
                                    let is_any_chat_exist = allchats.has(selected_chat)
                                    let is_any_unread_exist = false
                                    if (is_any_chat_exist === true)
                                    {
                                        let split_chat_message = allchats.get(selected_chat).split("|^|")
                                        for (let j = 0; j < split_chat_message.length; j++)
                                        {
                                            let every_message = split_chat_message[j].split(':')
                                            let is_readed = false
                                            if (every_message[4] === "read")
                                            {
                                                is_readed = true
                                            }
                                            if (every_message[4] === "unread" && every_message[1] === selected_chat)
                                            {
                                                is_any_unread_exist = true
                                            }
                                            if (usernm === every_message[1])
                                            {
                                                if (every_message[0] === 'm')
                                                {
                                                    lmchat.append(
                                                                {
                                                                    mygod : true,
                                                                    message : every_message[5],
                                                                    sendertxt : every_message[1],
                                                                    currtime : every_message[2] + ':' +every_message[3],
                                                                    is_read : is_readed,
                                                                    newRectCheck_visiblity : true,
                                                                    is_an_attachment : false
                                                                } )
                                                }
                                                else
                                                {
                                                    let file_info = every_message[5].split(',')
                                                    lmchat.append(
                                                                {
                                                                    mygod : true,
                                                                    message : file_info[0],
                                                                    sendertxt : every_message[1],
                                                                    currtime : every_message[2] + ':' +every_message[3],
                                                                    is_read : is_readed,
                                                                    newRectCheck_visiblity : true,
                                                                    is_an_attachment : true
                                                                } )
                                                }
                                            }
                                            else
                                            {
                                                if (every_message[0])
                                                {
                                                    lmchat.append(
                                                                {
                                                                    mygod : false,
                                                                    message : every_message[5],
                                                                    sendertxt : every_message[1],
                                                                    currtime : every_message[2] + ':' +every_message[3],
                                                                    is_read : is_readed,
                                                                    newRectCheck_visiblity : false,
                                                                    is_an_attachment : false
                                                                } )
                                                }
                                                else
                                                {
                                                    let file_info = every_message[5].split(',')
                                                    lmchat.append(
                                                                {
                                                                    mygod : true,
                                                                    message : file_info[0],
                                                                    sendertxt : every_message[1],
                                                                    currtime : every_message[2] + ':' +every_message[3],
                                                                    is_read : is_readed,
                                                                    newRectCheck_visiblity : true,
                                                                    is_an_attachment : true
                                                                } )
                                                }
                                            }
                                        }
                                        convert_to_zero(lmchats, function(item) {
                                            if (item.username === selected_chat)
                                            {
                                                return true
                                            }
                                            return false
                                        })
                                    }
                                    else if (is_any_chat_exist === false)
                                    {
                                        client.send_signal_to_get_chats(usernm,selected_chat)
                                    }
                                    if (is_any_unread_exist === true)
                                    {
                                        client.send_signal_to_change_messages_state(usernm,selected_chat)
                                    }
                                    bro.positionViewAtEnd()
                                }
                            }
                        }
                    }

                    ScrollBar.vertical: ScrollBar{}
                }
            }

            Text {
                text : "Chats"
                font.pixelSize: 20;
                color : "white";
                anchors.top: lvbackground.bottom
                anchors.topMargin: 10
                x : 125
            }
            ListView {
                id : lv2
                anchors.left: parent.left
                anchors.top: lvbackground.bottom
                anchors.leftMargin: 5
                anchors.topMargin: 40
                width: 290
                height: 580
                y:70
                clip:true
                spacing: 1
                Rectangle {
                    anchors.fill: parent
                    border.color: "#162527"
                    border.width: 1
                    color : "#661f363d"
                    radius: 10
                    z : -1
                }
                model:ListModel
                {
                    id :lmchats
                }
                delegate: Rectangle
                {
                    width: 290
                    height : 70
                    color : "#cc10202b"
                    enabled: is_enabled
                    Rectangle {
                        id : chatprofile
                        y : 5
                        x : 5
                        width : 60
                        height : 60
                        radius: 100
                        color : "#1c525e"
                    }
                    Text {
                        id: chathead
                        text: username
                        y : 10
                        x : 120
                        font.pixelSize: 20
                        color : "white"
                    }
                    Text {
                        id: lastmsg
                        text: lastmessage
                        y : 40
                        x : 70
                        font.pixelSize: 15
                        width : 215
                        height : 20
                        color : "white"
                    }
                    Rectangle
                    {
                        id: cntrRect
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        visible: is_visible
                        Text {
                            id: cntrtxt
                            text: cntr
                            font.pixelSize: 20
                            anchors.centerIn: parent
                        }
                        y : 9
                        width : 50
                        height : 50
                        radius : 100
                        color : "#99a69494"
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            color = "#322d4f"
                        }
                        onExited: {
                            color = "#cc10202b"
                        }
                        onClicked: {
                            if (selected_chat !== chathead.text)
                            {
                                console.log("Clicked on "+chathead.text)
                                client.select_chat(chathead.text)
                                selected_chat = chathead.text
                                send_chats.visible = true
                                info_of_selected_chat.visible = true
                                chatbackground.visible = true
                                client.selectReceiver(chathead.text)
                                let is_online = false
                                for (let i = 0; i < onlineUsers.length; i++)
                                {
                                    if (selected_chat === onlineUsers[i])
                                    {
                                        status_txt.text = "Online"
                                        is_online = true
                                        break
                                    }
                                }
                                if (is_online === false)
                                {
                                    status_txt.text = "Offline"
                                }
                                let is_any_chat_exist = allchats.has(selected_chat)
                                let is_any_unread_exist = false
                                if (is_any_chat_exist === true)
                                {
                                    let split_chat_message = allchats.get(selected_chat).split("|^|")
                                    for (let j = 0; j < split_chat_message.length; j++)
                                    {
                                        let every_message = split_chat_message[j].split(':')
                                        let is_readed = false
                                        if (every_message[4] === "read")
                                        {
                                            is_readed = true
                                        }
                                        if (every_message[4] === "unread" && every_message[1] === client.get_selected_chat())
                                        {
                                            is_any_unread_exist = true
                                        }
                                        if (usernm === every_message[1])
                                        {
                                            if (every_message[0] === 'm')
                                            {
                                                lmchat.append(
                                                            {
                                                                mygod : true,
                                                                message : every_message[5],
                                                                sendertxt : every_message[1],
                                                                currtime : every_message[2] + ':' +every_message[3],
                                                                is_read : is_readed,
                                                                newRectCheck_visiblity : true,
                                                                is_an_attachment : false
                                                            } )
                                            }
                                            else
                                            {
                                                let file_info = every_message[5].split(',')
                                                lmchat.append(
                                                            {
                                                                mygod : true,
                                                                message : file_info[0],
                                                                sendertxt : every_message[1],
                                                                currtime : every_message[2] + ':' +every_message[3],
                                                                is_read : is_readed,
                                                                newRectCheck_visiblity : true,
                                                                is_an_attachment : true
                                                            } )
                                            }
                                        }
                                        else
                                        {
                                            if (every_message[0] === 'm')
                                            {
                                                lmchat.append(
                                                            {
                                                                mygod : false,
                                                                message : every_message[5],
                                                                sendertxt : every_message[1],
                                                                currtime : every_message[2] + ':' +every_message[3],
                                                                is_read : is_readed,
                                                                newRectCheck_visiblity : false,
                                                                is_an_attachment : false
                                                            } )
                                            }
                                            else
                                            {
                                                let file_info = every_message[5].split(',')
                                                lmchat.append(
                                                            {
                                                                mygod : true,
                                                                message : file_info[0],
                                                                sendertxt : every_message[1],
                                                                currtime : every_message[2] + ':' +every_message[3],
                                                                is_read : is_readed,
                                                                newRectCheck_visiblity : true,
                                                                is_an_attachment : true
                                                            } )
                                            }
                                        }
                                    }
                                    convert_to_zero(lmchats, function(item) {
                                        if (item.username === client.get_selected_chat())
                                        {
                                            return true
                                        }
                                        return false
                                    })
                                }
                                else if (is_any_chat_exist === false)
                                {
                                    client.send_signal_to_get_chats(usernm,client.get_selected_chat())
                                    for (let time = 0; time < 10000; time++);
                                    client.send_signal_to_change_messages_state(usernm,client.get_selected_chat())
                                    for (let time2 = 0; time2 < 10000; time2++);
                                }
                                if (is_any_unread_exist === true)
                                {
                                    client.send_signal_to_change_messages_state(usernm,client.get_selected_chat())
                                }
                                bro.positionViewAtEnd()

                            }
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar{}
            }
            Rectangle
            {
                id:chatrect
                anchors.right: rect.right
                anchors.top: rect.top
                anchors.bottom: rect.bottom
                width:bigrect.width -450
                height: bigrect.height
                Image
                {
                    id: backchat
                    source: "qrc:/images/colorful-abstract-nebula-space-background.jpg"
                    anchors.fill: parent
                }
                Rectangle
                {
                    id:info_of_selected_chat
                    anchors.top: chatrect.top
                    visible: false
                    color: "#1e1b2f"
                    width : chatrect.width
                    height : 70
                    z : 1
                    Rectangle {
                        id: chatname
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.margins: 10
                        height : 50
                        width : chatname_text.width + 30
                        radius: 20
                        z : 1
                        color : "#322d4f"
                        Text {
                            id: chatname_text
                            text: selected_chat
                            font.pixelSize: 25
                            anchors.centerIn: parent
                            color : "white"
                        }
                    }
                    Rectangle {
                        id : status
                        anchors.left : chatname.right
                        anchors.top: parent.top
                        anchors.leftMargin: 10
                        anchors.topMargin: 23
                        height: status_txt.height + 10
                        width: status_txt.width + 10
                        radius: 10
                        color : "#99ffffff"
                        z : 1
                        Text {
                            anchors.centerIn: parent
                            id: status_txt
                            text: "Offline"
                            font.underline: true
                            font.pixelSize: 15
                        }
                    }
                }
                Rectangle {
                    id : chatbackground
                    color : "#66531515"
                    radius: 30
                    z : 1
                    visible: false
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right:parent.right
                    anchors.rightMargin: 20
                    anchors.top: info_of_selected_chat.bottom
                    anchors.topMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 70
                    width: parent.width - 100
                    height: parent.height - scView.height - 20
                    ListView
                    {
                        anchors.fill: parent
                        anchors.margins: 10
                        Rectangle {
                            anchors.fill: parent
                            color : "transparent"
                        }
                        id :bro
                        spacing: 10
                        y:15
                        clip:true
                        model:ListModel
                        {
                            id : lmchat
                        }
                        onCountChanged: {
                           var newIndex = count - 1 // last index
                           positionViewAtEnd()
                           currentIndex = newIndex
                         }
                        delegate: Rectangle
                        {
                            id : newRect
                            color: "#cc543b3b"
                            property bool tmp: mygod
                            property bool atch: is_an_attachment
                            x: tmp ? 0 : chatbackground.width - newRect.width - 20
                            property var totalwidth: ((newRectTxt.width >= newRectSender.width) ? newRectTxt.width + 20  : newRectSender.width + 20)
                            width : atch ? totalwidth + downloadicon.width + 10 : totalwidth
                            height : newRectTxt.height +  newRectSender.height + newRectTime.height + 20
                            border.color : "black"
                            border.width : 1;
                            radius : 20
                            Rectangle {
                                id : downloadicon
                                visible: is_an_attachment
                                enabled: is_an_attachment
                                width : 50
                                height : 50
                                color : "#99ffffff"
                                radius: 50
                                anchors.left: parent.left
                                anchors.margins: 5
                                y : 20
                                z : 0
                                Image {
                                    id:downloadiconimage
                                    z : 1
                                    anchors.centerIn: parent
                                    width: 35
                                    height : 35
                                    source: "qrc:/icons/2058131601582004490-128.png"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        client.send_signal_to_get_attachment(newRectTxt.text,files.get(newRectTxt.text))
                                    }
                                    onEntered: {
                                        downloadicon.color = "#b39c4a4a"
                                    }
                                    onExited: {
                                        downloadicon.color = "#99ffffff"
                                    }
                                }

                            }
                            Text {
                                id :newRectSender
                                x : atch ? 15 + downloadicon.width :10; y : 5; z : 1
                                font.pixelSize: 20
                                text : sendertxt
                                color: "#59878b"
                            }
                            Text {
                                id : newRectTxt
                                x : atch ? 15 + downloadicon.width : 10
                                y : 5 + newRectSender.height + 5
                                color : "white"
                                font.pixelSize: 25
                                text: message;
                            }
                            Text {
                                id:newRectTime
                                x : atch ? 15 + downloadicon.width : 10
                                y : 5 + newRectSender.height + 5 + newRectTxt.height + 5
                                color : "white"
                                font.pixelSize: 15
                                text: currtime
                            }
                            Image {
                                id: newRectCheck
                                source: is_read ? "qrc:/icons/read.png" : "qrc:/icons/check.png"
                                width : 20
                                height : 20
                                visible: newRectCheck_visiblity
                                x : parent.width - 28
                                y : parent.height - 25
                                z : 1
                            }
                        }
                        ScrollBar.vertical: ScrollBar{}
                    }
                }
                Rectangle
                {
                    id: send_chats
                    visible: false
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 5
                    width : chatrect.width - 15
                    height : scView.height
                    radius: 10
                    color : "#1e1b2f"
                    ScrollView
                    {
                        id: scView
                        width: chatrect.width - 145
                        height: 50
                        background: Rectangle
                        {
                            color : "transparent"
                            anchors.fill: parent
                        }
                        TextArea
                        {
                            id: contentText
                            color: "white"
                            y : 7
                            font.pixelSize: 20
                            placeholderText: qsTr("Message...")
                            placeholderTextColor: "white"
                            wrapMode: TextArea.Wrap
                            selectByMouse: true
                        }
                    }
                    MButton {
                        id:atchbtn
                        anchors.right: sendbtn.left
                        anchors.leftMargin: 0
                        clr : "transparent"
                        rdis: 10
                        y:scView.y
                        buttonText : ""
                        Image {
                            anchors.centerIn: parent
                            id: atchicon
                            source: "qrc:/icons/image.png"
                            width: 50
                            height: 50
                        }
                        size: 60
                        onEntred: {
                            clr = "#322d4f"
                        }
                        onExted: {
                            clr = "transparent"
                        }
                        onButtonClicked: {
                            fileDialog.open()
                        }
                    }
                    FileDialog {
                        property string filepath: ""
                        id: fileDialog
                        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                        onAccepted:
                        {
                            filepath = selectedFile
                            let time = Qt.formatTime(new Date,"hh:mm")
                            client.send_attachment(filepath,usernm,selected_chat,time)
                            let filesize = ""
                            if (client.get_file_size() === "")
                            {
                                console.log("filesize error")
                            }
                            else
                            {
                                filesize = client.get_file_size()
                            }
                            if (filepath !== "")
                            {
                                let file_info = filepath.split("///")[1].split('/')
                                let filename = file_info[file_info.length - 1]
                                lmchat.append(
                                            {
                                                mygod : true,
                                                message : filename,
                                                sendertxt : usernm,
                                                currtime : time,
                                                is_read : false,
                                                newRectCheck_visiblity : true,
                                                is_an_attachment : true
                                            } )
                                if (selected_chat !== "")
                                {
                                    let chat_is_exist = false
                                    for (let i = 0 ; i < chatlist.length; i++)
                                    {
                                        if (chatlist[i] === selected_chat)
                                        {
                                            chat_is_exist = true
                                        }
                                    }
                                    if (allchats.has(selected_chat))
                                    {
                                        let tmp = allchats.get(selected_chat)
                                        tmp += "|^|"
                                        tmp += 'a' + ':' + usernm + ':' + time + ':' + "unread" + ':' + filename + ',' + filesize + ','
                                        tmp += usernm + "To" + selected_chat + filename
                                        allchats.set(selected_chat,tmp)
                                    }
                                    if (chat_is_exist === false)
                                    {
                                        lmchats.append(
                                                    {
                                                        username : selected_chat,
                                                        lastmessage : filename,
                                                        cntr : "0",
                                                        is_visible : false,
                                                        is_enabled : true
                                                    }    )
                                        chatlist.push(selected_chat)
                                        let tmp = ""
                                        tmp += 'a' + ':' + usernm + ':' + time + ':' +"unread" + ':'
                                        tmp += filename + ',' + filesize + ',' + usernm + "To" + selected_chat + filename
                                        allchats.set(selected_chat,tmp)
                                    }
                                    find(lmchats, function(item) {
                                        if (item.username === selected_chat)
                                        {
                                            return true
                                        }
                                        return false
                                    },filename)
                                }
                                files.set(filename,(usernm + "To" + selected_chat + filename))

                            }
                            fileDialog.close();
                        }
                    }
                    MButton
                    {
                        id:sendbtn
                        anchors.right: send_chats.right
                        anchors.leftMargin: 0
                        clr : "transparent"
                        rdis: 10
                        y:scView.y
                        buttonText : ""
                        Image {
                            anchors.centerIn: parent
                            id: sendicon
                            source: "qrc:/icons/send-svgrepo-com(2).svg"
                            width: 50
                            height: 50
                        }
                        size: 60
                        onEntred: {
                            clr = "#322d4f"
                        }
                        onExted: {
                            clr = "transparent"
                        }
                        property string new_chatlist_user: ""
                        property bool exst: false
                        property var new_all_message
                        onButtonClicked:
                        {
                            if (contentText.text !== "")
                            {
                                let time = Qt.formatTime(new Date,"hh:mm")
                                lmchat.append(
                                            {
                                                mygod : true,
                                                message : contentText.text,
                                                sendertxt : usernm,
                                                currtime : time,
                                                is_read : false,
                                                newRectCheck_visiblity : true,
                                                is_an_attachment : false
                                            } )
                                if (selected_chat !== "")
                                {
                                    let chat_is_exist = false
                                    for (let i = 0 ; i < chatlist.length; i++)
                                    {
                                        if (chatlist[i] === selected_chat)
                                        {
                                            chat_is_exist = true
                                        }
                                    }
                                    if (allchats.has(selected_chat))
                                    {
                                        let tmp = allchats.get(selected_chat)
                                        tmp += "|^|"
                                        tmp += 'm' + ':' + usernm + ':' + time + ':' + "unread" + ':' + contentText.text
                                        allchats.set(selected_chat,tmp)
                                    }
                                    if (chat_is_exist === false)
                                    {
                                        lmchats.append(
                                                    {
                                                        username : selected_chat,
                                                        lastmessage : contentText.text,
                                                        cntr : "0",
                                                        is_visible : false,
                                                        is_enabled : true
                                                    }    )
                                        chatlist.push(selected_chat)
                                        let tmp = ""
                                        tmp += 'm' + ':' + usernm + ':' + time + ':' +"unread" + ':' + contentText.text
                                        allchats.set(selected_chat,tmp)
                                    }
                                }
                                client.onSendMessageCLicked(contentText.text,time)
                                find(lmchats, function(item) {
                                    if (item.username === selected_chat)
                                    {
                                        return true
                                    }
                                    return false
                                },contentText.text)
                                contentText.clear()
                            }
                        }
                    }
                }
            }
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
