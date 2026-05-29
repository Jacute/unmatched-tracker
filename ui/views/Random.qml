import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    id: root
    color: Qt.darker(Common.primary, 1.15)

    property var hero1: Common.plugHero
    property var hero2: Common.plugHero

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: root.height * 0.02
        spacing: root.height * 0.02

        VS {
            id: vs
            src1: root.hero1.img
            src2: root.hero2.img
            textColor: Common.textColor

            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.height * 0.18
            Layout.preferredWidth: gm.implicitWidth
            color: "transparent"

            GameMap {
                id: gm
                visible: false
                anchors.fill: parent
            }

            Btn {
                id: rndMap
                anchors.fill: parent
                radius: 0
                text: "Случайная карта"

                onClicked: {
                    gm.src = Common.maps[Math.floor(Math.random() * Common.maps.length)].img
                    gm.visible = true
                    rndMap.visible = false
                }
            }
        }

        Btn {
            id: saveBtn

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.65
            Layout.preferredHeight: root.height * 0.05

            text: "Сохранить результаты"
        }

        Rectangle {
            id: delimiter
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.001
            color: Common.secondary
        }

        RandomWheel {
            id: rw

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            heroes: Common.heroes

            onRandomHeroChanged: {
                if (root.hero1.img === Common.avatarPlug) {
                    root.hero1 = randomHero
                    rw.heroes = rw.heroes.filter(obj => obj.id != randomHero.id)
                    rw.paint()
                    return
                }

                if (root.hero2.img === Common.avatarPlug) {
                    root.hero2 = randomHero
                    rw.heroes = Common.heroes
                    rw.paint()
                    return
                }

                root.hero1 = randomHero
                rw.heroes = rw.heroes.filter(obj => obj.id != randomHero.id)
                root.hero2 = Common.plugHero
                rw.paint()
            }
        }
    }
}