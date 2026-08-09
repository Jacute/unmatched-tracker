import QtQuick
import QtQuick.Controls

import Tracker
import "../image" as Img

Button {
    property url iconSource: ""
    property string toolTipText: ""

    id: root
    implicitWidth: 88
    implicitHeight: 88
    hoverEnabled: true
    padding: 0

    background: Rectangle {
        radius: width / 2
        color: Common.primary
        clip: true
        border.width: 2
        border.color: root.down ? Common.accent : Common.textSecondary

        Img.Rounded {
            anchors.fill: parent
            src: root.iconSource
        }

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: root.down ? "#30000000" : "transparent"
        }
    }

    contentItem: Item {}

    scale: down ? 0.94 : 1.0

    Behavior on scale {
        NumberAnimation { duration: 90 }
    }

    ToolTip.visible: hovered && toolTipText.length > 0
    ToolTip.delay: 500
    ToolTip.text: toolTipText
}
