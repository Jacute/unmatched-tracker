import QtQuick
import QtQuick.Controls

import Tracker

CheckBox {
    property string description: ""

    id: root
    hoverEnabled: true
    spacing: 8
    implicitHeight: Math.max(32, contentItem.implicitHeight + 8)

    indicator: Rectangle {
        x: 0
        y: (root.height - height) / 2
        width: 22
        height: 22
        radius: 4
        color: root.checked ? Common.accent : Common.primary
        border.width: 1
        border.color: root.checked ? Common.accentHover : Common.textHint

        Rectangle {
            visible: root.checked
            x: 6
            y: 10
            width: 3
            height: 7
            radius: 1
            color: Common.primary
            rotation: -45
        }

        Rectangle {
            visible: root.checked
            x: 12
            y: 5
            width: 3
            height: 12
            radius: 1
            color: Common.primary
            rotation: 45
        }
    }

    contentItem: Item {
        implicitWidth: checkboxText.implicitWidth
            + root.indicator.width
            + root.spacing
            + infoIcon.width
            + root.spacing
        implicitHeight: Math.max(checkboxText.implicitHeight, infoIcon.height)

        Text {
            id: checkboxText
            anchors {
                left: parent.left
                right: infoIcon.left
                top: parent.top
                bottom: parent.bottom
                rightMargin: root.spacing
            }
            leftPadding: root.indicator.width + root.spacing
            text: root.text
            color: root.enabled ? Common.textSecondary : Common.textHint
            font.pixelSize: Common.defaultFontSize * 0.84
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        Item {
            id: infoIcon
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
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
                x: infoIcon.width - width
                y: -height - 6
                width: Math.min(300, root.width)
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
    }
}
