import QtQuick
import QtQuick.Effects


Item {
    property string src
    property real radius: Math.min(width, height) / 2

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
}
