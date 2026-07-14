import QtQuick
import QtQuick.Layouts

import Tracker

Rectangle {
    property alias heroes: heroFilter.listdata
    property alias maps: mapFilter.listdata
    property alias sets: setFilter.listdata
    signal filtersChanged()

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
                onSelected: (index) => root.toggleSet(index)
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
                    onSelected: (index) => root.toggleChild(mapFilter.listdata, index)
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
                    onSelected: (index) => root.toggleChild(heroFilter.listdata, index)
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    // toggleSet updates property enabled of child entities (heroes, maps)
    function toggleSet(index) {
        const set = setFilter.listdata.get(index)
        const enabled = !set.enabled

        setChildrenEnabled(heroFilter.listdata, set.id, enabled)
        setChildrenEnabled(mapFilter.listdata, set.id, enabled)
        setFilter.listdata.setProperty(index, "enabled", enabled)
        root.filtersChanged()
    }

    // toggleChild change enabled field and call updateSetState
    function toggleChild(model, index) {
        const item = model.get(index)
        model.setProperty(index, "enabled", !item.enabled)
        updateSetState(item.set_id)
        root.filtersChanged()
    }

    function setChildrenEnabled(model, setId, enabled) {
        for (let i = 0; i < model.count; ++i) {
            if (model.get(i).set_id === setId) {
                model.setProperty(i, "enabled", enabled)
            }
        }
    }

    function syncSetStates() {
        for (let i = 0; i < setFilter.listdata.count; ++i) {
            updateSetState(setFilter.listdata.get(i).id)
        }
    }

    // updateSetState update property enabled if one of the child entities (heroes, maps) is enabled
    function updateSetState(setId) {
        const enabled = hasEnabledItem(heroFilter.listdata, setId)
            || hasEnabledItem(mapFilter.listdata, setId)

        for (let i = 0; i < setFilter.listdata.count; ++i) {
            if (setFilter.listdata.get(i).id === setId) {
                setFilter.listdata.setProperty(i, "enabled", enabled)
                return
            }
        }
    }

    // hasEnabledItem checks that one of entities in model belongs set and item is enabled
    function hasEnabledItem(model, setId) {
        for (let i = 0; i < model.count; ++i) {
            const item = model.get(i)
            if (item.set_id === setId && item.enabled) {
                return true
            }
        }
        return false
    }
}
