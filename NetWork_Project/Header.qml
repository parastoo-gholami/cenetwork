import QtQuick

Rectangle {
    x : 50 ; y : 40 ;z : 1
    width: 250
    height: 60
    radius: 30
    color : "#99ffffff"
    Image {
        id: mssngericon
        width : 40
        height : 40
        source: "qrc:/icons/messenger-64.png"
        x : 10; y : 10 ;z : 1
    }
    Text {
        x : 100; y : 15; z : 1
        id :headmsnger
        text: "Messanger"
        font.family: "Purisa"
        font.bold: true
        font.pixelSize:20
    }
}
