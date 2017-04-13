import VPlay 2.0
import QtQuick 2.0

Item {
    id: cellBoard

    // The board will always be square, so just one value needed (defines one dimension)
    property int boardSize: 15
    property double cellSize
    property int columns: Math.floor(width / cellSize)
    property int rows: Math.floor(height / cellSize)

    // Arrays for handling the cells on the board
    property var board: []      // The board which is displayed
    property var nextBoard: []  // The where changes happen before they are applied to the display

    // Helper variables to define speaking names for the border values of the board
    property int leftBorder: 0
    property int rightBorder: columns - 1
    property int upperBorder: 0
    property int lowerBorder: rows - 1

    signal simulationOver

    // Shall be a multiple of the cellSize
    width: cellSize * boardSize
    height: cellSize * boardSize

    // Calculate cell index
    function index(row, column) {
        return row * columns + column
    }

    // Fill board with cells
    function initializeBoard(numberOfLivingCells) {
        clearBoard();

        // Fill board
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
        // Handover the newly created board so both ones are identical for the start
        nextBoard = board
    }

    // Returns a random dead cell index
    function getRandomDeadCellIndex()
    {
        var randomDeadCellIndex;
        // Iterate until a random dead cell got found
        do
        {
            randomDeadCellIndex = getRandomInt(0, board.length);
        } while(board[randomDeadCellIndex].isAlilve === true)

        return randomDeadCellIndex;
    }

    // Returns random number between "min" (inclusive) and max (exclusive)
    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min;
    }

    // Clear the board
    function clearBoard() {
        for(var i = 0; i < board.length; i++)   // Remove entities
        {
            var cell = board[i]
            if(cell !== null)


            var nextBoardCell = nextBoard[i]
            if (nextBoardCell !== null)
                cellBoardEntityManager.removeEntityById(nextBoardCell.entityId)
        }

        board = []
        nextBoard = []
    }

    // Create a new cell at specific position
    function createCell(row, column) {
        // Configure cell
        var entityProperties = {
            width: cellSize,
            height: cellSize,
            x: column * cellSize,
            y: row * cellSize,
            isAlive: false,
            row: row,
            column: column
        }

        // Create a new entitiy with our properties and return it
        var id = cellBoardEntityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Cell.qml"), entityProperties)
        return cellBoardEntityManager.getEntityById(id)
    }

    // Works through a single full simulation step with all cell changes
    function doSimulationStep() {
        // Iterate over all cells to recalculate them
        for(var y = 0; y < rows; y++)
        {
            for(var x = 0; x < columns; x++)
            {
                calculateCell(y, x, getCellNeighbours(y, x))
            }
        }

        // Update the the displayed version
        board = nextBoard

        // The current simulation round is over so we increase to the next
        ++currentSimulationStep

        // If we went through the desired number of simulationsteps, we stop
        if (currentSimulationStep == setupSimulationSteps)
            simulationRunning = false
    }

    // Returns an array with all neighbours for the cell on the given coordinates
    function getCellNeighbours(row, column)
    {
        var neighbourCells = []
        // Precalculate the different possiblites of where the given cell is located
        var isLeftUpperCorner = (column === leftBorder && row === upperBorder)
        var isRightUpperCorner = (column === rightBorder && row === upperBorder)
        var isLeftLowerCorner = (column === leftBorder && row === lowerBorder)
        var isRightLowerCorner = (column === rightBorder && row === lowerBorder)
        var isLeftBorder = column === leftBorder
        var isRightBorder = column === rightBorder
        var isUpperBorder = row === upperBorder
        var isLowerBorder = row === lowerBorder

        // Handle each case and depending on it, store the neighbouring cells
        if (isLeftUpperCorner) {
            neighbourCells[0] = board[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = board[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = board[index(row + 1, column + 1)]      // Lower Right Neighbour
        }
        else if (isRightUpperCorner) {
            neighbourCells[0] = board[index(row, column - 1)]          // Left Neighbour
            neighbourCells[1] = board[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = board[index(row + 1, column - 1)]      // Lower Left Neighbour
        }
        else if (isLeftLowerCorner) {
            neighbourCells[0] = board[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = board[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[2] = board[index(row - 1, column + 1)]      // Upper Right Neighbour
        }
        else if (isRightLowerCorner) {
            neighbourCells[0] = board[index(row, column - 1)]          // Left Neighbour
            neighbourCells[1] = board[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[2] = board[index(row - 1, column - 1)]      // Upper Left Neighbour
        }
        else if (isLeftBorder) {
            neighbourCells[0] = board[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = board[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = board[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[3] = board[index(row + 1, column + 1)]      // Lower Right Neighbour
            neighbourCells[4] = board[index(row - 1, column + 1)]      // Upper Right Neighbour
        }
        else if (isRightBorder) {
            neighbourCells[0] = board[index(row, column - 1)]          // Left Neighbour
            neighbourCells[1] = board[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[2] = board[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[3] = board[index(row + 1, column - 1)]      // Lower Left Neighbour
            neighbourCells[4] = board[index(row - 1, column - 1)]      // Upper Left Neighbour
        }
        else if (isUpperBorder) {
            neighbourCells[0] = board[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = board[index(row, column - 1)]          // Left Neighbour
            neighbourCells[2] = board[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[3] = board[index(row + 1, column + 1)]      // Lower Right Neighbour
            neighbourCells[4] = board[index(row + 1, column - 1)]      // Lower Left Neighbour

        }
        else if (isLowerBorder) {
            neighbourCells[0] = board[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = board[index(row, column - 1)]          // Left Neighbour
            neighbourCells[2] = board[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[3] = board[index(row - 1, column + 1)]      // Upper Right Neighbour
            neighbourCells[4] = board[index(row - 1, column - 1)]      // Upper Left Neighbour
        }
        else {
            neighbourCells[0] = board[index(row, column + 1)]          // Right Neighbour
            neighbourCells[1] = board[index(row, column - 1)]          // Left Neighbour
            neighbourCells[2] = board[index(row + 1, column)]          // Lower Neighbour
            neighbourCells[3] = board[index(row - 1, column)]          // Upper Neighbour
            neighbourCells[4] = board[index(row + 1, column + 1)]      // Lower Right Neighbour
            neighbourCells[5] = board[index(row - 1, column + 1)]      // Upper Right Neighbour
            neighbourCells[6] = board[index(row + 1, column - 1)]      // Lower Left Neighbour
            neighbourCells[7] = board[index(row - 1, column - 1)]      // Upper Left Neighbour
        }

        return neighbourCells
    }

    // Performs the actual change of cell, depending on its neighbours
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

    // Performs the changes for a living cell
    function calculateLivingCell(livingNeighbours, row, column)
    {
        if (livingNeighbours <= 1)
        {
            // Cell dies due to solitude
            nextBoard[index(row, column)].setIsAlive(false)
        }
        else if (livingNeighbours >= 4)
        {
            // Cell dies due to overpopulation
            nextBoard[index(row, column)].setIsAlive(false)
        }
    }

    // Performs the changes for a dead cell
    function calculateDeadCell(livingNeighbours, row, column)
    {
        if (livingNeighbours === 3)
        {
            // Cell comes to live due to the correct environment
            nextBoard[index(row, column)].setIsAlive(true)
        }
    }
}
