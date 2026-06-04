import QtQuick
import QtQuick.Layouts

import Tracker

Rectangle {
    property alias heroes: heroFilter.listdata
    property alias maps: mapFilter.listdata

    id: root
    color: "transparent"

    RowLayout {
        anchors.centerIn: parent
        spacing: root.width * 0.01
        height: root.height

        Rectangle {
            Layout.preferredHeight: root.height * 0.8
            Layout.preferredWidth: root.width * 0.4
            color: "transparent"

            MultiSelectDropdown {
                id: mapFilter
                anchors.fill: parent
                text: "Map"
            }
        }

        Rectangle {
            Layout.preferredHeight: root.height * 0.8
            Layout.preferredWidth: root.width * 0.4
            color: "transparent"

            MultiSelectDropdown {
                id: heroFilter
                anchors.fill: parent
                text: "Hero"
            }
        }
    }

    function applyFilters() {
        
    }
}