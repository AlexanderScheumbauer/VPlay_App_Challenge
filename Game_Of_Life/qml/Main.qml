import VPlay 2.0
import QtQuick 2.0

import "scenes"

GameWindow {
    id: gameWindow

    screenWidth: 960
    screenHeight: 640

    property int setupLivingCells: 2
    property int setupSimulationSteps: 1
    property int currentSimulationStep: 0

    MenuScene {
        id: menuScene
        onStartSimulationPressed: doStartSimulationPressed();
        onIncreaseLivingCells: doIncreaseLivingCells();
        onDecreaseLivingCells: doDecreaseLivingCells();
        onIncreaseSimulationSteps: doIncreaseSimulationSteps();
        onDecreaseSimulationSteps: doDecreaseSimulationSteps();
    }

    GameScene {
        id: gameScene
        onBackButtonPressed: doResetSimulation()
    }

    // default state is menu -> default scene is menuScene
    state: "menu"
    activeScene: menuScene

    // state machine, takes care of reversing the PropertyChanges when changing the state
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        }
    ]

    function doStartSimulationPressed() {
        gameWindow.state = "game"
        gameScene.startGame(setupLivingCells);
    }

    function doResetSimulation() {
        gameWindow.state = "menu"
        gameScene.simulationRunning = false
        setupLivingCells = 2
        setupSimulationSteps = 1
        currentSimulationStep = 0
    }

    function doIncreaseLivingCells() {
        if (setupLivingCells < gameScene.getNumberOfCells())
            ++setupLivingCells;
    }

    function doDecreaseLivingCells() {
        if (setupLivingCells > 0)
            --setupLivingCells;
    }

    function doIncreaseSimulationSteps() {
        ++setupSimulationSteps;
    }

    function doDecreaseSimulationSteps() {
        if (setupSimulationSteps > 1)
            --setupSimulationSteps;
    }
}
