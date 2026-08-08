import QtQuick
import QtQuick.Controls

import Tracker

Button {
    property string iconSource: ""
    property string toolTipText: ""

    id: root
    implicitWidth: 88
    implicitHeight: 88
    hoverEnabled: true
    padding: 0

    background: null

    contentItem: Rectangle {
        radius: width / 2
        color: Common.primary
        clip: true
        border.width: 2
        border.color: root.down ? Common.accent : Common.textSecondary

        Image {
            anchors.fill: parent
            source: root.iconSource
            fillMode: Image.PreserveAspectCrop
            mipmap: true
        }

        Rectangle {
            anchors.fill: parent
            color: root.down ? "#30000000" : "transparent"
        }
    }

    scale: down ? 0.94 : 1.0

    Behavior on scale {
        NumberAnimation { duration: 90 }
    }

    ToolTip.visible: hovered && toolTipText.length > 0
    ToolTip.delay: 500
    ToolTip.text: toolTipText
}
