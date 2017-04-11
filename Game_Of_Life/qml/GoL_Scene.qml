import VPlay 2.0
import QtQuick 2.0

import "entities"

Scene {
    property bool gameRunning: false

    sceneAlignmentY: top

    // TODO: Add the board, background, UI elements

    function start() {
        gameRunning = true;
    }

    EntityManager {
         id: entityManager
         entityContainer: golScene
       }

    Rectangle {
        id: sceneBackground
        anchors.fill: parent
        color: "green"
    }

    Cell {
        height: parent.height + 50
        anchors.right: parent.left
    }
}
