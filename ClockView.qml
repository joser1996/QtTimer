import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    anchors.fill: parent
    color: 'lightgray'
    id: root
    property alias running: timer.running
    //focus: true
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
            id: timer
            interval: 1000; running: false; repeat: true;
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

        Text {
            id: timeLabel
            text: "00:00:00"
            font.pointSize: 100
            minimumPointSize: 10
            fontSizeMode: Text.Fit
            color: 'green'
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
        }

    }

    Keys.onSpacePressed: {
        playPause.clicked()
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
            root.running = !root.running
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
            model: myModel
            textRole: "category"
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
                    addCategoryDialog.open()
                }
            }

            Dialog {
                id: addCategoryDialog
                title: "Add Category"
                standardButtons: StandardButton.Save | StandardButton.Cancel
                onAccepted: {
                    console.log("Saved: ", myInput.text)

                    database.insertIntoTable(myInput.text);
                    myModel.updateModel();
                    myInput.text = "Category"
                }

                onRejected: {
                    console.log("Canceled")
                    myInput.text = "Category"
                }

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
        }

    }
}
