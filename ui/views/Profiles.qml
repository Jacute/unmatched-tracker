pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.bgColor

    ColumnLayout {
        anchors {
            fill: parent
            margins: parent.width * 0.04
        }
        spacing: parent.height * 0.02

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: profileNameInput.font.pixelSize * 3
                color: Common.primary
                radius: Common.defaultRadius
                border.width: 1
                border.color: Qt.lighter(Common.secondary, 1.25)

                TextField {
                    id: profileNameInput
                    anchors {
                        fill: parent
                        leftMargin: 12
                        rightMargin: 12
                    }
                    color: Common.textColor
                    selectionColor: Common.accent
                    selectedTextColor: Common.primary
                    placeholderText: "Имя игрока"
                    placeholderTextColor: Common.textHint
                    font.pixelSize: Common.defaultFontSize
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    background: null

                    onAccepted: root.createProfile()
                }
            }

            Btn {
                Layout.preferredWidth: root.width * 0.2
                Layout.preferredHeight: root.height * 0.05
                radius: Common.defaultRadius
                text: "Добавить"
                fontSize: Common.defaultFontSize
                onClicked: root.createProfile()
            }
        }

        Text {
            id: statusText
            Layout.fillWidth: true
            visible: text.length > 0
            color: Common.warning
            font.pixelSize: Common.defaultFontSize
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Common.secondary
        }

        ListView {
            id: profilesList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: profilesModel
            spacing: 8

            delegate: Rectangle {
                required property string name
                required property int id

                width: profilesList.width
                height: Math.max(root.height * 0.065, 48)
                color: Common.secondary
                radius: Common.defaultRadius
                border.width: 1
                border.color: Qt.lighter(Common.secondary, 1.18)

                Text {
                    anchors {
                        left: parent.left
                        right: deleteBtn.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: 14
                        rightMargin: 8
                    }
                    text: name
                    color: Common.textColor
                    font.pixelSize: Common.defaultFontSize
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }

                Btn {
                    id: deleteBtn
                    anchors {
                        right: parent.right
                        rightMargin: 8
                        verticalCenter: parent.verticalCenter
                    }
                    width: Math.min(parent.height * 0.72, 40)
                    height: width
                    radius: width / 2
                    text: "×"
                    fontSize: height * 0.55
                    bgColor: Common.error
                    bgColorPressed: Qt.lighter(Common.error, 1.15)
                    borderWidth: 0
                    txtColor: Common.textColor

                    onClicked: root.deleteProfile(id)
                }
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: profilesModel.count === 0
            text: "Профилей пока нет"
            color: Common.textHint
            font.pixelSize: Common.defaultFontSize
            horizontalAlignment: Text.AlignHCenter
        }
    }

    ListModel {
        id: profilesModel
    }

    Component.onCompleted: loadProfiles()

    function loadProfiles() {
        profilesModel.clear()
        const profiles = backend.getProfiles()
        for (let i = 0; i < profiles.length; i++) {
            profilesModel.append({
                id: profiles[i].id,
                name: profiles[i].name,
                created_at: profiles[i].created_at
            })
        }
    }

    function createProfile() {
        const profileName = profileNameInput.text.trim()
        const result = backend.createProfile(profileName)
        if (!result.ok) {
            switch (result.error) {
            case Common.profileErrEmptyName:
                statusText.text = "Введите имя игрока"
                break
            case Common.profileErrNameTooLong:
                statusText.text = "Имя игрока слишком длинное"
                break
            case Common.profileErrDuplicateName:
                statusText.text = "Такой профиль уже существует"
                break
            default:
                statusText.text = "Не удалось создать профиль"
                break
            }
            return
        }

        profileNameInput.text = ""
        statusText.text = ""
        loadProfiles()
    }

    function deleteProfile(profileId) {
        const result = backend.deleteProfile(profileId)
        if (!result.ok) {
            switch (result.error) {
            case Common.profileErrNotFound:
                statusText.text = "Профиль уже удалён"
                break
            default:
                statusText.text = "Не удалось удалить профиль"
                break
            }
            loadProfiles()
            return
        }

        statusText.text = ""
        loadProfiles()
    }
}
