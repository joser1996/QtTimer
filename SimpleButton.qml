import QtQuick 2.0

Rectangle {
    id: root;
    width: 18; height: 18
    color: 'transparent'
    property alias label: myText.text
    property alias text: myText
    property alias area: mouseArea

    Text {
        id: myText
        anchors.centerIn: parent
        color: 'red'
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

}
