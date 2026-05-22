import QtQuick

Rectangle {
    property alias src: img.source
    property real aspectRatio: 1.5

    implicitHeight: height
    implicitWidth: implicitHeight * aspectRatio

    id: root

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }
}