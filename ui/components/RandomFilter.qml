import QtQuick
import QtQuick.Layouts

import Tracker

Rectangle {
    property var heroes

    id: root
    color: "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.centerIn: parent
        spacing: root.width * 0.01

        Layout.maximumHeight: root.height
        Layout.minimumHeight: root.height

        MultiSelectDropdown {
            id: mapFilter
            text: "Map"
            Layout.fillHeight: true
            Layout.preferredWidth: root.width * 0.4
            listdata: [
                "Baskerville",
                "Marmoreal"
            ]
        }

        MultiSelectDropdown {
            id: heroFilter
            text: "Hero"
            Layout.fillHeight: true
            Layout.preferredWidth: root.width * 0.4
            listdata: [
                "Dracula",
                "Sherlock Holmes",
                "Medusa",
                "Jekyll & Hyde",
                "Invisible man"
            ]
        }
    }

    function applyFilters() {
        
    }
}