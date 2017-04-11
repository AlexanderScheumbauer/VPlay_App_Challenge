import VPlay 2.0
import QtQuick 2.0

import "../entities"

SceneBase {
    property bool gameRunning: false

    sceneAlignmentY: top

    signal menuScenePressed

    // TODO: Add the background, UI elements

    EntityManager {
         id: cellBoardEntityManager
         entityContainer: golScene
    }

    Rectangle {
        id: sceneBackground
        anchors.fill: parent
        color: "green"
    }

    CellBoard {
        id: cellBoard
        height: parent.height - 10;
        anchors.right: parent.left
    }

    Rectangle {
        id: menuButton
        x: gameScene.width - 96
        y: -40
        scale: 0.5
        MouseArea {
            id: menuButtonMouseArea
            anchors.fill: parent
            onClicked: {
                menuScenePressed() // trigger the menuScenePressed signal

                // reset the golScene
                golScene.state = "start"
            }
        }
    }
}
