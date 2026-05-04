pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window

import "../common"
import "../components"

Rectangle {
    id: root

    readonly property string setImgPrefix: qsTr("../%1/set").arg(Common.imgPrefix)
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"

    readonly property int headerFontPixelSize: width / 20

    color: Common.background

    Header {
        text: "Наборы персонажей"
        fontSize: parent.headerFontPixelSize
    }

    // grid of addons
    GridView {
        id: rootGrid
        
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: root.height * 0.06
            leftMargin: root.width * 0.05
            rightMargin: root.width * 0.05
            bottomMargin: root.height * 0.05
        }
    
        cellWidth: (width - (leftMargin + rightMargin)) * 0.5
        cellHeight: cellWidth * 1.4
        
        clip: true

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
            }
        ]

        delegate: Item {
            required property var modelData

            width: rootGrid.cellWidth
            height: rootGrid.cellHeight

            Card {
                cardName: parent.modelData.name
                cardImg: parent.modelData.img
                width: rootGrid.cellWidth
                height: rootGrid.cellHeight
                color: root.color
                fontSize: parent.height * 0.05
                margin: parent.height * 0.05
            }
        }
    }
}
