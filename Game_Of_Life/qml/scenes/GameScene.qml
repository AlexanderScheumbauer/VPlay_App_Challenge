import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Game Scene
SceneBase {
    id: gameScene

    property bool gameRunning: false

    sceneAlignmentY: top

    // signal indicating that the creditsScene should be displayed
    signal creditsPressed

    // TODO: Add the background, UI elements

    EntityManager {
         id: cellBoardEntityManager
         entityContainer: gameScene
    }

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#dd94da"
    }

    CellBoard {
        id: cellBoard
        height: parent.height - 10;
        anchors.right: parent.left
    }

    // back button to leave scene
     MenuButton {
         text: "Back"
         anchors.right: gameScene.gameWindowAnchorItem.right
         anchors.rightMargin: 10
         anchors.top: gameScene.gameWindowAnchorItem.top
         anchors.topMargin: 10
         onClicked: backButtonPressed()
    }
}
