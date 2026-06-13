import QtQuick
import QtQuick.Controls

import Tracker

Button {
    property int radius: 0

    property color bgColor: Common.secondary
    property color bgColorPressed: Qt.darker(bgColor, 1.2)
    
    property color txtColor: Common.textColor
    property int fontSize: Common.defaultFontSize
    
    property int borderWidth: 1
    property color borderColor: Qt.lighter(bgColor, 1.25)

    id: root

    font.pixelSize: Common.defaultFontSize
    font.bold: true

    background: Rectangle {
        anchors.fill: root
        radius: root.radius
        color: root.pressed
            ? root.bgColorPressed
            : root.bgColor

        border.color: root.borderColor
        border.width: root.borderWidth

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
            font.pixelSize: root.fontSize
        }
    }
}