import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Game Scene
SceneBase {
    id: gameScene

    property bool simulationRunning: false

    sceneAlignmentY: "top"
    sceneAlignmentX: "left"

    // The entitiy  manager which will store all cells of our board
    EntityManager {
         id: cellBoardEntityManager
         entityContainer: gameScene
    }

    // The cellboard which will perform filling, clearing and calculation of the cells
    CellBoard {
        id: cellBoard
        anchors.horizontalCenter: gameScene.horizontalCenter
        cellSize: 30
        y: 20
    }

    // Start game
    function startGame(numberOfLivingCells) {
        cellBoard.initializeBoard(numberOfLivingCells);
        simulationRunning = true
    }

    // Returns the total number of cells
    function getNumberOfCells() {
        return cellBoard.boardSize * cellBoard.boardSize;
    }

    // UI displaying infos about the current state
    Column {
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10

        Row {
            MenuLabel {
                text: "Current Simulation Round: " + currentSimulationStep
                paddingVertical: 10
            }
        }
        Row {
             MenuLabel {
                 text: "Simulation finished!"
                 visible: !simulationRunning
                 textColor: "red"
             }
         }
    }

    // back button to leave scene
     MenuButton {
         anchors.right: gameScene.gameWindowAnchorItem.right
         anchors.rightMargin: 10
         anchors.bottom: gameScene.gameWindowAnchorItem.bottom
         anchors.bottomMargin: 10
         text: "Abort Simulation"
         onClicked: backButtonPressed()
    }

    // The timer which triggers and and controls the speed of the simulation
    Timer {
        id: simulationTimer
        running: simulationRunning
        interval: 1000 // milliseconds
        repeat: true
        onTriggered: cellBoard.doSimulationStep()
    }

}
