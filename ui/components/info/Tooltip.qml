import QtQuick
import QtQuick.Controls

import Tracker

Item {
    required property string description

    id: root
    width: 24
    height: 24
    visible: root.description.length > 0

    Rectangle {
        anchors.centerIn: parent
        width: 18
        height: 18
        radius: width / 2
        color: infoArea.pressed ? Common.accent : "transparent"
        border.width: 1
        border.color: infoArea.containsMouse
            ? Common.accent
            : Common.textHint

        Text {
            anchors.centerIn: parent
            text: "i"
            color: infoArea.pressed ? Common.primary : Common.textSecondary
            font.pixelSize: Common.defaultFontSize * 0.72
            font.bold: true
        }
    }

    MouseArea {
        id: infoArea
        anchors.fill: parent
        hoverEnabled: true
        preventStealing: true
    }

    ToolTip {
        visible: infoArea.containsMouse || infoArea.pressed
        delay: infoArea.pressed ? 0 : 500
        timeout: -1
        x: root.width - width
        y: -height - 6
        width: 300
        padding: 10

        contentItem: Text {
            text: root.description
            color: Common.textColor
            font.pixelSize: Common.defaultFontSize * 0.78
            wrapMode: Text.WordWrap
        }

        background: Rectangle {
            color: Common.secondary
            radius: Common.defaultRadius
            border.width: 1
            border.color: Common.imagePlaceholderSoft
        }
    }
}