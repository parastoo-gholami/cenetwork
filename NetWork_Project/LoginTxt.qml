import QtQuick
Item {
    Text {
        x : 50; y : 200; z : 1
        id : login
        text : "Log In"
        font.family: "Ubuntu Light"
        font.bold: true
        font.pixelSize: 100
        color : "white"
        Rectangle {
            width: login.width
            height: 1
            color : "#954747"
            anchors.top: parent.bottom
        }
    }
    Text {
        x : 350; y : 200; z : 1
        id : dot
        text : "."
        font.family: "Ubuntu Light"
        font.bold: true
        font.pixelSize: 100
        color : "#e20c0c"
    }
}
