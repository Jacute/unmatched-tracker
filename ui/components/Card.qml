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

        anchors.top: name.bottom
        // TODO: refactor this by layouts
        height: isHovered ? (parent.height - name.height - parent.margin * 2) : (parent.height - name.height - parent.margin * 2) * 0.98
        anchors.margins: parent.margin

        fillMode: Image.PreserveAspectFit

        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        Behavior on height {
            NumberAnimation { duration: 150 }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}