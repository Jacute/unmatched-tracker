import QtQuick
import QtQuick.Controls

import Tracker

Button {
    property int radius: height

    id: root

    font.pixelSize: Common.defaultFontSize
    font.bold: true

    background: Rectangle {
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
}