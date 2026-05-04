import QtQuick

import "../common"

Rectangle {
    property string text: ""
    property alias fontSize: pageName.font.pixelSize

    height: parent.height * 0.05
    width: parent.width
    color: "red"

    anchors.top: parent.top

    Text {
        id: pageName
        text: qsTr("<b>%1</b>").arg(text)
        color: Common.textColor

        width: parent.width
        anchors.margins: 10

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}