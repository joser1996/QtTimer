import QtQuick 2.0
import QtQuick.Controls 2.0
Page {
    id: root
    anchors.fill: parent
    title: qsTr("Data View")

    signal windowClosed

    Text {
        anchors.centerIn: parent
        text: qsTr("Display data here")
    }



}
