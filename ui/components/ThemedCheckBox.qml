import QtQuick
import QtQuick.Controls

import Tracker
import "./info" as Info

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

        Info.Tooltip {
            id: infoIcon
            visible: root.description.length != 0
            description: root.description

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
        }
    }
}
