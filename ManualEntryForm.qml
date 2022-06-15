import QtQuick 2.9
import QtQuick.Dialogs 1.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3


//TODO: Input validation
//Create TimeEntry model and write to DB
//pop from stack view

Item {
    id: content
    width: 500; height: 600;

    GridLayout {
        id: gridLayout
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        anchors.topMargin: 12

        columnSpacing: 8;
        rowSpacing: 15;

        rows: 8; columns: 6;

        Label {
            id: categoryLabel
            text: qsTr("Category");
            Layout.columnSpan: 6
        }

        ComboBox {
            id: category
            Layout.columnSpan: 6
            Layout.fillWidth: true
            model: myModel
            textRole: "category"
        }


        Label {
            id: hourLabel
            text: qsTr("Hours")
            Layout.columnSpan: 2
        }

        Label {
            id: minLabel
            text: qsTr("Minutes")
            Layout.columnSpan: 2
        }

        Label {
            id: secLabel
            text: qsTr("Seconds")
            Layout.columnSpan: 2
        }

        TextField {
            id: hour
            Layout.minimumWidth: 140
            Layout.fillWidth: true;
            Layout.columnSpan: 2;
            placeholderText: qsTr("00");
            selectByMouse: true;
        }

        TextField {
            id: min
            Layout.minimumWidth: 140
            Layout.fillWidth: true;
            Layout.columnSpan: 2;
            placeholderText: qsTr("00");
            selectByMouse: true;
        }

        TextField {
            id: sec
            Layout.minimumWidth: 140
            Layout.fillWidth: true;
            Layout.columnSpan: 2;
            placeholderText: qsTr("00");
            selectByMouse: true;
        }

        Calendar {
            Layout.rowSpan: 4
            Layout.columnSpan: 3
        }
    }

    RowLayout {
        anchors.top: gridLayout.bottom
        anchors.topMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 10

        Button {
            id: save
            text: qsTr("Save")

            onClicked: saveData();
        }
    }

    function saveData() {
        console.log("Save Data");
    }
}
