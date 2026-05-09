import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

import Tracker
import "../components"

Rectangle {
    id: root
    
    property alias text: pageName.text
    readonly property int headerFontPixelSize: parent.width / 20
    signal menuClicked

    height: parent.height * 0.05
    width: parent.width

    color: Common.secondary

    anchors.top: parent.top

    Button {
        id: menuBtn
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
            root.menuClicked()
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