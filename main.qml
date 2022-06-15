import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Time Logger")

    property int clockW: 425
    property int clockH: 175
    property bool optionsVisible: false


    width: clockW; height: clockH
    minimumHeight: clockH; minimumWidth: clockW


    Drawer {
        id: drawer
        width: root.width * 0.33
        height: root.height;

        Column {
            anchors.fill: parent
            ItemDelegate {
                text: "Data Graphs"
                width: parent.width
                onClicked: {
                    stackView.push("DataView.qml");
                    root.optionsVisible = true;
                    drawer.close()
                    root.width = 650;
                    root.height = 550;
                }
            }

            ItemDelegate {
                text: "Manual Entry"
                width: parent.width
                onClicked: {
                    console.log("Manual entry")
                    stackView.push("ManualEntryForm.qml");
                    drawer.close();
                    root.width = 500;
                    root.height = 600;
                }
            }


        }
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: toolButton
                text: stackView.depth > 1 ? "\u25C0" : "\u2630"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop();
                        root.optionsVisible = false;
                        root.width = root.clockW;
                        root.height = root.clockH;
                    } else {
                        drawer.open();
                    }
                }
            }

            Label {
                id: titleLabel
                text: stackView.currentItem.title
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true // as wide as possible
            }

            ToolButton {
                id: categoriesDrawer
                text: qsTr(":")
                onClicked: console.log("Cats pushed!")
                visible: root.optionsVisible
            }
        }
    }

    StackView {
        id: stackView
        width: root.width; height: root.height
        initialItem: ClockView {}
    }
}
