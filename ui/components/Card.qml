import QtQuick
import QtQuick.Effects

import "../common"

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

        color: "white"
        
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

    MultiEffect {
        property bool isHovered: mouseArea.containsMouse

        source: img
        anchors.fill: img
        shadowBlur: 1.0
        shadowEnabled: true
        shadowColor: isHovered ? Common.shadow2 : Common.shadow1
        shadowVerticalOffset: parent.height * 0.06
        shadowHorizontalOffset: parent.width * 0.05

        Behavior on shadowColor {
            ColorAnimation { duration: 150 }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        onEntered: {
            console.log("Mouse entered")
        }
        onExited: {
            console.log("Mouse exited")
        }
    }
}