import QtQuick 2.15

import Tracker

Rectangle {
    property alias cardName: name.text
    property alias cardImg: img.source
    property int fontSize: 14
    property int margin: 10

    radius: 10
    color: Common.primary

    Text {
        id: name

        anchors.margins: parent.margin
        width: parent.width

        color: Common.textSecondary
        
        font.pixelSize: parent.fontSize
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }

    Image {
        property bool isHovered: mouseArea.containsMouse

        id: img

        anchors {
            top: name.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: parent.margin
        }
        fillMode: Image.PreserveAspectFit
        scale: mouseArea.containsMouse ? 1.02 : 1.0

        Behavior on scale {
            NumberAnimation { duration: 150 }
        }
        
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}