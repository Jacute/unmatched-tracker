import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    id: root
    color: Qt.darker(Common.primary, 1.15)

    property var hero1: ({
        img: Common.avatarPlug
    })

    property var hero2: ({
        img: Common.avatarPlug
    })

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

        GameMap {
            src: Common.imgPrefix + "/set/cobble_fog/maps/baskerville.webp"

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.height * 0.18
        }

        Button {
            id: saveBtn

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.65
            Layout.preferredHeight: root.height * 0.05

            text: "Сохранить результаты"

            font.pixelSize: Common.defaultFontSize
            font.bold: true

            background: Rectangle {
                radius: saveBtn.height
                color: saveBtn.pressed
                    ? Qt.darker(Common.secondary, 1.2)
                    : Common.secondary

                border.color: Qt.lighter(Common.secondary, 1.25)
                border.width: 1

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }
            }
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

            onRandomHeroChanged: {
                if (root.hero1.img === Common.avatarPlug) {
                    root.hero1 = randomHero
                    return
                }

                if (root.hero2.img === Common.avatarPlug) {
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