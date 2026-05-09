pragma ComponentBehavior: Bound

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import Tracker
import "../components"

Rectangle {
    readonly property string setImgPrefix: Common.imgPrefix + "/set"
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"

    id: root
    color: Common.primary

    Menu {
        id: menu
        width: parent.width * 0.7
        height: parent.height
    }
    Header {
        id: hdr
        text: "Наборы персонажей"
        onMenuClicked: {
            // console.log("menu opened")
            menu.open()
        }
    }

    // grid of addons
    ScrollView {
        readonly property int viewSpacing: 15

        id: view
        anchors {
            top: hdr.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        clip: true
        contentWidth: availableWidth
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        Flow {
            id: flow
            anchors.centerIn: parent
            width: parent.width - parent.height * 0.03
            spacing: view.viewSpacing

            topPadding: height * 0.01
            bottomPadding: topPadding
            leftPadding: 0
            rightPadding: 0

            Repeater {
                model: [
                    {
                        name: "Битва Легенд: Том 1",
                        img: qsTr("%1/battle_of_legends1/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Битва Легенд: Том 2",
                        img: qsTr("%1/battle_of_legends2/cover_eng.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Туман над мостовой",
                        img: qsTr("%1/cobble_fog/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Робингуд VS Бигфут",
                        img: qsTr("%1/robingood_vs_bigfoot/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Робингуд VS Бигфут",
                        img: qsTr("%1/robingood_vs_bigfoot/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Робингуд VS Бигфут",
                        img: qsTr("%1/robingood_vs_bigfoot/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Робингуд VS Бигфут",
                        img: qsTr("%1/robingood_vs_bigfoot/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                    {
                        name: "Робингуд VS Бигфут",
                        img: qsTr("%1/robingood_vs_bigfoot/cover_ru.jpg").arg(root.setImgPrefix)
                    },
                ]

                delegate: Item {
                    id: item
                    required property var modelData

                    width: (flow.width - flow.spacing) / 2
                    height: width * 1.4

                    Card {
                        width: parent.width
                        height: parent.height
                        cardName: parent.modelData.name
                        cardImg: parent.modelData.img
                        fontSize: height * 0.05
                    }
                }
            }
        }
    }
}
