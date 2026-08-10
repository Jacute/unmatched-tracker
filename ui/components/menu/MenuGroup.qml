pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

import Tracker

Item {
    property string title: ""
    property var entries: []
    property string currentPage: ""
    property bool expanded: false

    signal pageSelected(string pageName)

    readonly property real itemHeight: Math.max(48, Common.defaultFontSize * 3)
    readonly property bool currentPageInGroup: containsPage(currentPage)

    id: root
    implicitHeight: header.height + (expanded ? entriesColumn.implicitHeight : 0)
    clip: true

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    Button {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: root.itemHeight
        padding: 0
        hoverEnabled: true

        background: Rectangle {
            radius: 6
            color: root.currentPageInGroup
                ? Qt.rgba(Common.accent.r, Common.accent.g, Common.accent.b, 0.12)
                : header.down || header.hovered
                    ? Qt.rgba(1, 1, 1, 0.08)
                    : "transparent"

            Behavior on color {
                ColorAnimation { duration: 120 }
            }
        }

        contentItem: Item {
            Text {
                anchors {
                    fill: parent
                    leftMargin: 18
                    rightMargin: chevron.width + 30
                }
                text: root.title
                color: root.currentPageInGroup ? Common.textColor : Common.textSecondary
                font.pixelSize: Common.defaultFontSize
                font.bold: root.currentPageInGroup
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            Item {
                id: chevron
                anchors {
                    right: parent.right
                    rightMargin: 18
                    verticalCenter: parent.verticalCenter
                }
                width: 16
                height: 10
                rotation: root.expanded ? 180 : 0

                Behavior on rotation {
                    NumberAnimation { duration: 180 }
                }

                Rectangle {
                    width: 10
                    height: 2
                    radius: 1
                    color: Common.textSecondary
                    rotation: 35
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    width: 10
                    height: 2
                    radius: 1
                    color: Common.textSecondary
                    rotation: -35
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        onClicked: root.expanded = !root.expanded
    }

    Column {
        id: entriesColumn
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        opacity: root.expanded ? 1 : 0
        enabled: root.expanded

        Behavior on opacity {
            NumberAnimation { duration: 140 }
        }

        Repeater {
            model: root.entries

            delegate: MenuItem {
                required property var modelData

                width: entriesColumn.width
                height: root.itemHeight
                nested: true
                text: modelData.text
                pageName: modelData.page
                selected: root.currentPage === pageName

                onClicked: root.pageSelected(pageName)
            }
        }
    }

    Component.onCompleted: {
        if (currentPageInGroup) {
            expanded = true
        }
    }

    onCurrentPageChanged: {
        if (currentPageInGroup) {
            expanded = true
        }
    }

    function containsPage(pageName) {
        for (let i = 0; i < entries.length; ++i) {
            if (entries[i].page === pageName) {
                return true
            }
        }
        return false
    }
}
