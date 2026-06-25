import QtQuick


Image {
    property string resolvedCardImg: ""
    property string imgPath: ""

    id: root
    source: resolvedCardImg
    asynchronous: true

    function loadImage() {
        resolvedCardImg = ""
        if (imgPath.length > 0) {
            core.requestImage(imgPath)
        }
    }

    Component.onCompleted: loadImage()
    onImgPathChanged: loadImage()

    Connections {
        target: core

        function onImageReady(path, sourceUrl) {
            if (path === root.imgPath) {
                root.resolvedCardImg = sourceUrl
            }
        }

        function onImageFailed(path) {
            if (path === root.imgPath) {
                root.resolvedCardImg = ""
            }
        }
    }   
}