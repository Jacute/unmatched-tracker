import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker

Popup {
    property string title: ""
    property string message: ""
    property real fieldSpacing: 8
    property real controlHeight: Common.defaultFontSize * 3.8

    signal confirmed()

    id: root
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: Math.min(parent ? parent.width * 0.86 : 360, 360)
    height: confirmContent.implicitHeight
    padding: 0

    background: Rectangle {
        color: Common.secondary
        radius: Common.defaultRadius
        border.width: 1
        border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
    }

    contentItem: ColumnLayout {
        id: confirmContent
        spacing: root.fieldSpacing * 1.2

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: root.fieldSpacing
        }

        Text {
            Layout.fillWidth: true
            Layout.leftMargin: root.fieldSpacing * 1.8
            Layout.rightMargin: root.fieldSpacing * 1.8
            text: root.title
            color: Common.textColor
            font.pixelSize: Common.defaultFontSize * 1.12
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Text {
            Layout.fillWidth: true
            Layout.leftMargin: root.fieldSpacing * 1.8
            Layout.rightMargin: root.fieldSpacing * 1.8
            text: root.message
            color: Common.textSecondary
            font.pixelSize: Common.defaultFontSize * 0.9
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: root.fieldSpacing * 1.8
            Layout.rightMargin: root.fieldSpacing * 1.8
            Layout.bottomMargin: root.fieldSpacing * 1.8
            spacing: root.fieldSpacing

            Btn {
                Layout.fillWidth: true
                Layout.preferredHeight: root.controlHeight * 0.82
                radius: Common.defaultRadius
                text: qsTr("Cancel")
                fontSize: Common.defaultFontSize

                onClicked: root.close()
            }

            Btn {
                Layout.fillWidth: true
                Layout.preferredHeight: root.controlHeight * 0.82
                radius: Common.defaultRadius
                text: qsTr("Delete")
                fontSize: Common.defaultFontSize
                bgColor: Common.error
                bgColorPressed: Qt.lighter(Common.error, 1.15)
                borderWidth: 0

                onClicked: {
                    root.close()
                    root.confirmed()
                }
            }
        }
    }
}
