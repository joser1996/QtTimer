import QtQuick 2.0
import QtQuick.Dialogs 1.3

MessageDialog {
    id: rootDialog
    title: "Remove Category"
    icon: StandardIcon.Warning
    standardButtons: StandardButton.Ok | StandardButton.Cancel
    property string category: ""
    text: qsTr("Are you sure you want to delete: " + category)

}
