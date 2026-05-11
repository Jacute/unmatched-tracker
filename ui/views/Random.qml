import QtQuick

import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.primary

    RandomWheel {
        anchors.topMargin: parent.height * 0.01
        anchors.centerIn: parent
        width: parent.width - parent.width * 0.02
        height: parent.width - parent.width * 0.02
    }
}