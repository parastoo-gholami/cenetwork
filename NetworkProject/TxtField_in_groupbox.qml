import QtQuick
import QtQuick.Controls 2.0
TextField {
    Rectangle {
        anchors.fill: parent
        color : "#EDF5E1"
        z : -1
    }
    placeholderText: qsTr("UserName")
    x : txt1.width + 30
    y : 22.45
    width : 150
    height : txt1.height
    color : "#05386B"
    font.pixelSize: 15
}
