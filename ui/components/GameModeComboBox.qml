import QtQuick

import "."
import Tracker

FieldBox {
    property alias activeGameMode: modeSelect.currentIndex
    readonly property int currentIndex: modeSelect.currentIndex
    readonly property string modeCode: Common.gameModesModel.get(activeGameMode).code

    id: root
    label: qsTr("Game mode")

    ThemedComboBox {
        id: modeSelect
        anchors.fill: parent
        model: Common.gameModesModel
        textRole: "name"
    }
}
