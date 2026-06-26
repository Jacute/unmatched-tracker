import QtQuick

Rectangle {
    id: root

    property alias imgPath: img.imgPath
    property alias sourceUrl: img.sourceUrl
    property real aspectRatio: 1.6

    implicitHeight: height
    implicitWidth: implicitHeight * aspectRatio

    LoadImage {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }
}
