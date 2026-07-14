import QtQuick

import Tracker
import "./RandomWheel.js" as Wheel

Rectangle {
    property real rotateSpeed: 0
    property real wheelAngle: 0
    property var heroes: [] // got from api
    property var imageUrls: ({}) // map with key - imgPath, value - imgUrl
    property var requestedImagePaths: ({}) // map with image requests to cache, key - imgPath, value - request is active
    property string cursor: Common.imgPrefix + "/ui/wheel_cursor.png"
    property var randomHero

    property color placeholderColor: Common.imagePlaceholder
    property color placeholderSoftColor: Common.imagePlaceholderSoft
    property color sectorBorderColor: Common.textColor
    property color sectorTextColor: Common.textColor

    id: root
    color: "transparent"

    onHeroesChanged: requestHeroImages()

    Canvas {
        id: canvas
        anchors.centerIn: root
        renderStrategy: Canvas.Threaded
        
        Component.onCompleted: {
            const size = Math.min(root.width, root.height)
            canvas.width = size
            canvas.height = size
            canvas.requestPaint()
        }

        transform: [
            Rotation {
                origin.x: canvas.width / 2
                origin.y: canvas.height / 2
                angle: root.wheelAngle * 180 / Math.PI
            },
            Scale {
                origin.x: canvas.width / 2
                origin.y: canvas.height / 2
                xScale: Math.min(root.width / canvas.width, root.height / canvas.height)
                yScale: Math.min(root.width / canvas.width, root.height / canvas.height)
            }
        ]
    

        onPaint: {
            Wheel.draw(canvas, root);
        }

        onImageLoaded: {
            requestPaint()
        }
    }

    Image {
        id: cursor
        source: root.cursor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: sourceSize.width / 48
        height: sourceSize.height / 48
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

                if (root.heroes.length > 0) {
                    root.randomHero = Wheel.getWinHero(
                        root.wheelAngle,
                        root.heroes
                    )
                }
            }
        }
    }

    Connections {
        target: core

        function onImageReady(path, sourceUrl) {
            if (root.requestedImagePaths[path] !== true) {
                return
            }

            root.requestedImagePaths[path] = false
            root.imageUrls[path] = sourceUrl
            canvas.loadImage(sourceUrl)
        }

        function onImageFailed(path) {
            if (root.requestedImagePaths[path] !== true) {
                return
            }

            root.requestedImagePaths[path] = false
            console.error("[RandomWheel] image " + path + " not loaded")
        }
    }

    Component.onCompleted: requestHeroImages()

    function requestHeroImages() {
        for (let i = 0; i < root.heroes.length; i++) {
            const path = root.heroes[i].img_path
            if (!path) {
                continue
            }

            const sourceUrl = root.imageUrls[path] || ""
            if (sourceUrl) {
                if (!canvas.isImageLoaded(sourceUrl)) {
                    canvas.loadImage(sourceUrl)
                }
                continue
            }

            if (root.requestedImagePaths[path] === true) {
                continue
            }

            root.requestedImagePaths[path] = true
            core.requestImage(path)
        }
    }

    function paint () {
        canvas.requestPaint()
    }
}
