import QtQuick 2.0

Rectangle {
    id: root
    color: 'black'

    property int hours: 0
    property int minutes: 0
    property int seconds: 0
    property alias running: timer.running

    Timer {
        id: timer
        interval: 1000; running: false; repeat: true;
        onTriggered: root.updateTime()
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

    function updateTime() {
        seconds++;
        if (seconds == 60) {
            seconds = 0;
            minutes++;
            if (minutes == 60) {
                minutes = 0;
                hours++;
            }
        }
        let timeStr = appendZero(hours) + ":" + appendZero(minutes) + ":" +
            appendZero(seconds);
        timeLabel.text = timeStr;
    }

    function appendZero(val) {
        return val <= 9 ? "0" + val : val;
    }
}
