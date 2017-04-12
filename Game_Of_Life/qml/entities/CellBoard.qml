import VPlay 2.0
import QtQuick 2.0

Item {
    id: cellBoard

    // shall be a multiple of the blockSize
    width: cellSize * boardSize
    height: cellSize * boardSize

    // The board will always be square, so just one value needed
    property int boardSize: 10
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
                board[index(i, j)] = createBlock(i, j);
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
            randomDeadCellIndex = generateRandomValueBetween(0, board.length());
        } while(board[randomDeadCellIndex].isAlive === true)

        return randomDeadCellIndex;
    }

    // clear game field
    function clearField() {
        // remove entities
        for(var i = 0; i < field.length; i++)
        {
            var block = field[i]
            if(block !== null)
            {
                cellBoardEntityManager.removeEntityById(block.entityId)
            }
        }
        gameArea.field = []
    }

    // create a new block at specific position
    function createBlock(row, column) {
        // configure block
        var entityProperties = {
            width: blockSize,
            height: blockSize,
            x: column * blockSize,
            y: row * blockSize,
            isAlive: false,
            row: row,
            column: column
        }

        // add cell to cellBoard
        var id = cellBoardEntityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Cell.qml"), entityProperties)
        return cellBoardEntityManager.getEntityById(id)
    }
}
