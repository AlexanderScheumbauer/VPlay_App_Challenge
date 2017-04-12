import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: cell
    entityType: "Cell"

    property bool isAlive: false
    property int row
    property int column

    Image {
        id: cellImage
        anchors.fill: parent
        source: "../../assets/DeadCell.png"
    }

    function setIsAlive(isAliveFlag)
    {
        isAlive = isAliveFlag;

        if (isAlive == true)
            cellImage.source = "../../assets/LivingCell.png"
        else
            cellImage.source = "../../assets/DeadCell.png"
    }
}
