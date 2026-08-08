import QtQuick

import "."
import Tracker

FieldBox {
    property int activeGameMode: 0
    readonly property string modeCode: Common.gameModesModel.get(activeGameMode).code

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
