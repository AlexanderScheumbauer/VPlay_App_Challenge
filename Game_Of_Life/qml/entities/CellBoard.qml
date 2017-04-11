import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityId: cellBoard
    entityType: "CellBoard"

    // The board will always be square, so just one value needed
    property int boardSize: 10

    // The "constructor" - executed after object got created.
    Component.onCompleted: {
        // Creating "boardSize * boardSize" number of cells with default values
        for (var x = 0; x < boardSize; x++)
        {
            for (var y = 0; y < boardSize; y++)
            {
                cellBoardEntityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Cell.qml"), {"isAlive": false, "positionX": x, "positionY": y});
            }
        }
    }
}
