import QtQuick

Window {
    //properties
    property color colorNormal: '#668c144d'
    property color colorNormaltxt: 'white'
    property color colorHovered: 'white'
    property color colorHoveredtxt: 'black'
    //properties
    id : rootid
    visible: true
    visibility: Window.FullScreen
    title: qsTr("Log In")
    //background-color
    Rectangle {
        anchors.fill : parent
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color : "#25081c"
            }
            GradientStop {
                position: 0.70;
                color : "black"
            }
        }
    }
    //background-color
    Groupbox {
        //other components are inside this file
    }
}
