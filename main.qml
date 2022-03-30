import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
ApplicationWindow {
    id: root

    visible: true
    title: qsTr("Timer")

    property int clockW: 425
    property int clockH: 175

    width: clockW; height: clockH

    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 1
            ToolButton {
                text: qsTr("&Timer")
                onClicked: content.state = "clock";
            }

            ToolButton {
                text: qsTr("&DataView")
                onClicked: content.state = "data"
            }
        }
    }


    Item {
        id: content
        anchors.fill: parent

        states: [
            State {
                name: "clock"
                PropertyChanges { target: contentLoader; source: "ClockView.qml" }
                PropertyChanges { target: root; maximumHeight: clockH; maximumWidth: clockW }
                PropertyChanges { target: root; minimumHeight: clockH; minimumWidth: clockW }
                PropertyChanges { target: root; width: clockW; height: clockH }
            },
            State {
                name: "data"
                PropertyChanges { target: contentLoader; source: "DataView.qml" }
            }

        ]

        Loader {
            anchors.fill: parent
            id: contentLoader
            source: "ClockView.qml"
        }

    }





}
