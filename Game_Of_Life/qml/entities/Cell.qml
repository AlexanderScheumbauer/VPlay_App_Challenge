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
        source: "../../assets/Banana.png"
    }

    function setIsAlive(isAliveFlag)
    {
        if (isAlive == true)
            cellImage.source = "../../assets/assets/Apple.png"
        else
            cellImage.source = "../../assets/assets/Banana.png"
    }
}
