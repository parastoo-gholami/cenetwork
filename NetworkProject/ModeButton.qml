import QtQuick
import QtQuick.Controls 2.0
Button {
    id: dayNight
    x : 40
    y : 20
    highlighted: true
    icon.source: icons
    icon.width: 40
    icon.height: 40
    width : 60
    height : 60
    background: Rectangle {
            anchors.fill: parent
            color: internal1.hoverColor
            border.width: 1
            border.color: "black"
            radius: 100
        }
    QtObject
    {
        id: internal1
        property var hoverColor: if(!dayNight.down)
                                 {
                                     dayNight.hovered ? rootid.colorHovered : rootid.colorNormal
                                 }

    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (cnt === 0)
            {
                cnt = 1
                backcolor1 = "#F67E64"
                backcolor2 = "#1e1b2f"
                c_color1 = "#321A30"
                c_color2 = "#F67E64"
                gb = "#b3424242"
                wlcm = "white"
                r = "#668c144d"
                litem = "white"
                colorNormal = '#668c144d'
                colorHovered = 'white'
                msnger = 'white'
                icons = "qrc:/icons/sun.png"
            }
            else if (cnt === 1)
            {
                cnt = 0
                backcolor1 = "#5CDB95"
                backcolor2 = "#041c2f"
                c_color1 = "#0e3147"
                c_color2 = "#38e0cc"
                gb = "#cc05386b"
                wlcm = "#9ddfec"
                r = "#379683"
                litem = "#9ddfec"
                colorNormal = '#5CDB95'
                colorHovered = '#04b9b9'
                msnger = 'black'
                icons = "qrc:/icons/night.png"
            }

            console.log("Clicked")

        }

    }
}
