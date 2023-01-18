import QtQuick
import QtQuick.Controls 2.0
Rectangle {
    property string user: usernametxtfield.content
    property string pass: passwordtxtfield.content
    property string message: ""
//    property string statustxt : ""
    id: mask
    anchors.centerIn: parent
    width : rootid.width/2 + 300
    height : rootid.height - 300
    Connections {
        target: client
        function onNewMessage(ba)
        {
            message = ba + ""
            if (message === "Lack")
            {
                console.log("ok");
                var component1 = Qt.createComponent("Messanger.qml");
                var win1 = component1.createObject(Window);
                win1.show();
                rootid.close()
            }
            else
            {
                console.log("failed!");
            }
        }
    }
    Image {
        id: image_groupbox
        anchors.fill: mask
        source: "qrc:/images/colorful-abstract-nebula-space-background.jpg"
        z : 1
        MyButton {
            id: btnid
            c : internal.hoverColor
            x : image_groupbox.width - 75; y : 10; z : 1;
            width : 60
            height: 60
            Image {
                source:"qrc:/icons/power.png"
                anchors.fill: parent
                width: 50
                height: 50
            }
            onButtonClicked: {
                Qt.quit()
            }
            flat: true
            highlighted: true
            QtObject
            {
                id: internal
                property var hoverColor: if(!btnid.down)
                                         {
                                             btnid.hovered ? rootid.colorHovered : rootid.colorNormal
                                         }

            }
        }
        Header {
        }
        LoginTxt {
        }
        MyTextField {
            id : usernametxtfield
            name : "UserName"
            ech : 0
            x : 50; y : 350; z : 1
        }
        MyTextField {
            id : passwordtxtfield
            name : "PassWord"
            ech : 2
            x : 50; y : 450; z : 1
        }
        MyButton {
            id : signup_btn
            width : 150
            height: 40
            x : 60; y : 547; z : 1
            c : internal1.hoverColor
            t : "Sign Up"
            ct : internal1.hoverColortxt
            QtObject
            {
                id: internal1
                property var hoverColor: if(!signup_btn.down)
                                         {
                                             signup_btn.hovered ? rootid.colorHovered : rootid.colorNormal
                                         }
                property var hoverColortxt: if(!signup_btn.down)
                                         {
                                             signup_btn.hovered ? rootid.colorHoveredtxt : rootid.colorNormaltxt
                                         }

            }
//            Signup{
//                id : anotherpage
//                visible: false
//            }
            onButtonClicked: {
                var component = Qt.createComponent("Signup.qml");
                var win = component.createObject(Window);
//              win.closing.connect(function() { console.log('do something') })
                win.show();
                rootid.close()
            }
        }
        MyButton {
            id: submit_btn
            width : 150
            height: 40
            x : 225; y : 547; z : 1
            c : internal2.hoverColor
            t : "Submit"
            ct : internal2.hoverColortxt
            QtObject
            {
                id: internal2
                property var hoverColor: if(!submit_btn.down)
                                         {
                                             submit_btn.hovered ? rootid.colorHovered : rootid.colorNormal
                                         }
                property var hoverColortxt: if(!submit_btn.down)
                                         {
                                             submit_btn.hovered ? rootid.colorHoveredtxt : rootid.colorNormaltxt
                                         }

            }
            onButtonClicked: {
                if (user === "" || pass === "")
                {
                    console.log("fill the fields")
                }
                else
                {
                    client.onSigninSubmitClicked(user,pass);
                    console.log(user + ',' + pass);
                }
            }
        }
    }
}
