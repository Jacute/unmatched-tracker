import QtQuick

import Tracker

Rectangle {
    property string title: ""
    property string value: ""
    property string detail: ""
    property color accentColor: Common.accent

    implicitHeight: 106
    color: Common.primary
    radius: 8
    border.width: 1
    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

    Rectangle {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: 4
        color: parent.accentColor
        radius: 2
    }

    Column {
        anchors {
            fill: parent
            leftMargin: 13
            rightMargin: 8
            topMargin: 9
            bottomMargin: 8
        }
        spacing: 2

        Text {
            width: parent.width
            text: parent.parent.title
            color: Common.textSecondary
            font.pixelSize: 12
            font.bold: true
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide: Text.ElideRight
        }

        Text {
            width: parent.width
            text: parent.parent.value
            color: Common.textColor
            font.pixelSize: 26
            font.bold: true
            elide: Text.ElideRight
        }

        Text {
            width: parent.width
            visible: text.length > 0
            text: parent.parent.detail
            color: Common.textHint
            font.pixelSize: 11
            elide: Text.ElideRight
        }
    }
}
