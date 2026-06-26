import QtQuick


Image {
    property string resolvedCardImg: ""
    property string imgPath: ""
    property string sourceUrl: ""
    readonly property bool placeholderVisible: resolvedCardImg.length === 0 || status === Image.Loading

    id: root
    source: resolvedCardImg
    asynchronous: true

    ImagePlaceholder {
        anchors.fill: parent
        visible: root.placeholderVisible
        radius: 0
    }

    Component.onCompleted: loadImage()
    onImgPathChanged: loadImage()
    onSourceUrlChanged: loadImage()

    function loadImage() {
        if (sourceUrl.length > 0) {
            resolvedCardImg = sourceUrl
            return
        }
        resolvedCardImg = ""
        if (imgPath.length > 0) {
            core.requestImage(imgPath)
        }
    }

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
