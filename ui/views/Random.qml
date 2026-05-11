import QtQuick

import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.primary

    RandomWheel {
        anchors.centerIn: parent
        width: parent.width / 2
    }
}