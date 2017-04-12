import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "Cell"

    Text {
        id: cellText
        text: qsTr("O")
    }

    property bool isAlive: false
    property int positionX: 0
    property int positionY: 0

    Component.onCompleted: {
        x = positionX
        y = positionY
    }
}
