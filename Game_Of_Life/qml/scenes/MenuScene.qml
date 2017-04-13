import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Menu Scene
SceneBase {
    id: menuScene

    // signal indicating that the gameScene should be displayed
    signal startSimulationPressed

    signal increaseLivingCells
    signal decreaseLivingCells

    signal increaseSimulationRounds
    signal decreaseSimulationRounds

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
    }

    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#e9e9e9"
        text: "The Game of Life"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "Start Simulation"
            onClicked: startSimulationPressed()
        }

        Row {
            MenuButton {
                text: "Increase living cells"
                onClicked: increaseLivingCells()
            }
            MenuLabel {
                id: livingCellsLabel
                text: setupLivingCells
            }
            MenuButton {
                text: "Decrease living cells"
                onClicked: decreaseLivingCells()
            }
        }
        Row {
            MenuButton {
                text: "Increase Simulations rounds"
                onClicked: increaseSimulationRounds()
            }
            MenuLabel {
                id: simulationRoundsLabel
                text: setupSimulationSteps
            }
            MenuButton {
                text: "Decrease Simulation rounds"
                onClicked: decreaseSimulationRounds()
            }
        }
    }
}
