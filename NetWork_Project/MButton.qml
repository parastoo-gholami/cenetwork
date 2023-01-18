import QtQuick 2.11

Item {
    id : rootId
    property alias buttonText: buttonTextId.text
    property alias size: containerRectId.width
    property alias opac: containerRectId.opacity
    property alias rdis: containerRectId.radius
    property alias clr: containerRectId.color
    width: containerRectId.width
    height: containerRectId.height
    signal buttonClicked
    signal entred
    signal exted

    Rectangle {

        id : containerRectId
        width: 150
        height: 50
        color: ms.containsMouse ? "white" : "#1e1b2f"
        opacity: 1
        radius: 20
        Text {
            id : buttonTextId
            text : "Button"
            anchors.centerIn: parent
            font.bold: true
            font.pointSize: 10
            font.family: "StayPuft"
            color: ms.containsMouse? "#1e1b2f":"white"
        }
        MouseArea {
            id:ms
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                rootId.entred()
            }
            onExited:
            {
                rootId.exted()
            }

            onClicked: {
                rootId.buttonClicked()
            }
        }
    }

}


