import QtQuick

import Tracker
import "../image" as Img

Img.Rounded {
    property url iconSource: ""

    id: root
    implicitWidth: 88
    implicitHeight: 88
    src: iconSource
    opacity: enabled ? 1.0 : 0.45

    Rectangle {
        anchors.fill: parent
        radius: Math.min(width, height) / 2
        color: root.pressed ? "#30000000" : "transparent"
        border.width: 1
        border.color: root.pressed ? Common.accent : Common.textSecondary
    }

    scale: pressed ? 0.94 : 1.0

    Behavior on scale {
        NumberAnimation { duration: 90 }
    }
}
