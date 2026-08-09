import QtQuick
import QtQuick.Layouts

import ".."

Item {
    property string label: ""
    property string defaultTime: ""
    readonly property bool capped: cappedBonus.checked

    id: root
    implicitHeight: content.implicitHeight

    ColumnLayout {
        id: content
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 2

        TimeField {
            id: timeField
            Layout.fillWidth: true
            label: root.label
            defaultTime: root.defaultTime
        }

        ThemedCheckBox {
            id: cappedBonus
            Layout.fillWidth: true
            Layout.leftMargin: 6
            text: qsTr("Capped bonus")
            description: qsTr("Keeps additional time in a separate reserve. Unused bonus time is restored to the configured value instead of accumulating.")
        }
    }

    function seconds() {
        return timeField.seconds()
    }
}
