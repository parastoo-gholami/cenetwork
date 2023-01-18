import QtQuick

Item {
//    width : su.width + dot.width + 50
    Text {
        x : 50; y : 120; z : 1
        text : "Start For Free"
        font.family: "Ubuntu"
        font.bold: true
        font.pixelSize: 30
        color : "white"
    }

    Text {
        x : 50; y : 170; z : 1
        id : su
        text : "Create  New Account"
        font.family: "Ubuntu Light"
        font.bold: true
        font.pixelSize: 40
        color : "white"
        Rectangle {
            width: su.width
            height: 1
            color : "#954747"
            anchors.top: parent.bottom
        }
    }
    Text {
        x : 450; y : 170; z : 1
        id : dot
        text : "."
        font.family: "Ubuntu Light"
        font.bold: true
        font.pixelSize: 40
        color : "#e20c0c"
    }
}
