import QtQuick
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("server app")
    ColumnLayout {
      anchors.fill: parent
      ListView
      {
          Layout.fillHeight: true
          Layout.fillWidth: true
          clip: true
          model: ListModel
          {
              id:listmodelMessages
              ListElement
              {
                  message: "Welcome to server"
              }
          }
          delegate: ItemDelegate
          {
              text : message
          }
          ScrollBar.vertical: ScrollBar{}
      }
   }
}
