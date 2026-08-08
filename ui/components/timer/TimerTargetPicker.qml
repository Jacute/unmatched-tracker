pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import ".."

Popup {
    property var targets: []
    property bool flipped: false

    signal targetSelected(int participantIndex)

    id: root
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: Math.min(parent ? parent.width * 0.86 : 340, 340)
    height: pickerContent.implicitHeight + 24
    padding: 12

    background: Rectangle {
        color: Common.secondary
        radius: Common.defaultRadius
        border.width: 1
        border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
    }

    contentItem: ColumnLayout {
        id: pickerContent
        spacing: 8
        rotation: root.flipped ? 180 : 0

        Text {
            Layout.fillWidth: true
            text: qsTr("Choose defender")
            color: Common.textColor
            font.pixelSize: Common.defaultFontSize
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }

        Repeater {
            model: root.targets

            Button {
                required property var modelData

                id: targetButton
                Layout.fillWidth: true
                Layout.preferredHeight: 54

                background: Rectangle {
                    color: targetButton.down ? Common.accent : Common.primary
                    radius: Common.defaultRadius
                    border.width: 1
                    border.color: Common.imagePlaceholderSoft
                }

                contentItem: RowLayout {
                    spacing: 10

                    LoadImage {
                        Layout.preferredWidth: 42
                        Layout.preferredHeight: 42
                        imgPath: targetButton.modelData.imgPath
                        fillMode: Image.PreserveAspectCrop
                    }

                    Text {
                        Layout.fillWidth: true
                        text: targetButton.modelData.heroName
                        color: targetButton.down ? Common.primary : Common.textColor
                        font.pixelSize: Common.defaultFontSize
                        font.bold: true
                        elide: Text.ElideRight
                    }
                }

                onClicked: {
                    root.close()
                    root.targetSelected(modelData.participantIndex)
                }
            }
        }
    }

    function openFor(candidates, shouldFlip) {
        targets = candidates
        flipped = shouldFlip
        open()
    }
}
