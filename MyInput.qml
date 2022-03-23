import QtQuick 2.0

FocusScope {
    id: root
    property alias text: textInput.text
    Rectangle {
        color: 'white'
        height: textInput.cursorRectangle.height
        width: root.width
        //visible: root.focus
        y: textInput.cursorRectangle.y
    }

    TextInput {
        id: textInput
        font.pixelSize: 20
        focus: true
        text: "Category"
        selectByMouse: true
        width: root.width
    }
}
