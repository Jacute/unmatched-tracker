import QtQuick

Rectangle {
    id: root

    property alias src: img.source
    property real aspectRatio: 1.6

    implicitHeight: height
    implicitWidth: implicitHeight * aspectRatio

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }
}