import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker

Rectangle {
    id: root

    required property var profileOptions
    required property var heroOptions
    property string title: ""
    property color markerColor: Common.accent

    readonly property int profileIndex: profileSelect.currentIndex
    readonly property int heroIndex: heroSelect.currentIndex
    readonly property int profileId: root.modelId(profileOptions, profileIndex)
    readonly property int heroId: root.modelId(heroOptions, heroIndex)
    readonly property string profileName: root.modelName(profileOptions, profileIndex)

    implicitHeight: content.implicitHeight + Common.defaultFontSize * 1.2
    color: Common.secondary
    radius: Common.defaultRadius
    border.width: 1
    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

    Rectangle {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: 4
        }
        width: 3
        radius: 2
        color: root.markerColor
    }

    ColumnLayout {
        id: content
        anchors {
            fill: parent
            leftMargin: Common.defaultFontSize * 0.8
            rightMargin: Common.defaultFontSize * 0.55
            topMargin: Common.defaultFontSize * 0.55
            bottomMargin: Common.defaultFontSize * 0.55
        }
        spacing: 6

        Text {
            Layout.fillWidth: true
            text: root.title
            color: Common.textSecondary
            font.pixelSize: Common.defaultFontSize
            font.bold: true
            horizontalAlignment: Text.AlignLeft
        }

        FieldBox {
            Layout.fillWidth: true
            label: qsTr("Profile")

            ThemedComboBox {
                id: profileSelect
                anchors.fill: parent
                model: root.profileOptions
                textRole: "name"
            }
        }

        FieldBox {
            Layout.fillWidth: true
            label: qsTr("Hero")

            ThemedComboBox {
                id: heroSelect
                anchors.fill: parent
                model: root.heroOptions
                textRole: "name"

                onActivated: hpInput.text = ""
            }
        }

        FieldBox {
            Layout.fillWidth: true
            label: qsTr("Remaining HP")

            TextField {
                id: hpInput
                anchors.fill: parent
                color: Common.textColor
                placeholderText: activeFocus || text !== "" ? "" : qsTr("Optional")
                placeholderTextColor: Common.textHint
                selectionColor: Common.accent
                selectedTextColor: Common.primary
                font.pixelSize: Common.defaultFontSize
                padding: 0
                enabled: root.heroIndex !== -1
                validator: IntValidator {
                    bottom: 0
                    top: root.selectedHeroHp()
                }
                inputMethodHints: Qt.ImhDigitsOnly
                background: null
                verticalAlignment: TextInput.AlignVCenter
            }
        }
    }

    function modelId(model, index) {
        if (index < 0 || index >= model.count) {
            return 0
        }
        return model.get(index).id
    }

    function modelName(model, index) {
        if (index < 0 || index >= model.count) {
            return ""
        }
        return model.get(index).name
    }

    function selectedHeroHp() {
        if (heroIndex < 0 || heroIndex >= heroOptions.count) {
            return 0
        }
        return heroOptions.get(heroIndex).hp
    }

    function hpResult() {
        const value = hpInput.text.trim()
        if (value.length === 0) {
            return { valid: true, value: 0 }
        }
        if (!hpInput.acceptableInput || !/^\d+$/.test(value)) {
            return {
                valid: false,
                error: qsTr("%1: HP must be between 0 and %2")
                    .arg(root.title)
                    .arg(root.selectedHeroHp())
            }
        }
        return { valid: true, value: parseInt(value, 10) }
    }

    function clear() {
        profileSelect.currentIndex = -1
        heroSelect.currentIndex = -1
        hpInput.text = ""
    }
}
