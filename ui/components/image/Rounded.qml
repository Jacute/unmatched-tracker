import QtQuick
import QtQuick.Effects


Item {
    property string src
    property real radius: Math.min(width, height) / 2
    readonly property alias pressed: clickArea.pressed
    readonly property alias hovered: clickArea.containsMouse

    signal clicked()

    id: root

    Image {
        id: img
        anchors.fill: parent
        source: root.src
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    Rectangle {
        id: mask
        anchors.fill: parent
        radius: root.radius
        color: "white"
        layer.enabled: true
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: img
        maskEnabled: true
        maskSource: mask
        autoPaddingEnabled: false
    }

    MouseArea {
        id: clickArea
        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        containmentMask: QtObject {
            function contains(point: point): bool {
                const dx = point.x - clickArea.width / 2
                const dy = point.y - clickArea.height / 2
                const hitRadius = Math.min(
                    root.radius,
                    clickArea.width / 2,
                    clickArea.height / 2
                )

                return dx * dx + dy * dy <= hitRadius * hitRadius
            }
        }

        onClicked: root.clicked()
    }
}
