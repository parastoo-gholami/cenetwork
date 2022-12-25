import QtQuick
Text {
    id : tl
    text : "Dont have an account ?!"
    color : litem//"#9ddfec"
    x : 125
    y : 282
    MouseArea {
                id: mouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    console.log("CLicked!")
                }
    }
}
