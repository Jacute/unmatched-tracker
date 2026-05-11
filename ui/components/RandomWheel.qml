import QtQuick

import Tracker

Rectangle {
    id: root
    radius: width / 2
    color: "transparent"

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
        anchors.fill: parent
        anchors.centerIn: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var cx = width / 2
            var cy = height / 2
            var radius = Math.min(width, height) / 2 - 10

            var step = 2 * Math.PI / parent.heroes.length
            for (var i = 0; i < parent.heroes.length; i++) {
                var imgSrc = parent.heroes[i].img
                if (!isImageLoaded(imgSrc))
                    return

                var start = i * step
                var end = start + step
                var mid = (start + end) / 2

                ctx.save()

                // --- sector ---
                ctx.beginPath()
                ctx.moveTo(cx, cy)
                ctx.arc(cx, cy, radius, start, end)
                ctx.closePath()
                ctx.clip()

                // =========================
                // 1) Phone
                // =========================
                ctx.globalAlpha = 0.25

                ctx.drawImage(
                    imgSrc,
                    cx - radius * 1.2,
                    cy - radius * 1.2,
                    radius * 2.4,
                    radius * 2.4
                )

                ctx.globalAlpha = 1.0

                // =========================
                // 2) Icon in center
                // =========================
                var iconSize = radius * (0.8 - 0.05 * parent.heroes.length)

                var x = cx + radius * 0.5 * Math.cos(mid) - iconSize / 2
                var y = cy + radius * 0.5 * Math.sin(mid) - iconSize / 2

                ctx.drawImage(
                    imgSrc,
                    x,
                    y,
                    iconSize,
                    iconSize
                )

                ctx.restore()

                // sector border
                ctx.beginPath()
                ctx.moveTo(cx, cy)
                ctx.arc(cx, cy, radius, start, end)
                ctx.closePath()

                ctx.strokeStyle = "white"
                ctx.lineWidth = 2
                ctx.stroke()
            }
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
}