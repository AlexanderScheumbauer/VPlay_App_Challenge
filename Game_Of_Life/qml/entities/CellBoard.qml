import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityId: CellBoard
    entityType: "CellBoard"

    Component.onCompleted: {
        for (var x = 0; x < 10; x++)
        {
            for (var y = 0; y < 10; y++)
            {
                cellBoardEntityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Cell.qml"), {"isAlive": false, "positionX": x, "positionY": y});
                //cellBoardEntityManager.createEntityFromUrl(Qt.resolvedUrl("Cell.qml"));
            }
        }

        var bac = cellBoardEntityManager.getEntityArrayByType("Cell");
        var test = bac.length;
        var test2 = "xx";
    }
}
