import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Menu Scene
SceneBase {
    id: menuScene

    //property int setupLivingCells: 0

    // signal indicating that the gameScene should be displayed
    signal startSimulationPressed
    // signal indicating that the creditsScene should be displayed
    signal creditsPressed

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
        /*MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
        }*/
    }
}
