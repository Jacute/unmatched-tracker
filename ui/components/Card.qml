import QtQuick 2.15
import Tracker
import Qt5Compat.GraphicalEffects

Rectangle {
    property string cardName
    property string cardImg: ""
    property int fontSize: 14
    property string labelPosition: "top"
    property int imgRadius: 0
    property alias cardImgFillMode: img.fillMode

    signal imgClicked()

    id: root
    color: "transparent"

    Column {
        anchors.fill: parent
        spacing: root.height * 0.02

        // Top label
        Item {
            id: nameTop
            visible: root.labelPosition === "top"
            width: img.width
            height: root.height * 0.15

            Text {
                text: root.cardName
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                color: Common.textSecondary
                font.pixelSize: root.fontSize
                wrapMode: Text.WordWrap
            }
        }

        // Card image
        Rectangle {
            id: imageContainer
            width: root.width
            height: {
                var labelHeight = 0
                if (root.labelPosition === "top" && nameTop.visible) {
                    labelHeight = nameTop.height + parent.spacing
                } else if (root.labelPosition === "bottom" && nameBottom.visible) {
                    labelHeight = nameBottom.height + parent.spacing
                } 
                return parent.height - labelHeight
            }
            color: "transparent"

            Image {
                property bool isHovered: mouseArea.containsMouse

                id: img
                source: root.cardImg
                anchors.fill: parent

                smooth: true
                visible: false
            }

            // Round
            Rectangle {
                id: mask
                width: parent.width
                height: parent.height
                radius: root.imgRadius
                visible: false
            }
            OpacityMask {
                anchors.fill: parent
                source: img
                maskSource: mask
                scale: mouseArea.containsMouse ? 1.02 : 1.0

                Behavior on scale {
                    NumberAnimation { duration: 150 }
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: root.imgClicked()
            }
        }

        // Bottom label
        Item {
            id: nameBottom
            visible: root.labelPosition === "bottom"
            width: img.width
            height: root.height * 0.15
            
            Text {
                text: root.cardName
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                color: Common.textSecondary
                font.pixelSize: root.fontSize
                wrapMode: Text.WordWrap
            }
        }
    }
}