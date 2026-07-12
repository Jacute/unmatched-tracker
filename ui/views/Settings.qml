import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    id: root

    property bool exportSucceeded: false

    color: Common.bgColor

    ColumnLayout {
        anchors {
            fill: parent
            margins: root.width * 0.05
        }
        spacing: Common.defaultFontSize

        Text {
            Layout.fillWidth: true
            text: qsTr("Data")
            color: Common.textColor
            font.pixelSize: Common.defaultFontSize * 1.35
            font.bold: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Common.secondary
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Common.defaultFontSize

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 3

                Text {
                    Layout.fillWidth: true
                    text: qsTr("Database backup")
                    color: Common.textColor
                    font.pixelSize: Common.defaultFontSize
                    font.bold: true
                }

                Text {
                    Layout.fillWidth: true
                    text: qsTr("app.db")
                    color: Common.textHint
                    font.pixelSize: Common.defaultFontSize * 0.86
                }
            }

            Btn {
                Layout.preferredWidth: Math.min(root.width * 0.38, 180)
                Layout.preferredHeight: Common.defaultFontSize * 3.4
                radius: Common.defaultRadius
                text: qsTr("Export")
                fontSize: Common.defaultFontSize

                onClicked: {
                    statusText.text = ""
                    exportDialog.open()
                }
            }
        }

        Text {
            id: statusText

            Layout.fillWidth: true
            visible: text.length > 0
            color: root.exportSucceeded ? Common.success : Common.error
            font.pixelSize: Common.defaultFontSize
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Item {
            Layout.fillHeight: true
        }
    }

    FileDialog {
        id: exportDialog

        title: qsTr("Export database")
        fileMode: FileDialog.SaveFile
        currentFolder: StandardPaths.writableLocation(StandardPaths.DownloadLocation)
        currentFile: currentFolder + "/app.db"
        nameFilters: [qsTr("SQLite database (*.db)")]
        defaultSuffix: "db"

        onAccepted: {
            const result = core.exportDb(selectedFile)
            root.exportSucceeded = result.ok
            statusText.text = result.ok
                ? qsTr("Database exported successfully")
                : qsTr("Database export failed: %1").arg(result.error)
        }
    }
}
