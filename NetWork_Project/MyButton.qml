import QtQuick
import QtQuick.Controls 2.0
Button {
    signal buttonClicked
    property alias c: bckgrnd.color
    property alias ct: txt.color
    property alias t: txt.text
    background: Rectangle {
            id :bckgrnd
            border.width: 1
            border.color: "#1e1b2f"
            radius: 10
        }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            buttonClicked()
        }
    }
    Text {
        id :txt
        anchors.centerIn: parent
        font.pixelSize: 15
    }
}
