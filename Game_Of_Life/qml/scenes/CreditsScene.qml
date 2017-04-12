import VPlay 2.0
import QtQuick 2.0

import "../entities"

// The Credits scene
SceneBase {
   id:creditsScene

   // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#49a349"
   }

   // back button to leave scene
    MenuButton {
        text: "Back"
        anchors.right: creditsScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: creditsScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
   }
 }
