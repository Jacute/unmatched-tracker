import QtQuick
import QtQuick.Layouts

import Tracker

Rectangle {
    property alias heroes: heroFilter.listdata
    property alias maps: mapFilter.listdata
    property alias sets: setFilter.listdata

    id: root
    color: "transparent"

    ColumnLayout {
        anchors.fill: parent
        
        Item {
            Layout.fillHeight: true
        }
        
        Rectangle {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredWidth: root.width / 2
            Layout.preferredHeight: root.height * 0.4
            color: "transparent"

            MultiSelectDropdown {
                id: setFilter
                anchors.fill: parent
                text: qsTr("Set")
            }
        }

        RowLayout {
            id: rl
            Layout.preferredHeight: root.height * 0.4
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Rectangle {
                Layout.preferredWidth: root.width * 0.4
                Layout.fillHeight: true
                color: "transparent"

                MultiSelectDropdown {
                    id: mapFilter
                    anchors.fill: parent
                    text: qsTr("Map")
                }
            }

            Rectangle {
                Layout.preferredWidth: root.width * 0.4
                Layout.fillHeight: true
                color: "transparent"

                MultiSelectDropdown {
                    id: heroFilter
                    anchors.fill: parent
                    text: qsTr("Hero")
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
