import QtQuick
import QtQuick.Controls 2.0
Button {
    id: btnid
    background: Rectangle {
            color: internal.hoverColor
            border.width: 1
            border.color: "#1e1b2f"
            radius: 10
        }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            console.log("Clicked")
        }

    }
    flat: true
    highlighted: true
    x : 124
    y : 320
    width : 160
    height: 40
    text: "Login"
    font.pixelSize: 20
    QtObject
    {
        id: internal
        property var hoverColor: if(!btnid.down)
                                 {
                                     btnid.hovered ? rootid.colorHovered : rootid.colorNormal
                                 }

    }
}
