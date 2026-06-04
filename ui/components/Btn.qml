import QtQuick
import QtQuick.Controls

import Tracker

Button {
    property int radius: height
    property color txtColor: Common.textColor

    id: root

    font.pixelSize: Common.defaultFontSize
    font.bold: true

    background: Rectangle {
        anchors.fill: root
        radius: root.radius
        color: root.pressed
            ? Qt.darker(Common.secondary, 1.2)
            : Common.secondary

        border.color: Qt.lighter(Common.secondary, 1.25)
        border.width: 1

        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }
    }

    contentItem: Item {
        anchors.fill: parent
        Text {
            id: ciText
            anchors.centerIn: parent
            text: root.text
            color: root.txtColor
            font.pixelSize: Common.defaultFontSize
        }
    }
}