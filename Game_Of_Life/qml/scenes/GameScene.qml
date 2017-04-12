import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Game Scene
SceneBase {
    id: gameScene

    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 320
    height: 480

    property bool simulationRunning: false

    sceneAlignmentY: "top"
    sceneAlignmentX: "left"

    EntityManager {
         id: cellBoardEntityManager
         entityContainer: gameScene
    }

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "grey"
    }

    CellBoard {
        id: cellBoard
        anchors.horizontalCenter: gameScene.horizontalCenter
        cellSize: 30
        y: 20
    }

    // initialize game
    function startGame(numberOfLivingCells) {
        cellBoard.initializeBoard(numberOfLivingCells);
        simulationRunning = false
    }

    function getNumberOfCells() {
        return cellBoard.boardSize * cellBoard.boardSize;
    }

    Column {
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10

        MenuLabel {
            text: "Current Simulation Round: " + currentSimulationRound
        }

        // back button to leave scene
         MenuButton {
             text: "Abort Simulation"
             onClicked: backButtonPressed()
        }
    }

    Timer {
        id: simulationTimer
        running: simulationRunning
        interval: 50 // milliseconds
        repeat: true
        onTriggered: cellBoard.doSimulationStep()
    }

}
