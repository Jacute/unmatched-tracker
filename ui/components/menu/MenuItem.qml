pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

import Tracker

Button {
    property string pageName: ""
    property bool selected: false
    property bool nested: false

    id: root
    implicitHeight: Math.max(48, Common.defaultFontSize * 3)
    padding: 0
    hoverEnabled: true

    background: Rectangle {
        radius: 6
        color: root.selected
            ? Qt.rgba(Common.accent.r, Common.accent.g, Common.accent.b, 0.18)
            : root.down || root.hovered
                ? Qt.rgba(1, 1, 1, 0.08)
                : "transparent"

        Behavior on color {
            ColorAnimation { duration: 120 }
        }

        Rectangle {
            visible: root.selected
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 7
            }
            width: 3
            radius: 1.5
            color: Common.accent
        }
    }

    contentItem: Item {
        Text {
            anchors {
                fill: parent
                leftMargin: root.nested ? 34 : 18
                rightMargin: 18
            }
            text: root.text
            color: root.selected ? Common.textColor : Common.textSecondary
            font.pixelSize: Common.defaultFontSize * (root.nested ? 0.92 : 1)
            font.bold: root.selected
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }
}
