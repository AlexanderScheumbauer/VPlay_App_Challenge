import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: cell
    entityType: "Cell"

    property bool isAlive: false
    property int row
    property int column

    Rectangle {
        id: cellImage
        anchors.fill: parent
        color: "red"
        border.color: "black"
        border.width: 1
    }

    function setIsAlive(isAliveFlag)
    {
        isAlive = isAliveFlag;

        if (isAlive == true)
            cellImage.color = "green"
        else
            cellImage.color = "red"
    }
}
