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
    property int columns: Math.floor(width / cellSize)
    property int rows: Math.floor(height / cellSize)

    // array for handling cell board
    property var board: []
    property var nextBoard: []

    // game over signal
    signal simulationOver()

    // calculate field index
    function index(row, column) {
        return row * columns + column
    }

    // fill board with cells
    function initializeBoard(numberOfLivingCells) {
        // clear field
        clearField();

        // fill field
        for(var y = 0; y < rows; y++)
        {
            for(var x = 0; x < columns ; x++)
            {
                board[index(y, x)] = createCell(y, x);
            }
        }

        // Randomly define which fields should be alive
        for (var i = 0; i < numberOfLivingCells; ++i)
        {
            board[getRandomDeadCellIndex()].setIsAlive(true);
        }

        nextBoard = board
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

    // Gibt eine Zufallszahl zwischen min (inklusive) und max (exklusive) zurück
    // Die Verwendung von Math.round() erzeugt keine gleichmäßige Verteilung!
    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min;
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

    function doSimulationStep() {

        for(var y = 0; y < rows; y++)
        {
            for(var x = 0; x < columns; x++)
            {
                calculateCell(y, x, getCellNeighbours(y, x))
            }
        }

        board = nextBoard

        ++currentSimulationRound;

        if (currentSimulationRound == setupSimulationsRounds)
            simulationRunning = false
    }

    function getCellNeighbours(row, column)
    {
        var neighbourCells = []
        var leftBorder = 0
        var rightBorder = columns -1
        var upperBorder = 0
        var lowerBorder = rows - 1
        var isLeftUpperCorner = (column === leftBorder && row === upperBorder)
        var isRightUpperCorner = (column === rightBorder && row === upperBorder)
        var isLeftLowerCorner = (column === leftBorder && row === lowerBorder)
        var isRightLowerCorner = (column === rightBorder && row === lowerBorder)
        var isLeftBorder = column === leftBorder
        var isRightBorder = column === rightBorder
        var isUpperBorder = row === upperBorder
        var isLowerBorder = row === lowerBorder

        if (isLeftUpperCorner) {
            neighbourCells[0] = nextBoard[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = nextBoard[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = nextBoard[index(row + 1, column + 1)]  // Lower Right Neighbour
        }
        else if (isRightUpperCorner) {
            neighbourCells[0] = nextBoard[index(row, column - 1)]          // Left Neighbour
            neighbourCells[1] = nextBoard[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = nextBoard[index(row + 1, column - 1)]  // Lower Left Neighbour
        }
        else if (isLeftLowerCorner) {
            neighbourCells[0] = nextBoard[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = nextBoard[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[2] = nextBoard[index(row - 1, column + 1)]  // Upper Right Neighbour
        }
        else if (isRightLowerCorner) {
            neighbourCells[0] = nextBoard[index(row, column - 1)]          // Left Neighbour
            neighbourCells[1] = nextBoard[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[2] = nextBoard[index(row - 1, column - 1)]  // Upper Left Neighbour
        }
        else if (isLeftBorder) {
            neighbourCells[0] = nextBoard[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = nextBoard[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = nextBoard[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[3] = nextBoard[index(row + 1, column + 1)]  // Lower Right Neighbour
            neighbourCells[4] = nextBoard[index(row - 1, column + 1)]  // Upper Right Neighbour
        }
        else if (isRightBorder) {
            neighbourCells[0] = nextBoard[index(row, column - 1)]          // Left Neighbour
            neighbourCells[1] = nextBoard[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = nextBoard[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[3] = nextBoard[index(row + 1, column - 1)]  // Lower Left Neighbour
            neighbourCells[4] = nextBoard[index(row - 1, column - 1)]  // Upper Left Neighbour
        }
        else if (isUpperBorder) {
            neighbourCells[0] = nextBoard[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = nextBoard[index(row, column - 1)]          // Left Neighbour
            neighbourCells[2] = nextBoard[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[3] = nextBoard[index(row + 1, column + 1)]  // Lower Right Neighbour
            neighbourCells[4] = nextBoard[index(row + 1, column - 1)]  // Lower Left Neighbour

        }
        else if (isLowerBorder) {
            neighbourCells[0] = nextBoard[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = nextBoard[index(row, column - 1)]          // Left Neighbour
            neighbourCells[2] = nextBoard[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[3] = nextBoard[index(row - 1, column + 1)]  // Upper Right Neighbour
            neighbourCells[4] = nextBoard[index(row - 1, column - 1)]  // Upper Left Neighbour
        }
        else {
            neighbourCells[0] = nextBoard[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = nextBoard[index(row, column - 1)]          // Left Neighbour
            neighbourCells[2] = nextBoard[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[3] = nextBoard[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[4] = nextBoard[index(row + 1, column + 1)]  // Lower Right Neighbour
            neighbourCells[5] = nextBoard[index(row - 1, column + 1)]  // Upper Right Neighbour
            neighbourCells[6] = nextBoard[index(row + 1, column - 1)]  // Lower Left Neighbour
            neighbourCells[7] = nextBoard[index(row - 1, column - 1)]  // Upper Left Neighbour
        }

        return neighbourCells
    }

    function calculateCell(row, column, cellNeighbours)
    {
        var livingNeighbours = 0
        for (var i = 0; i < cellNeighbours.length; ++i)
        {
            if (cellNeighbours[i].isAlive === true)
                ++livingNeighbours
        }

        if (nextBoard[index(row, column)].isAlive === true)
            calculateLivingCell(livingNeighbours, row, column)
        else
            calculateDeadCell(livingNeighbours, row, column)
    }

    function calculateLivingCell(livingNeighbours, row, column)
    {
        if (livingNeighbours <= 1)
            nextBoard[index(row, column)].setIsAlive(false)
        else if (livingNeighbours >= 4)
            nextBoard[index(row, column)].setIsAlive(false)
    }

    function calculateDeadCell(livingNeighbours, row, column)
    {
        if (livingNeighbours === 3)
            nextBoard[index(row, column)].setIsAlive(true)
    }
}
