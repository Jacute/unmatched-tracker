import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../common"

Rectangle {
    id: root
    
    property alias text: pageName.text
    readonly property int headerFontPixelSize: parent.width / 20

    height: parent.height * 0.05
    width: parent.width

    color: Common.secondary

    anchors.top: parent.top

    Button {
        id: menu
        height: parent.height
        width: parent.width * 0.15

        background: Rectangle {
            color: Common.secondary
        }

        contentItem: Column {
            anchors {
                top: parent.top
                topMargin: parent.height * 0.25
                horizontalCenter: parent.horizontalCenter
            }
            spacing: parent.height * 0.1
            
            Rectangle {
                color: Common.primary
                width: parent.parent.width * 0.4
                height: parent.parent.height * 0.1
                radius: parent.parent.height * 0.05
            }
            Rectangle {
                color: Common.primary
                width: parent.parent.width * 0.4
                height: parent.parent.height * 0.1
                radius: parent.parent.height * 0.05
            }
            Rectangle {
                color: Common.primary
                width: parent.parent.width * 0.4
                height: parent.parent.height * 0.1
                radius: parent.parent.height * 0.05
            }
        }

        onClicked: {
            console.log("menu opened")
        }
    }

    Text {
        id: pageName
        font.bold: true
        font.pixelSize: parent.headerFontPixelSize
        color: Common.textColor

        width: parent.width
        height: parent.height

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}