import QtQuick

import Tracker

Rectangle {
    id: root

    property real cornerRadius: Math.min(width, height) * 0.035

    radius: cornerRadius
    clip: true
    color: Common.imagePlaceholder

    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: Common.primary }
        GradientStop { position: 0.55; color: Common.imagePlaceholder }
        GradientStop { position: 1.0; color: Common.secondary }
    }

    Rectangle {
        width: parent.width * 1.45
        height: Math.max(1, parent.height * 0.22)
        x: parent.width * -0.2
        y: parent.height * 0.18
        rotation: -12
        radius: height / 2
        color: Common.imagePlaceholderSoft
        opacity: 0.24
    }

    Rectangle {
        width: parent.width * 1.35
        height: Math.max(1, parent.height * 0.12)
        x: parent.width * -0.15
        y: parent.height * 0.63
        rotation: -12
        radius: height / 2
        color: Common.accent
        opacity: 0.07
    }

    Rectangle {
        id: shimmer
        width: Math.max(24, parent.width * 0.2)
        height: parent.height * 1.7
        x: -width * 1.4
        y: -parent.height * 0.35
        rotation: 18
        radius: width / 2
        opacity: 0.16
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: Common.accentHover }
            GradientStop { position: 1.0; color: "transparent" }
        }

        SequentialAnimation on x {
            running: root.visible
            loops: Animation.Infinite
            PauseAnimation { duration: 260 }
            NumberAnimation {
                from: -shimmer.width * 1.4
                to: root.width + shimmer.width
                duration: 1400
                easing.type: Easing.InOutCubic
            }
            PauseAnimation { duration: 700 }
        }
    }

    Item {
        width: Math.min(parent.width, parent.height) * 0.18
        height: width
        anchors.centerIn: parent
        opacity: 0.48

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "transparent"
            border.width: Math.max(2, width * 0.12)
            border.color: Common.accent
            opacity: 0.22
        }

        Rectangle {
            width: parent.width * 0.32
            height: Math.max(2, parent.height * 0.12)
            radius: height / 2
            color: Common.accentHover
            opacity: 0.7
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }

        RotationAnimation on rotation {
            running: root.visible
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 1400
            easing.type: Easing.Linear
        }
    }
}
