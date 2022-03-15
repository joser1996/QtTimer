import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    anchors.fill: parent
    color: 'lightgray'
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
        anchors.left: timeDisplay.right
        anchors.leftMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.top: timeDisplay.top
    }
}
