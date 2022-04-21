import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    property string currentFrame: "PlaceHolder"
    property string currentDate: ""

    property alias leftButton: leftButton
    property alias rightButton: rightButton

    width: 170; height: 30
    Row {
        //left Button
        anchors.centerIn: parent
        width: childrenRect.width
        spacing: 5
        RoundButton {
            id: leftButton
            text: qsTr("\u25C0")
            font.pointSize: 20
            width: 25; height: width
        }

        //label
        Label {
            text: currentFrame
            font.pointSize: 11
            background: Rectangle {
                radius: 5
                color: 'white'
            }
            horizontalAlignment: Text.AlignHCenter
            width: 110
        }

        //right button
        RoundButton {
            id: rightButton
            text: qsTr("\u25B6")
            font.pointSize: 20
            width: 25; height: width
        }
    }
}
