import VPlay 2.0
import QtQuick 2.0

import "scenes"

GameWindow {
    id: gameWindow

    screenWidth: 960
    screenHeight: 640

    EntityManager {
        id: entityManager
    }

    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onStartSimulationPressed: gameWindow.state = "game"
        //onCreditsPressed: gameWindow.state = "credits"
    }

    // game scene
    GameScene {
        id: gameScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // credits scene
    CreditsScene {
        id: creditsScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // default state is menu -> default scene is menuScene
    state: "menu"
    activeScene: menuScene

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
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: creditsScene}
        }
    ]
}
