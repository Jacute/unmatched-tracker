import QtQuick
import QtQuick.Layouts

import Tracker
import "../info" as Info

Rectangle {
    property string title: ""
    property string description: ""
    property string value: ""
    property string detail: ""
    property color accentColor: Common.accent

    id: root
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
        spacing: Common.fieldSpacing

        RowLayout {
            width: parent.width
            Text {
                Layout.alignment: Qt.AlignTop
                text: root.title
                color: Common.textSecondary
                font.pixelSize: 12
                font.bold: true
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }
            Item {
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignTop

                Info.Tooltip {
                    anchors.fill: parent
                    visible: root.description !== ""
                    description: root.description
                }
            }
        }

        Text {
            width: parent.width
            text: root.value
            color: Common.textColor
            font.pixelSize: 26
            font.bold: true
            elide: Text.ElideRight
        }

        Text {
            width: parent.width
            visible: text.length > 0
            text: root.detail
            color: Common.textHint
            font.pixelSize: 11
            elide: Text.ElideRight
        }
    }
}
