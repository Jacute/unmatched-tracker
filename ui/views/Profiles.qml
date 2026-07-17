pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.bgColor
    readonly property real pageMargin: width * 0.04
    readonly property real controlHeight: profileNameInput.font.pixelSize * 3
    readonly property real contentSpacing: height * 0.02
    readonly property real itemSpacing: controlHeight * 0.15
    readonly property real fieldHPadding: controlHeight * 0.25
    readonly property real listHPadding: controlHeight * 0.3
    readonly property real deleteButtonSize: controlHeight * 0.7

    ColumnLayout {
        anchors {
            fill: parent
            margins: root.pageMargin
        }
        spacing: root.contentSpacing

        RowLayout {
            Layout.fillWidth: true
            spacing: root.itemSpacing

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: root.controlHeight
                color: Common.primary
                radius: Common.defaultRadius
                border.width: 1
                border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

                TextField {
                    id: profileNameInput
                    anchors {
                        fill: parent
                        leftMargin: root.fieldHPadding
                        rightMargin: root.fieldHPadding
                    }
                    color: Common.textColor
                    selectionColor: Common.accent
                    selectedTextColor: Common.primary
                    placeholderText: qsTr("Player name")
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
                Layout.preferredHeight: root.controlHeight
                radius: Common.defaultRadius
                text: qsTr("Add")
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
            spacing: root.itemSpacing

            delegate: Rectangle {
                required property string name
                required property string id

                width: profilesList.width
                height: root.controlHeight
                color: Common.secondary
                radius: Common.defaultRadius
                border.width: 1
                border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

                Text {
                    anchors {
                        left: parent.left
                        right: deleteBtn.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: root.listHPadding
                        rightMargin: root.itemSpacing
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
                        rightMargin: root.itemSpacing
                        verticalCenter: parent.verticalCenter
                    }
                    width: root.deleteButtonSize
                    height: width
                    radius: width / 2
                    text: "×"
                    fontSize: height * 0.55
                    bgColor: Common.error
                    bgColorPressed: Qt.lighter(Common.error, 1.15)
                    borderWidth: 0
                    txtColor: Common.textColor

                    onClicked: {
                        deleteConfirmPopup.profileId = id
                        deleteConfirmPopup.profileName = name
                        deleteConfirmPopup.open()
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: profilesModel.count === 0
            text: qsTr("No profiles yet")
            color: Common.textHint
            font.pixelSize: Common.defaultFontSize
            horizontalAlignment: Text.AlignHCenter
        }
    }

    DeleteConfirmPopup {
        property string profileId: ""
        property string profileName: ""

        id: deleteConfirmPopup
        title: qsTr("Delete profile?")
        message: profileName
        fieldSpacing: root.itemSpacing
        controlHeight: root.controlHeight

        onConfirmed: root.deleteProfile(profileId)
    }

    ListModel {
        id: profilesModel
    }

    Component.onCompleted: loadProfiles()

    function loadProfiles() {
        profilesModel.clear()
        const profiles = core.getProfiles()
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
        const result = core.createProfile(profileName)
        if (!result.ok) {
            switch (result.error) {
            case Common.profileErrEmptyName:
                statusText.text = qsTr("Enter a player name")
                break
            case Common.profileErrNameTooLong:
                statusText.text = qsTr("Player name is too long")
                break
            case Common.profileErrDuplicateName:
                statusText.text = qsTr("This profile already exists")
                break
            default:
                statusText.text = qsTr("Could not create profile")
                break
            }
            return
        }

        profileNameInput.text = ""
        statusText.text = ""
        loadProfiles()
    }

    function deleteProfile(profileId) {
        const result = core.deleteProfile(profileId)
        if (!result.ok) {
            switch (result.error) {
            case Common.profileErrNotFound:
                statusText.text = qsTr("Profile has already been deleted")
                break
            case Common.profileErrHasGameRecords:
                statusText.text = qsTr("Delete this profile's game records first")
                break
            default:
                statusText.text = qsTr("Could not delete profile")
                break
            }
            loadProfiles()
            return
        }

        statusText.text = ""
        loadProfiles()
    }
}
