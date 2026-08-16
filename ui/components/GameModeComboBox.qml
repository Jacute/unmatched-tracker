import QtQuick

import "."
import Tracker

FieldBox {
    readonly property alias currentIndex: modeSelect.currentIndex

    id: root
    label: qsTr("Game mode")

    ThemedComboBox {
        id: modeSelect
        anchors.fill: parent
        model: Common.gameModesModel
        textRole: "name"
    }

    function modeCode() {
        return Common.gameModesModel.get(currentIndex).code
    }
}
