import QtQuick 2.15
import QtQuick.Controls 2.15

import Tracker

Drawer {
    readonly property int fontSize: parent.height * 0.02
    readonly property string menuColor: "#2c3e50"

    id: root
    edge: Qt.LeftEdge

    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    background: Rectangle {
        color: root.menuColor
        gradient: Gradient {
            GradientStop { position: 0; color: "#2c3e50" }
            GradientStop { position: 1; color: "#44495e" }
        }
    }

    Image {
        id: menuLogo
        width: parent.width
        source: qsTr("%1/ui/menu_logo.jpg").arg(Common.imgPrefix)
        fillMode: Image.PreserveAspectFit
    }

    Column {
        anchors {
            top: menuLogo.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: parent.height * 0.01
        }
        spacing: parent.height * 0.02

        Rectangle {
            width: parent.width
            height: parent.height * 0.11
            color: "transparent"
            
            Button {
                id: selectBtn
                width: parent.width
                height: parent.height * 0.9
                anchors {
                    top: parent.top
                }

                background: Rectangle {
                    color: "transparent"
                }

                contentItem: Text {
                    text: "Наборы персонажей"
                    font.pixelSize: root.fontSize
                    color: Common.textSecondary
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                anchors {
                    top: selectBtn.bottom
                }
                width: parent.width
                height: parent.height * 0.05
                color: Common.primary
                radius: 5
            }
        }
    }

    Overlay.modal: Rectangle {
        color: "#80000000"
    }
}