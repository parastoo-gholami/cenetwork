import QtQuick
import QtQuick.Controls 2.0
Rectangle {
    id: mask
    anchors.centerIn: parent
    width : rootid.width/2 + 300
    height : rootid.height - 300
    property string user: usernametxtfield.content
    property string pass: passwordtxtfield.content
    property string em: emailtxtfield.content
    Connections {
        target: client
        function onSignup_message(ba)
        {
            message = ba + ""
            if (message === "Sack")
            {
                console.log("ok");
                usernametxtfield.name = ""
                passwordtxtfield.name = ""
                emailtxtfield.name = ""
                signup_window.close();
                rootid.show()
            }
            else
            {
                console.log("failed!!!!");
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
        SignupTxt {

        }
        MyTextField {
            id : usernametxtfield
            name : "UserName"
            ech : 0
            x : 50; y : 250; z : 1
        }
        MyTextField {
            id : emailtxtfield
            name : "Email Address"
            ech : 0
            x : 50; y : 350; z : 1
        }
        MyTextField {
            id : passwordtxtfield
            name : "Create a PassWord"
            ech : 2
            x : 50; y : 450; z : 1
        }
        MyButton {
            id : signup_btn
            width : 150
            height: 40
            x : 60; y : 547; z : 1
            c : internal1.hoverColor
            t : "Sign In"
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
            onButtonClicked: {
//                let component = Qt.createComponent("main.qml");
//                let win = component.createObject(Window);
//                win.show()
                rootid.show()
                signup_window.close()
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
                if (usernametxtfield.content === "" || passwordtxtfield.content === "" || emailtxtfield.content === "")
                {
                    console.log("fill the fields");
                }
                else
                {
                    if (pass.length < 8)
                    {
                        console.log("Password must be 8 character");
                    }
                    else
                    {
                        if (em.includes("@gmail.com"))
                        {
                            client.onSignupSubmitClicked(user,pass,em);
                            usernametxtfield.content = ""
                            passwordtxtfield.content = ""
                            emailtxtfield.content = ""
                            console.log(user + " , " + pass + " , " + em )
                        }
                        else
                        {
                            console.log("not valid form for email")
                        }
                    }
                }
            }
        }
    }
}
