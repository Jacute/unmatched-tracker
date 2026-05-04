import QtQuick

import "../common"

Rectangle {
    id: root
    
    property alias text: pageName.text
    property alias fontSize: pageName.font.pixelSize

    height: parent.height * 0.05
    width: parent.width

    anchors.top: parent.top

    Text {
        id: pageName
        font.bold: true
        color: Common.textColor

        width: parent.width
        height: parent.height

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}