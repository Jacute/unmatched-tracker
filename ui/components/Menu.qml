pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

import Tracker
import "./menu" as MenuUi

Drawer {
    readonly property string menuColor: "#2c3e50"
    property string currentPage: ""

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

    Flickable {
        id: navigationScroll
        anchors {
            top: menuLogo.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: Math.max(8, parent.height * 0.01)
            rightMargin: Math.max(8, parent.height * 0.01)
            bottomMargin: Math.max(8, parent.height * 0.01)
        }
        contentWidth: width
        contentHeight: navigation.implicitHeight
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        Column {
            id: navigation
            width: navigationScroll.width
            spacing: 3

            Repeater {
                model: [
                    { text: qsTr("Overview"), page: Common.pageHome },
                    { text: qsTr("Character Sets"), page: Common.pageSet },
                    { text: qsTr("Player Profiles"), page: Common.pageProfiles },
                    { text: qsTr("Game History"), page: Common.pageGames }
                ]

                delegate: MenuUi.MenuItem {
                    required property var modelData

                    width: navigation.width
                    text: modelData.text
                    pageName: modelData.page
                    selected: root.currentPage === pageName

                    onClicked: root.changePage(pageName)
                }
            }

            MenuUi.MenuGroup {
                width: navigation.width
                title: qsTr("Tools")
                currentPage: root.currentPage
                entries: [
                    { text: qsTr("Randomizer"), page: Common.pageRandom },
                    { text: qsTr("Timer"), page: Common.pageTimer }
                ]

                onPageSelected: (pageName) => root.changePage(pageName)
            }

            MenuUi.MenuItem {
                width: navigation.width
                text: qsTr("Settings")
                pageName: Common.pageSettings
                selected: root.currentPage === pageName

                onClicked: root.changePage(pageName)
            }
        }

        ScrollBar.vertical: ScrollBar {
            policy: navigationScroll.contentHeight > navigationScroll.height
                ? ScrollBar.AsNeeded
                : ScrollBar.AlwaysOff
        }
    }

    Overlay.modal: Rectangle {
        color: "#80000000"
    }
}
