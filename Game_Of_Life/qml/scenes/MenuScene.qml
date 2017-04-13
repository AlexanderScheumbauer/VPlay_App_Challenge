import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Menu Scene
SceneBase {
    id: menuScene

    // Signal indicating that the gameScene should be displayed and the simulation can start
    signal startSimulationPressed
    // Signals to trigger an in-/decrease of living cells at the begin of the simulation
    signal increaseLivingCells
    signal decreaseLivingCells
    // Signals to trigger an in-/decrease of simulation steps to be performed
    signal increaseSimulationSteps
    signal decreaseSimulationSteps

    // Headline with the name of the app
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#e9e9e9"
        text: "The Game of Life"
    }

    // UI for setting up the simulation details
    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "Start Simulation"
            onClicked: startSimulationPressed()
        }

        Row {
            MenuButton {
                text: "-"
                onClicked: decreaseLivingCells()
            }
            MenuLabel {
                text: setupLivingCells
            }
            MenuButton {
                text: "+"
                onClicked: increaseLivingCells()
            }
            MenuLabel {
                text: "Define number of living cells"
                color: "#47688e"
            }
        }
        Row {
            MenuButton {
                text: "-"
                onClicked: decreaseSimulationSteps()
            }
            MenuLabel {
                text: setupSimulationSteps
            }
            MenuButton {
                text: "+"
                onClicked: increaseSimulationSteps()
            }
            MenuLabel {
                text: "Define number of simulation steps"
                color: "#47688e"
            }
        }
    }
}
