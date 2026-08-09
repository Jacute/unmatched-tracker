import QtQuick
import QtQuick.Layouts

import Tracker

Rectangle {
    property string heroName: ""
    property string timeText: "00:00"
    property int turnNumber: 1
    property bool paused: false
    property bool flipped: false

    signal pauseClicked()

    id: root
    implicitWidth: 154
    implicitHeight: 116
    color: Common.primary
    radius: Common.defaultRadius
    border.width: 1
    border.color: Common.shadow1
    rotation: flipped ? 180 : 0

    Behavior on rotation {
        NumberAnimation { duration: 180 }
    }

    ColumnLayout {
        anchors {
            fill: parent
            margins: 7
        }
        spacing: 1

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 28
            Layout.preferredHeight: 28
            radius: 14
            color: Common.secondary

            Text {
                anchors.centerIn: parent
                text: root.turnNumber
                color: Common.textColor
                font.pixelSize: Common.defaultFontSize
                font.bold: true
            }
        }

        Text {
            Layout.fillWidth: true
            text: root.heroName
            color: Common.textColor
            font.pixelSize: Common.defaultFontSize * 0.78
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }

        Text {
            Layout.fillWidth: true
            text: root.timeText
            color: root.paused ? Common.warning : Common.textColor
            font.pixelSize: Common.defaultFontSize * 1.34
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }

        Item {
            id: pauseButton
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 30
            Layout.preferredHeight: 24

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: pauseArea.pressed ? Common.accent : Common.secondary
            }

            Row {
                visible: !root.paused
                anchors.centerIn: parent
                spacing: 4

                Repeater {
                    model: 2

                    Rectangle {
                        required property int index
                        width: 3
                        height: 10
                        radius: 1
                        color: Common.textColor
                    }
                }
            }

            Canvas {
                anchors.centerIn: parent
                width: 10
                height: 12
                visible: root.paused

                onPaint: {
                    const ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.fillStyle = String(Common.textColor)
                    ctx.beginPath()
                    ctx.moveTo(1, 1)
                    ctx.lineTo(width - 1, height / 2)
                    ctx.lineTo(1, height - 1)
                    ctx.closePath()
                    ctx.fill()
                }
            }

            MouseArea {
                id: pauseArea
                anchors.fill: parent
                onClicked: root.pauseClicked()
            }
        }
    }
}
