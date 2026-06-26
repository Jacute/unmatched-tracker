pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

import Tracker

Drawer {
    readonly property int fontSize: parent.height * 0.02
    readonly property string menuColor: "#2c3e50"
    signal changePage(string pageName)

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
            leftMargin: parent.height * 0.01
            rightMargin: parent.height * 0.01
        }

        Repeater {
            id: repeater
            model: [
                {
                    text: qsTr("Character Sets"),
                    page: Common.pageSet
                },
                {
                    text: qsTr("Randomizer"),
                    page: Common.pageRandom
                },
                {
                    text: qsTr("Player Profiles"),
                    page: Common.pageProfiles
                },
                {
                    text: qsTr("Game History"),
                    page: Common.pageGames
                }
            ]

            delegate: Rectangle {
                required property var modelData
                required property int index

                id: btnWrapper
                color: "transparent"
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: parent.height * 0.11
                
                Button {
                    id: selectBtn
                    width: parent.width
                    height: parent.height * 0.9
                    anchors {
                        top: parent.top
                    }

                    background: Rectangle {
                        color: selectBtn.down ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
                        radius: 10

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    contentItem: Text {
                        text: btnWrapper.modelData.text
                        font.pixelSize: root.fontSize
                        color: Common.textSecondary
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        root.changePage(btnWrapper.modelData.page);
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
                    visible: repeater.count - 1 != btnWrapper.index
                }
            }
        }
    }

    Overlay.modal: Rectangle {
        color: "#80000000"
    }
}
