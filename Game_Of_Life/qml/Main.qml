import VPlay 2.0
import QtQuick 2.0

import "scenes"

GameWindow {
    id: gameWindow

    screenWidth: 960
    screenHeight: 640

    // starting state is menu
    state: "menu"

    // state machine, takes care of reversing the PropertyChanges when changing the state. e.g. it changes the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
        },
        State {
            name: "game"
            PropertyChanges {target: golScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: golScene}
        }
    ]

    GoL_Scene {
        id: golScene
        onMenuScenePressed: gameWindow.state = "menu"
    }

    // the menu scene of the game
    MenuScene {
        id: menuScene
        onGameScenePressed: gameWindow.state = "game"

    }
}
