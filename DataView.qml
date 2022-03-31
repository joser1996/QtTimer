import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtCharts 2.13

Page {
    id: root
    anchors.fill: parent
    title: qsTr("Data View")

    FrameSelector {
        id: frameSelector
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
    }

    RowLayout {
        id: chartContainer
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: frameSelector.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        ChartView {
            id: chartView
            antialiasing: true
            width: 500; height: 400
            PieSeries {
                id:pie
                PieSlice { label: "eaten"; value: 94 }
                PieSlice { label: "not eaten"; value: 6 }
            }

        }

        ListView {
            anchors.left: chartView.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: chartView.top
            anchors.topMargin: 10
            anchors.bottom: chartView.bottom
            clip: true
            model: myModel
            delegate: CheckBox {
                text: qsTr(category)
                font.pointSize: 10
            }

        }
    }


}
