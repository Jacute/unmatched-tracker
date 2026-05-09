import QtQuick 2.15
import QtQuick.Controls 2.15

import Tracker

Drawer {
    readonly property int fontSize: parent.height * 0.015

    id: root
    edge: Qt.LeftEdge

    background: Rectangle {
        color: "#2c3e50"
        gradient: Gradient {
            GradientStop { position: 0; color: "#2c3e50" }
            GradientStop { position: 1; color: "#44495e" }
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: parent.height * 0.01
        spacing: parent.height * 0.02

        Text {
            text: "Меню"
            font.pixelSize: root.fontSize * 1.2
            color: Common.textColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter

            background: Rectangle {
                radius: 10
                color: Common.secondary
            }

            contentItem: Text {
                text: "Наборы персонажей"
                font.pixelSize: root.fontSize
                color: Common.textSecondary
            }
        }
    }

    Overlay.modal: Rectangle {
        color: "#80000000"
    }
}