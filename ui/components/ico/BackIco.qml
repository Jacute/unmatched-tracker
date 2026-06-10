import QtQuick

import Tracker

Item {
    anchors.fill: parent

    Item {
        width: parent.width * 0.5
        height: parent.height * 0.5
        anchors.centerIn: parent

        Rectangle {
            color: Common.primary
            width: parent.width * 0.45
            height: parent.height * 0.2
            radius: height / 2

            anchors.centerIn: parent

            rotation: -45
            transformOrigin: Item.Left
        }

        Rectangle {
            color: Common.primary
            width: parent.width * 0.45
            height: parent.height * 0.2
            radius: height / 2

            anchors.centerIn: parent

            rotation: 45
            transformOrigin: Item.Left
        }
    }
}