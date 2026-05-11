import QtQuick

import Tracker
import "./RandomWheel.js" as Wheel

Rectangle {
    id: root
    radius: width / 2
    color: "transparent"

    property real startX: 0
    property real startY: 0
    property real startTime: 0
    property real endX: 0
    property real endY: 0
    property real endTime: 0

    property var heroes: [
        {
            name: "Дракула",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("dracula")
        },
        {
            name: "Шерлок Холмс",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("sherlock_holmes")
        },
        {
            name: "Джекил и Хайд",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("jekyll_hyde")
        },
        {
            name: "Невидимка",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("invisible_man")
        },
        {
            name: "Медуза",
            img: qsTr(Common.heroAvatarFormat).arg("battle_of_legends1").arg("medusa")
        },
    ]
    
    Canvas {
        id: canvas
        anchors.fill: parent
        anchors.centerIn: parent

        onPaint: {
            Wheel.draw(canvas, root.heroes);
        }

        Component.onCompleted: {
            for (var i = 0; i < parent.heroes.length; i++) {
                loadImage(parent.heroes[i].img)
            }
        }

        onImageLoaded: {
            requestPaint()
        }
    }

    MouseArea {
        anchors.fill: parent

        onPressed: (mouse) => {
            root.startX = mouse.x
            root.startY = mouse.y
            root.startTime = Date.now()
            // Сброс конечных данных
            root.endX = 0
            root.endY = 0
            root.endTime = 0
        }

        onReleased: (mouse) => {
            root.endX = mouse.x
            root.endY = mouse.y
            root.endTime = Date.now()

            // Расчёт скорости
            let deltaX = root.endX - root.startX
            let deltaY = root.endY - root.startY
            let deltaTime = (root.endTime - root.startTime) / 1000 // в секундах

            if (deltaTime <= 0 || (deltaX === 0 && deltaY === 0)) return

            // Расстояние в пикселях
            let distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY)
            let speed = distance / deltaTime // пикселей/сек

            // Определение направления свайпа
            let direction = ""
            if (Math.abs(deltaX) > Math.abs(deltaY)) {
                direction = deltaX > 0 ? "right" : "left"
            } else {
                direction = deltaY > 0 ? "down" : "up"
            }

            console.log(`Swipe: ${direction}, speed: ${speed.toFixed(2)} px/s, distance: ${distance.toFixed(2)} px, time: ${(deltaTime*1000).toFixed(0)} ms`)

            root.processSwipe(direction, speed, distance)
        }
    }

    function processSwipe(direction, speed, distance) {
        if (speed > 500) {
            console.log("Fast swipe detected!")
        }
    }
}