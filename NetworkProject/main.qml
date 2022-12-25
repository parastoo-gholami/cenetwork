import QtQuick

Window {
    id : rootid
    width: 1024
    height: 768
    visible: true
    title: qsTr("Sign In")
    //properties
    property color backcolor1: '#5CDB95'
    property color backcolor2: '#041c2f'
    property color c_color1: '#0e3147'
    property color c_color2: '#38e0cc'
    property color gb: '#cc05386b'
    property color wlcm: '#9ddfec'
    property color r:  '#379683'
    property color litem: '#9ddfec'
    property color colorNormal: '#5CDB95'
    property color colorHovered: '#04b9b9'
    property color msnger: 'black'
    property string icons: "qrc:/icons/night.png"
    property int cnt: 0
    //properties
    //background
    Rectangle {
        id: background_color
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                //color: "#5CDB95";
                color : backcolor1
            }
            GradientStop {
                position: 0.70;
                //color: "#0f6254";
                color : backcolor2
            }
        }
    }
    //background
    //Head text
    HeadText {
        id : htxt
        color: msnger
    }
    //head text
    //Circle 1
    Circles {
        id : c1
        x : 215
        y : 80
        gradient: Gradient {
            GradientStop {
                position: 0.20;
                color: c_color1;
            }
            GradientStop {
                position: 0.80;
                color: c_color2;
            }
        }
    }
    Circles {
        id : c2
        x : 215 + 395
        y : 80 + 395
        gradient: Gradient {
            GradientStop {
                position: 0.20;
                color: c_color2;
            }
            GradientStop {
                position: 0.80;
                color: c_color1;
            }
        }
    }
    //Circle 2
    //groupbox
    MyGroupbox {
        //other components ==> inside MyGroupBox qml file
    }
    //groupbox
}
