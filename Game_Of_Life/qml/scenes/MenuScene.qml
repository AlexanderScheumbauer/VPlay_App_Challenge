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
        text: "MultiSceneMultiLevel"
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
            Text {
                id: livingCellsText
                text: setupLivingCells
            }
            MenuButton {
                text: "Decrease living cells"
                onClicked: decreaseLivingCells()
            }
        }
    }
}
