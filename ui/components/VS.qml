import QtQuick
import QtQuick.Layouts

import Tracker
import Render

Rectangle {
    id: root

    property string hero1AvatarPath: Common.avatarPlug
    property string hero2AvatarPath: Common.avatarPlug
    property string resolvedHero1AvatarUrl: ""
    property string resolvedHero2AvatarUrl: ""
    property alias textColor: vs.color

    radius: 20
    color: Common.secondary

    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
    border.width: 1

    implicitWidth: vsLayout.implicitWidth + 28
    implicitHeight: vsLayout.implicitHeight + 24

    RowLayout {
        id: vsLayout

        anchors.centerIn: parent
        spacing: 18

        ImageRounded {
            id: hero1
            src: root.resolvedHero1AvatarUrl
            Layout.preferredWidth: 120
            Layout.preferredHeight: 120
        }

        Text {
            id: vs
            text: "VS"

            font.pixelSize: Common.defaultFontSize * 1.8
            font.bold: true
            opacity: 0.9
        }

        ImageRounded {
            id: hero2
            src: root.resolvedHero2AvatarUrl
            Layout.preferredWidth: 120
            Layout.preferredHeight: 120
        }
    }

    Connections {
        target: core

        function onImageReady(path, sourceUrl) {
            if (path === root.hero1AvatarPath) {
                root.resolvedHero1AvatarUrl = sourceUrl
            }
            if (path === root.hero2AvatarPath) {
                root.resolvedHero2AvatarUrl = sourceUrl
            }
        }

        function onImageFailed(path) {
            if (path === root.hero1AvatarPath) {
                root.resolvedHero1AvatarUrl = ""
            }
            if (path === root.hero2AvatarPath) {
                root.resolvedHero2AvatarUrl = ""
            }
        }
    } 

    Component.onCompleted: loadData()
    onHero1AvatarPathChanged: loadHero1Avatar()
    onHero2AvatarPathChanged: loadHero2Avatar()

    function loadData() {
        loadHero1Avatar()
        loadHero2Avatar()
    }

    function loadHero1Avatar() {
        loadImage(hero1AvatarPath)
    }

    function loadHero2Avatar() {
        loadImage(hero2AvatarPath)
    }  

    function loadImage(path) {
        if (path.length > 0) {
            core.requestImage(path)
        }
    }
}
