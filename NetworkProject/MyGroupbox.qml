import QtQuick

Rectangle {
    width : 400
    height : 400
    id : groupbox
    color: gb//
    anchors.centerIn: parent
    radius: 30
    border.color : "black"
    border.width : 2
    ModeButton {

    }
    Text {
        x : 120
        y : 30
        text : "Welcome"
        font.bold: true
        font.pixelSize: 40
        color : wlcm
    }
    MyRow {
        id : row1
        x : 50
        y : 100
        Txt_in_groupbox {
            id: txt1
            text: qsTr("UserName :")
        }
        TxtField_in_groupbox {
            id: tf1
            placeholderText: qsTr("UserName")
        }
    }
    MyRow {
        id : row2
        x : 50
        y : 200
        Txt_in_groupbox {
            id: txt2
            text: qsTr("PassWord  :")
        }
        TxtField_in_groupbox {
            id: tf2
            placeholderText: qsTr("Password")
        }
    }
    Signup_link{

    }
    Submit_btn {
    }
}
