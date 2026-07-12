import QtQuick
import QtQuick.Window


Image {
    property string resolvedCardImg: ""
    property string imgPath: ""
    property string sourceUrl: ""
    property string decodeSizePath: ""
    property int decodeWidth: 0
    property int decodeHeight: 0
    readonly property bool placeholderVisible: resolvedCardImg.length === 0 || status === Image.Loading

    id: root
    source: resolvedCardImg
    asynchronous: true
    cache: true
    sourceSize.width: decodeWidth
    sourceSize.height: decodeHeight

    ImagePlaceholder {
        anchors.fill: parent
        visible: root.placeholderVisible
        radius: 0
    }

    Component.onCompleted: Qt.callLater(loadImage)
    onImgPathChanged: {
        decodeSizePath = ""
        Qt.callLater(loadImage)
    }
    onSourceUrlChanged: loadImage()

    function loadImage() {
        captureDecodeSize()
        if (sourceUrl.length > 0) {
            resolvedCardImg = sourceUrl
            return
        }
        resolvedCardImg = ""
        if (imgPath.length > 0) {
            core.requestImage(imgPath)
        }
    }

    function captureDecodeSize() {
        if (decodeSizePath === imgPath && decodeWidth > 0 && decodeHeight > 0) {
            return
        }

        decodeSizePath = imgPath
        decodeWidth = width > 0 ? Math.ceil(width * Screen.devicePixelRatio) : 0
        decodeHeight = height > 0 ? Math.ceil(height * Screen.devicePixelRatio) : 0
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
