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


        property int hours: 0
        property int minutes: 0
        property int seconds: 0

        Timer {
            interval: 1000; running: true; repeat: true;
            onTriggered: timeDisplay.updateTime()
        }

        function updateTime() {
            seconds++;
            if (seconds == 60) {
                seconds = 0
                minutes++;
                if (minutes == 60) {
                    minutes = 0
                    hours++
                }
            }

            let mins = minutes <= 9 ? "0"+minutes : minutes
            let hrs = hours <= 9 ? "0"+hours : hours
            let secs = seconds <= 9 ? "0"+seconds : seconds
            let timeStr =  hrs + ":" + mins + ":" + secs
            timeLabel.text = timeStr
        }

        function getTimeStr() {
            var today = new Date();
            var time = today.getHours() + ":" + today.getMinutes();
            console.log("Current Time: ", time);
            return time;
        }

        Text {
            id: timeLabel
            text: ""
            anchors.centerIn: parent
            color: 'green'
            font.pixelSize: 10
        }

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
