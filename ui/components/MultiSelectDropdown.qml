pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker

Rectangle {
    property var listdata: []
    property var selected: []
    property string text

    signal changed(var selected)

    id: root
    color: "transparent"

    Btn {
        id: combo
        text: root.text
        width: root.width
        height: root.height
        onClicked: {
            pp.open()
        }
    }

    Popup {
        id: pp
        y: combo.height
        width: combo.width
        padding: 5
        clip: true

        background: Rectangle {
            color: Common.secondary
            radius: 5
        }

        ListView {
            id: list
            width: parent.width
            height: Math.min(contentHeight, 200)

            model: root.listdata

            delegate: Item {
                required property var modelData
                id: listItem
                width: parent.width
                height: 40

                RowLayout {
                    anchors.fill: parent

                    CheckBox {
                        checked: root.selected.includes(listItem.modelData)
                    }

                    Text {
                        text: listItem.modelData
                        color: Common.textColor
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: function(mouse) {
                        const value = listItem.modelData

                        if (root.selected.includes(value)) {
                            root.selected = root.selected.filter(x => x !== value)
                        } else {
                            root.selected = root.selected.concat(value)
                        }

                        root.changed(root.selected)
                    }
                    
                }
            }
        }
        height: list.contentHeight
    }
}