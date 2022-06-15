import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Page {

    id: root
    title: qsTr("Stop Watch")
    anchors.fill: parent

    TimeDisplay {
        id: timeDisplay
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20

        height: 70; width: 170;

    }

    Keys.onSpacePressed: playPause.clicked();

    Button {
        id: playPause
        text: "Play/Pause"
        font.pointSize: 7
        anchors.left: timeDisplay.left
        anchors.top: timeDisplay.bottom
        anchors.topMargin: 10

        onClicked: {
            timeDisplay.running = !timeDisplay.running
        }
    }

    Button {
        id: stop
        text: "Stop"
        font.pointSize: 7
        anchors.right: timeDisplay.right
        anchors.top: playPause.top
        onClicked: {
            timeDisplay.running = false;
            stopButtonDialog.open();
        }


        MessageDialog {
            id: stopButtonDialog
            title: "Save Entry"
            standardButtons: StandardButton.Ok | StandardButton.Cancel
            text: qsTr("Are you sure you want to stop?")

            onAccepted: {
                let time = timeDisplay.seconds + (timeDisplay.minutes * 60) + (timeDisplay.hours * 60 * 60);
                stop.resetTimer();
                let categoryName = combo.currentText;
                if (categoryName === "") return

                let date = new Date();
                let dateStr = date.toISOString();
                dateStr = dateStr.split('T');
                dateStr = dateStr[0];

                if (!database.insertIntoTimeTable(categoryName, dateStr, time)) {
                    console.log("Insert into  time table failed");
                    return;
                }
                //everytime I insert into timetable I want to update pieModel//barModel
                console.log("Trying to update pie model");
                if (pieModel.updateModel()) { //invoke c++ function like this
                    console.log("Worked");
                } else {
                    console.log("Did not work");
                }
            }

            onRejected: {
                //resume the timer
                root.running = true;
            }
        }

        function resetTimer() {
            timeDisplay.hours = 0;
            timeDisplay.minutes = 0;
            timeDisplay.seconds = 0;
            timeLabel.text = "00:00:00"
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

        SimpleButton {
            id: addButton
            anchors.left: combo.right
            anchors.leftMargin: 10
            anchors.verticalCenter: combo.verticalCenter
            label: qsTr("(+)")
            area.onClicked: {
                addCategoryDialog.open()
            }

            AddDialog {
                id: addCategoryDialog
                onAccepted: {
                    console.log("Saved: ", myInput.text)
                    let str = myInput.text.trim();
                    if (str === "") {
                        console.log("No empty string");
                        return;
                    }

                    database.insertIntoTable(myInput.text);
                    myModel.updateModel();
                    combo.currentIndex = combo.find(myInput.text)
                    myInput.text = "Category"

                }

                onRejected: {
                    console.log("Canceled")
                    myInput.text = "Category"
                }

            }
        }

        SimpleButton {
            id: removeButton
            anchors.left: addButton.right
            anchors.leftMargin: 3
            anchors.verticalCenter: combo.verticalCenter
            label: qsTr("(-)")
            text.font.pixelSize: 13
            area.onClicked: {
                console.log("Removing Category!")
                removeDialog.open()
            }

            RemoveDialog {
                id: removeDialog
                category: combo.currentText

                onAccepted: {
                    let index = combo.currentIndex
                    //console.log("To delete Index: ", index)
                    database.removeRecord(myModel.getId(index))
                    myModel.updateModel();
                    combo.currentIndex = 0
                }

            }
        }

    }
}
