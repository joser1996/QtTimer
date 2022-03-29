import QtQuick 2.0
import QtQuick.Dialogs 1.3

Dialog {
    id: rootDialog
    title: "Add Category"
    standardButtons: StandardButton.Save | StandardButton.Cancel
    property alias myInput: myInput
    Item {
        id: content
        implicitWidth: 400; implicitHeight: 100
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            spacing: 10
            Text {
                text: "Enter new category name."
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MyInput {
                id: myInput
                width: 300
                height: 50
            }
        }
    }

}
