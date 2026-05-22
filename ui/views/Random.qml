import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.primary
    property var hero1: ({
        img: Common.avatarPlug
    })
    property var hero2: ({
        img: Common.avatarPlug
    })

    ColumnLayout {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.width
        height: root.height
        spacing: 10

        VS {
            id: vs
            src1: root.hero1.img
            src2: root.hero2.img
            color: "transparent"
            textColor: Common.textColor

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        // game map
        GameMap {
            src: Common.imgPrefix + "/set/cobble_fog/maps/baskerville.webp"
            color: "transparent"
            Layout.preferredHeight: root.height * 0.2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        // button for save game results
        Button {
            id: saveBtn
            Layout.preferredHeight: root.height * 0.05
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "Сохранить результаты"
            font.pixelSize: Common.defaultFontSize

            background: Rectangle {
                id: saveBtnBg
                color: Common.secondary
                radius: Common.defaultRadius
            }
        }

        RandomWheel {
            id: rw
            Layout.preferredWidth: root.width
            Layout.preferredHeight: root.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            onRandomHeroChanged: {
                if (root.hero1.img === Common.avatarPlug) {
                    console.debug("[Random] new hero1 " + randomHero.name)
                    root.hero1 = randomHero
                    return
                }
                if (root.hero2.img === Common.avatarPlug) {
                    console.debug("[Random] new hero2 " + randomHero.name)
                    root.hero2 = randomHero
                    return
                }
                root.hero1 = randomHero
                root.hero2 = {
                    img: Common.avatarPlug
                }
            }
        }
    }
}