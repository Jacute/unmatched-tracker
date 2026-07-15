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
    signal profileSelectionChanged

    readonly property int profileIndex: profileSelect.currentIndex
    readonly property int heroIndex: heroSelect.currentIndex
    readonly property int profileId: root.modelId(profileOptions, profileIndex)
    readonly property int heroId: root.modelId(heroOptions, heroIndex)
    readonly property string profileName: root.modelName(profileOptions, profileIndex)

    implicitHeight: content.implicitHeight + Common.defaultFontSize * 0.8
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

    RowLayout {
        id: content
        anchors {
            fill: parent
            leftMargin: Common.defaultFontSize * 0.7
            rightMargin: Common.defaultFontSize * 0.55
            topMargin: Common.defaultFontSize * 0.4
            bottomMargin: Common.defaultFontSize * 0.4
        }
        spacing: 6

        Text {
            Layout.preferredWidth: content.width * 0.12
            text: root.title
            color: Common.textSecondary
            font.pixelSize: Common.defaultFontSize * 0.86
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
        }

        FieldBox {
            Layout.fillWidth: true
            label: qsTr("Profile")

            ThemedComboBox {
                id: profileSelect
                anchors.fill: parent
                popupWidth: width * 1.5
                model: root.profileOptions
                textRole: "name"

                onCurrentIndexChanged: root.profileSelectionChanged()
            }
        }

        FieldBox {
            Layout.fillWidth: true
            label: qsTr("Hero")

            ThemedComboBox {
                id: heroSelect
                anchors.fill: parent
                popupWidth: width * 1.5
                model: root.heroOptions
                textRole: "name"

                onActivated: hpInput.text = ""
            }
        }

        FieldBox {
            Layout.preferredWidth: parent.width * 0.1
            label: qsTr("HP")

            TextField {
                id: hpInput
                anchors.fill: parent
                color: Common.textColor
                placeholderText: ""
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
            return { valid: true, specified: false, value: null }
        }
        if (!hpInput.acceptableInput || !/^\d+$/.test(value)) {
            return {
                valid: false,
                error: qsTr("%1: HP must be between 0 and %2")
                    .arg(root.title)
                    .arg(root.selectedHeroHp())
            }
        }
        return { valid: true, specified: true, value: parseInt(value, 10) }
    }

    function clear() {
        profileSelect.currentIndex = -1
        heroSelect.currentIndex = -1
        hpInput.text = ""
    }

    function selectHeroById(heroId) {
        heroSelect.currentIndex = -1
        for (let i = 0; i < heroOptions.count; ++i) {
            if (heroOptions.get(i).id === heroId) {
                heroSelect.currentIndex = i
                break
            }
        }
        hpInput.text = ""
    }
}
