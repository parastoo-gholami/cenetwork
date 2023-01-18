import QtQuick
import QtQuick.Window 2.11
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Dialogs
import QtCore
Window {
    id : windo
    visible: true

    //function
    title: qsTr("Messanger")
    visibility: Window.FullScreen//"FullScreen"
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
                            //do sth
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
                ListView//search
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
                            width : atch ? totalwidth + downloadicon.width : totalwidth
                            height : newRectTxt.height +  newRectSender.height + newRectTime.height + 20
                            border.color : "black"
                            border.width : 1;
                            radius : 20
                            Rectangle {
                                id : downloadicon
                                visible: is_an_attachment
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
