import QtQuick

import Tracker
import ".."

Rectangle {
    required property string heroName
    required property string imgPath

    property bool active: false
    property bool flipped: false
    property color markerColor: Common.accent

    id: root
    color: Common.primary
    clip: true

    LoadImage {
        anchors.fill: parent
        imgPath: root.imgPath.length > 0 ? root.imgPath : Common.avatarPlug
        fillMode: Image.PreserveAspectCrop
        rotation: root.flipped ? 180 : 0
        opacity: root.active ? 1.0 : 0.3

        Behavior on opacity {
            NumberAnimation { duration: 180 }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: root.active ? 3 : 1
        border.color: root.active ? root.markerColor : Common.shadow2
    }
}
