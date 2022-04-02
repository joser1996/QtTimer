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
            title: "Time Spent"
            legend.alignment: Qt.AlignBottom

            PieSeries {
                id: pieSeries

                VPieModelMapper {
                    model: pieModel
                    labelsColumn: 0
                    valuesColumn: 1
                }
                Component.onCompleted: {
                    let count = pieSeries.count;
                    console.log("Slice Count: ", count);
//                    for(let i = 0; i < count; i++) {
//                        console.log("Slice: ", i);
//                        let slice = pieSeries.at(i);
//                        slice.labelVisible = true;
//                        slice.labelPosition = PieSlice.LabelInsideHorizontal;
//                        var val = slice.percentage * 100;
//                        val = val.toFixed(2);
//                        slice.label = val.toString();
//                    }
                }
            }

        }

        ListView {
            id: categoryList
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

    Component.onCompleted: {
        console.log("Default is to show data for current week.")
        timeModel.updateModelWeek();
    }

}
