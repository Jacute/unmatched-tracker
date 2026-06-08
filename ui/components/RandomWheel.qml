import QtQuick
import QtQuick.Timeline

import Tracker
import "./RandomWheel.js" as Wheel

Rectangle {
    property real rotateSpeed: 0
    property real wheelAngle: 0
    property var heroes: []
    property string cursor: Common.imgPrefix + "/ui/wheel_cursor.png"
    property var randomHero

    id: root
    radius: width / 2
    color: "transparent"

    Component.onCompleted: {
        for (let i = 0; i < heroes.length; i++) {
            canvas.loadImage(heroes[i].img_path)
        }
        canvas.requestPaint()
    }
    
    Canvas {
        id: canvas
        anchors.fill: parent
        anchors.centerIn: parent

        transform: Rotation {
            origin.x: canvas.width / 2
            origin.y: canvas.height / 2
            angle: root.wheelAngle * 180 / Math.PI
        }

        onPaint: {
            Wheel.draw(canvas, root);
        }

        onImageLoaded: requestPaint()
    }

    Image {
        id: cursor
        source: root.cursor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: sourceSize.width / 48
        height: sourceSize.height / 48
        anchors.topMargin: height / 3
    }

    MouseArea {
        property real startX: 0
        property real startY: 0
        property real startTime: 0
        property real endX: 0
        property real endY: 0
        property real endTime: 0
        
        id: swipeArea
        anchors.fill: parent

        onPressed: (mouse) => {
            startX = mouse.x
            startY = mouse.y
            startTime = Date.now()

            endX = 0
            endY = 0
            endTime = 0
        }

        onReleased: (mouse) => {
            if (root.rotateSpeed != 0) return

            endX = mouse.x
            endY = mouse.y
            endTime = Date.now()

            let deltaX = endX - swipeArea.startX
            let deltaY = endY - startY
            let deltaTime = (endTime - startTime) / 1000 // in seconds

            if (deltaTime <= 0 || (deltaX === 0 && deltaY === 0)) return

            // Distance in pixels
            let distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY)
            let rotateSpeed = distance / deltaTime
            if (deltaX < 0 || deltaY < 0) {
                rotateSpeed *= -1
            }

            if ((rotateSpeed > 0 && rotateSpeed < 50) ||
                (rotateSpeed < 0 && rotateSpeed > -50)
            ) {
                console.debug(`Low speed: ${rotateSpeed.toFixed(2)}`)
                // check for low speed swipe
                return    
            }

            root.rotateSpeed = rotateSpeed
            console.debug(`Speed: ${root.rotateSpeed.toFixed(2)} px/s, distance: ${distance.toFixed(2)} px, time: ${(deltaTime*1000).toFixed(0)} ms`)
            wheelAnimation.running = true
        }
    }

    FrameAnimation {
        id: wheelAnimation
        running: false

        onTriggered: () => {
            const terminator = 0.8
            const dt = 1 / 60
            if (Math.abs(root.rotateSpeed) > terminator) {
                root.wheelAngle += (root.rotateSpeed * dt / 180) * Math.PI
                root.wheelAngle %= Math.PI * 2

                root.rotateSpeed *= 0.98
            } else {
                root.rotateSpeed = 0
                running = false

                root.randomHero = Wheel.getWinHero(
                    root.wheelAngle,
                    root.heroes
                )
            }
        }
    }

    Image {
        id: cursorImg
        source: root.cursor
        visible: false
    }

    function paint() {
        canvas.requestPaint()
    }
}