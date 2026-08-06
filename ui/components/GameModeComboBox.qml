import QtQuick

import "."
import Tracker

FieldBox {
    property int activeGameMode: 0

    id: root
    label: qsTr("Game mode")

    ThemedComboBox {
        id: modeSelect
        anchors.fill: parent
        model: Common.gameModesModel
        textRole: "name"

        onActivated: {
            root.activeGameMode = currentIndex
        }
    }
}