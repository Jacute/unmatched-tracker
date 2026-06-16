import QtQuick 2.15
import QtQuick.Controls 2.15
import Tracker

Rectangle {
    property string cardName
    property string cardImg: ""
    property int fontSize: 14
    property string labelPosition: "top"
    property int imgRadius: 0
    property Popup pressedPopup: null

    signal imgClicked()
    signal imgLongPressed()

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
            height: root.height * 0.2

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
        Image {
            property bool isHovered: mouseArea.containsMouse
            property bool isLongPressed: false

            id: img
            source: root.cardImg
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
            fillMode: Image.PreserveAspectFit
            smooth: true

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                
                onPressed: {
                    longPressTimer.start()
                    img.scale = 1.02
                }
                
                onReleased: {
                    if (longPressTimer.running) {
                        longPressTimer.stop()
                        console.debug("[Card] Short tap")
                        root.imgClicked()
                    }
                    img.scale = 1.0
                    img.isLongPressed = false
                }
                
                onCanceled: {
                    img.scale = 1.0
                    img.isLongPressed = false
                }

                Timer {
                    id: longPressTimer
                    interval: 500
                    running: false
                    onTriggered: {
                        img.isLongPressed = true
                        if (root.pressedPopup) {
                            root.imgLongPressed()
                            root.pressedPopup.open()
                        }
                        img.scale = 1.0
                    }
                }
            }

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
        }

        // Bottom label
        Item {
            id: nameBottom
            visible: root.labelPosition === "bottom"
            width: img.width
            height: root.height * 0.2
            
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
