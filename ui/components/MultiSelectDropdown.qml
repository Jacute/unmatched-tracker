pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker

Rectangle {
    property ListModel listdata
    property int itemHeight: 40
    property string text

    id: root
    color: "transparent"

    Btn {
        id: combo
        text: root.text
        width: root.width
        height: root.height
        radius: height
        onClicked: {
            pp.open()
        }
    }

    Popup {
        id: pp
        y: combo.height
        height: root.itemHeight * 3
        width: combo.width
        padding: 5
        clip: true

        background: Rectangle {
            color: Common.secondary
            radius: 5
            border.width: 1
            border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
        }

        ListView {
            id: list
            anchors.fill: parent
            clip: true
            model: root.listdata

            delegate: Item {
                required property int index
                required property string name
                required override property bool enabled
                id: listItem
                width: list.width
                height: root.itemHeight

                RowLayout {
                    anchors.fill: parent

                    CheckBox {
                        checked: listItem.enabled
                    }

                    Text {
                        text: listItem.name
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
                        root.listdata.setProperty(
                            listItem.index,
                            "enabled",
                            !listItem.enabled
                        )
                    } 
                }
            }
        }
    }
}
