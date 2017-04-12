import VPlay 2.0
import QtQuick 2.0

Item {
    id: cellBoard

    // shall be a multiple of the blockSize
    width: cellSize * boardSize
    height: cellSize * boardSize

    // The board will always be square, so just one value needed
    property int boardSize: 15
    property double cellSize
    property int rows: Math.floor(height / cellSize)
    property int columns: Math.floor(width / cellSize)

    // array for handling cell board
    property var board: []

    // game over signal
    signal simulationOver()

    // calculate field index
    function index(row, column) {
        return row * columns + column
    }

    // fill game field with blocks
    function initializeField(numberOfLivingCells) {
        // clear field
        clearField();

        // fill field
        for(var i = 0; i < rows; i++)
        {
            for(var j = 0; j < columns; j++)
            {
                board[index(i, j)] = createCell(i, j);
            }
        }

        // Randomly define which fields should be alive
        for (i = 0; i < numberOfLivingCells; ++i)
        {
            board[getRandomDeadCellIndex()].setIsAlive(true);
        }
    }

    function getRandomDeadCellIndex()
    {
        var randomDeadCellIndex;
        do
        {
            randomDeadCellIndex = getRandomInt(0, board.length);
        } while(board[randomDeadCellIndex].isAlilve === true)

        return randomDeadCellIndex;
    }

    // Gibt eine Zufallszahl zwischen min (inklusive) und max (inklusive) zurück
    // Die Verwendung von Math.round() erzeugt keine gleichmäßige Verteilung!
    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min +1)) + min;
    }

    // clear game field
    function clearField() {
        // remove entities
        for(var i = 0; i < board.length; i++)
        {
            var block = board[i]
            if(block !== null)
            {
                cellBoardEntityManager.removeEntityById(block.entityId)
            }
        }
        board = []
    }

    // create a new cell at specific position
    function createCell(row, column) {
        // configure block
        var entityProperties = {
            width: cellSize,
            height: cellSize,
            x: column * cellSize,
            y: row * cellSize,
            isAlive: false,
            row: row,
            column: column
        }

        // add cell to cellBoard
        var id = cellBoardEntityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Cell.qml"), entityProperties)
        return cellBoardEntityManager.getEntityById(id)
    }
}
