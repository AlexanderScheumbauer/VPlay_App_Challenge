import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "Cell"

  /*  Rectangle {
        width: 50
        height: 50
        color: "red"
    }*/

    Text {
        id: cellText
        text: qsTr("O")
    }

    property bool isAlive: false
    property int positionX: 0
    property int positionY: 0
}
