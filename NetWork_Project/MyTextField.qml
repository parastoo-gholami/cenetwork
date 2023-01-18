import QtQuick
import QtQuick.Controls 2.0
Rectangle
{
    property alias name: txt.text
    property alias ech : tf.echoMode
    property alias content: tf.text
    width : 350
    height : 70
    color : "#99ffffff"
    radius: 30
    Text {
        id :txt
        x : 13; y : 10
        color : "black"
        font.pixelSize: 15
        font.bold: true
        Rectangle {
            width: txt.width
            height: 1
            color : "#954747"
            anchors.top: parent.bottom
        }
    }
    TextField {
        background:Rectangle {
            color : "transparent"
            anchors.fill: parent
        }
        id: tf
        width : 330
        height : 40
        x : 15; y : 20;
        font.pixelSize: 20
    }
}
