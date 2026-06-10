import QtQuick

import Tracker


Item {
    anchors.fill: parent
    Column {
        spacing: parent.height * 0.1
        anchors.centerIn: parent
        
        Rectangle {
            color: Common.primary
            width: parent.parent.width * 0.4
            height: parent.parent.height * 0.1
            radius: parent.parent.height * 0.05
        }
        Rectangle {
            color: Common.primary
            width: parent.parent.width * 0.4
            height: parent.parent.height * 0.1
            radius: parent.parent.height * 0.05
        }
        Rectangle {
            color: Common.primary
            width: parent.parent.width * 0.4
            height: parent.parent.height * 0.1
            radius: parent.parent.height * 0.05
        }
    }
}