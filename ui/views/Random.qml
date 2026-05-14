import QtQuick

import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.primary

    RandomWheel {
        anchors {
            leftMargin: parent.width * 0.01
            rightMargin: parent.width * 0.01
            topMargin: parent.height * 0.4
            top: root.top
        }
        width: parent.width - parent.width * 0.02
        height: parent.width - parent.width * 0.02
    }
}