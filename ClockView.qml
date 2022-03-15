import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    anchors.fill: parent
    color: 'lightgray'
    id: root
    property var categoryModel: ["Study", "Other"]

    Rectangle {
        id: timeDisplay
        color: 'black'
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        height:70; width: 170
    }

    Button {
        id:playPause
        text: "Play/Pause"
        font.pointSize: 7
        anchors.left: timeDisplay.left
        anchors.top: timeDisplay.bottom
        anchors.topMargin: 10

        onClicked: {
            console.log("Play/Pause pressed!")
        }
    }

    Button {
        id: stop
        text: "Stop"
        font.pointSize: 7
        anchors.right: timeDisplay.right
        anchors.top: playPause.top
        onClicked: {
            console.log("Stop pressed!")
        }
    }

    Item {
        id: categoryStuff
        anchors.left: timeDisplay.right
        anchors.leftMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.top: timeDisplay.top
        Text {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Category")
            font.pointSize: 11
        }
        ComboBox {
            id: combo
            anchors.top: label.bottom
            anchors.topMargin: 10
            width: parent.width*.80
            model: root.categoryModel
        }

        Rectangle {
            id: addButton
            width: 18; height: 18
            color: 'transparent'
            anchors.left: combo.right
            anchors.leftMargin: 10
            anchors.verticalCenter: combo.verticalCenter
            Text {
                text: qsTr("(+)")
                anchors.centerIn: parent
                color: 'red'
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Adding Category!")
                }
            }
        }

    }
}
