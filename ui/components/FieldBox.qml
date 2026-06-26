import QtQuick
import QtQuick.Layouts

import Tracker

Rectangle {
    property string label: ""
    property real boxHeight: Common.defaultFontSize * 3.8
    default property alias content: contentItem.data

    Layout.preferredHeight: boxHeight
    color: Common.primary
    radius: Common.defaultRadius
    border.width: 1
    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

    Text {
        anchors {
            left: parent.left
            leftMargin: 12
            top: parent.top
            topMargin: 7
        }
        text: parent.label
        color: Common.textHint
        font.pixelSize: Common.defaultFontSize * 0.76
        font.bold: true
    }

    Item {
        id: contentItem
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: parent.top
            leftMargin: 12
            rightMargin: 10
            topMargin: Common.defaultFontSize * 1.25
            bottomMargin: 6
        }
    }
}
