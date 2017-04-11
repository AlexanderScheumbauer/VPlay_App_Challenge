import VPlay 2.0
import QtQuick 2.0

// Menu Scene

Scene {
    id: menuScene

    // signal indicating that the gameScene should be displayed
    signal gameScenePressed

    property int setupLivingCells: 0

    // background image
    Image {
         anchors.fill: menuScene.gameWindowAnchorItem
         source: "../../assets/background.png"
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Rectangle {
            width: 150
            height: 50
            color: "orange"
            Text {
                id: increaseLivingCellsButton
                text: "+"
                anchors.centerIn: parent
            }

            MouseArea {
                id: increaseLivingCellsMouseArea
                anchors.fill: parent
                //onClicked: gameScenePressed()
            }
        }

        Text {
            id: livingCellsText
            text: setupLivingCells
        }

        Rectangle {
            width: 150
            height: 50
            color: "orange"
            Text {
                id: decreaseLivingCellsButton
                text: "-"
                anchors.centerIn: parent
            }
            MouseArea {
                id: decreaseLivingCellsMouseArea
                anchors.fill: parent
                //onClicked: frogNetworkView.visible = true
            }
        }
    }
}
