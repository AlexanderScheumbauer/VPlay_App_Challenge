import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    screenWidth: 960
    screenHeight: 640

    // start the game when is splash finished
    onSplashScreenFinished: golScene.start();

    GoL_Scene {
        id: golScene

    }
}
