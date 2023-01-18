import QtQuick
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
Window {
    //properties
    property color colorNormal: '#668c144d'
    property color colorNormaltxt: 'white'
    property color colorHovered: 'white'
    property color colorHoveredtxt: 'black'
    //properties
    id: signup_window
    title: qsTr("Sign Up")
    visibility: Window.FullScreen
    visible : true
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
    Signup_gb {

    }
}
