import QtQuick 2.15

import Tracker
import Render

Rectangle {
    property alias cardName: name.text
    property alias cardImg: img.source
    property int fontSize: 14

    signal imgClicked()

    id: root
    color: "transparent"

    Text {
        id: name

        width: parent.width
        color: Common.textSecondary
        font.pixelSize: parent.fontSize
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }

    Rectangle {
        anchors {
            top: name.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: root.height * 0.01
            bottomMargin: root.height * 0.01
        }
        color: "transparent"

        Image {
            property bool isHovered: mouseArea.containsMouse

            id: img
            anchors.fill: parent

            fillMode: Image.PreserveAspectFit
            scale: mouseArea.containsMouse ? 1.02 : 1.0

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
            
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: root.imgClicked()
            }
        }
    }
}