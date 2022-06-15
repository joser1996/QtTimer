import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtCharts 2.13

Page {
    id: root
    anchors.fill: parent
    title: qsTr("Data View")


    //used to select time frame
    FrameSelector {
        id: frameSelector
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        currentFrame: getCurrentDate()
        currentDate: getCurrentISO()
        property int dayOffset: 0

        leftButton.onClicked: {
            console.log('Left Button Pressed')
            //first update label
            frameSelector.dayOffset--;
            var newDate = new Date();
            newDate.setDate(newDate.getDate() + frameSelector.dayOffset);
            frameSelector.currentFrame = frameSelector.dateToString(newDate);

            //update graph (PIE MODEL)
            let dateStr = newDate.toISOString().split('T');
            dateStr = dateStr[0];
            console.log("Updating model to: ", dateStr);
            if (pieModel.setDay(dateStr)) console.log("Worked");
            else console.log("Failed");
            chartView.update();

            //pieModel.updateModel();
        }

        rightButton.onClicked: {
            console.log('Right Button Pressed')
            frameSelector.dayOffset++;
            var newDate = new Date();
            newDate.setDate(newDate.getDate() + frameSelector.dayOffset);
            frameSelector.currentFrame = frameSelector.dateToString(newDate);

            //update PIE MODEL
            let dateStr = newDate.toISOString().split('T');
            dateStr = dateStr[0];            console.log("Updating model to: ", dateStr);
            if (pieModel.setDay(dateStr)) console.log("Worked");
            else console.log("Failed");
            chartView.update();

        }

        function dateToString(d) {
            let str = d.toLocaleDateString('en-US', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            });
            return str;
        }

        function getCurrentISO() {
            let date = new Date();
            return date.toISOString();
        }

        function getCurrentDate() {
            let date = new Date().toLocaleDateString('en-US', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
            });
            return date;
        }
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
