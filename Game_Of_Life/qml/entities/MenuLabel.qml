import QtQuick 2.0

Rectangle {
    id: label

    // this will be the default size, it is same size as the contained text + some padding
    width: labelText.width + paddingHorizontal * 2
    height: labelText.height + paddingVertical * 2

    color: "grey"

    // round edges
    radius: 10

    // the horizontal margin from the Text element to the Rectangle at both the left and the right side.
    property int paddingHorizontal: 10
    // the vertical margin from the Text element to the Rectangle at both the top and the bottom side.
    property int paddingVertical: 5

    // access the text of the Text component
    property alias text: labelText.text

    Text {
        id: labelText
        anchors.centerIn: parent
        font.pixelSize: 18
        color: "black"
    }
}
