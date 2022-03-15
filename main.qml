import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

ApplicationWindow {
    id: root
    property int clockW: 400
    property int clockH: 150
    width: clockW; height: clockH

    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    visible: true
    title: qsTr("Timer")
    Item {
        id: content
        anchors.fill: parent
        ClockView {}
    }






}
