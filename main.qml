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

//    maximumHeight: height
//    maximumWidth: width
    minimumHeight: clockH
    minimumWidth: clockW


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
                    drawer.close()
                    root.width = 600;
                    root.height = 500;
                }
            }
        }
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop();
                    root.width = root.clockW;
                    root.height = root.clockH;
                } else {
                    drawer.open();
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    StackView {
        id: stackView
        width: root.width; height: root.height
        initialItem: ClockView {}
    }
}
