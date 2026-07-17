pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../components"

Rectangle {
    property var stats: ({})
    property string selectedProfileId: ""
    property bool componentReady: false
    readonly property bool hasProfiles: profilesModel.count > 0
    readonly property bool hasGames: stats.ok === true && Number(stats.games_played) > 0
    readonly property var favoriteHero: stats.favorite_hero || ({})
    readonly property var favoriteMap: stats.favorite_map || ({})

    signal openProfilesRequested()

    id: root
    color: Common.bgColor

    ColumnLayout {
        anchors {
            fill: parent
            margins: 14
        }
        spacing: 12

        FieldBox {
            Layout.fillWidth: true
            Layout.preferredHeight: 68
            label: qsTr("Game mode")

            ThemedComboBox {
                id: gameModeSelector
                anchors.fill: parent
                model: gameModesModel
                textRole: "name"

                onActivated: root.loadStats()
            }
        }

        FieldBox {
            Layout.fillWidth: true
            Layout.preferredHeight: 68
            label: qsTr("Profile")

            ThemedComboBox {
                id: profileSelector
                anchors.fill: parent
                enabled: root.hasProfiles
                model: profilesModel
                textRole: "name"

                onActivated: (index) => root.selectProfile(index)
            }
        }

        Text {
            id: statusText
            Layout.fillWidth: true
            visible: text.length > 0
            color: Common.warning
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: !root.hasProfiles

            Column {
                anchors.centerIn: parent
                width: Math.min(parent.width, 280)
                spacing: 14

                Text {
                    width: parent.width
                    text: qsTr("Create a player profile to see personal statistics")
                    color: Common.textSecondary
                    font.pixelSize: Common.defaultFontSize
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                Btn {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 160
                    height: 46
                    text: qsTr("Create profile")
                    fontSize: Common.defaultFontSize
                    onClicked: root.openProfilesRequested()
                }
            }
        }

        ScrollView {
            id: statsScroll
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: root.hasProfiles
            clip: true
            contentWidth: availableWidth
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: statsScroll.availableWidth
                spacing: 12

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    StatTile {
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                        title: qsTr("GAMES")
                        value: root.hasGames ? String(root.stats.games_played) : "0"
                        detail: qsTr("played")
                        accentColor: Common.accent
                    }

                    StatTile {
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                        title: qsTr("WIN RATE")
                        value: root.formatPercent(root.stats.win_percentage)
                        detail: root.hasGames
                                ? qsTr("%1 wins").arg(root.stats.games_won)
                                : qsTr("no games")
                        accentColor: Common.success
                    }

                    StatTile {
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                        title: qsTr("AVG HP IN WINS")
                        value: root.formatAverageHp(root.stats.average_winning_hp)
                        detail: qsTr("hero health")
                        accentColor: Common.team3Color
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 160
                    color: Common.secondary
                    radius: 8
                    border.width: 1
                    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
                    clip: true

                    LoadImage {
                        id: heroImage
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: parent.width * 0.42
                        visible: root.favoriteHero.name !== undefined
                        imgPath: root.favoriteHero.img_path || ""
                        fillMode: Image.PreserveAspectCrop
                    }

                    Rectangle {
                        anchors {
                            left: heroImage.right
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: 1
                        color: Qt.lighter(Common.secondary, Common.borderLightFactor)
                        visible: heroImage.visible
                    }

                    Column {
                        anchors {
                            left: heroImage.visible ? heroImage.right : parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            leftMargin: 14
                            rightMargin: 12
                        }
                        spacing: 7

                        Text {
                            width: parent.width
                            text: qsTr("MOST PLAYED HERO")
                            color: Common.accent
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Text {
                            width: parent.width
                            text: root.favoriteHero.name || qsTr("No hero data yet")
                            color: Common.textColor
                            font.pixelSize: 22
                            font.bold: true
                            elide: Text.ElideRight
                        }

                        Text {
                            width: parent.width
                            visible: root.favoriteHero.name !== undefined
                            text: qsTr("%1 games  |  %2 win rate")
                                .arg(root.favoriteHero.games_played || 0)
                                .arg(root.formatPercent(root.favoriteHero.win_percentage))
                            color: Common.textSecondary
                            font.pixelSize: 14
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 146
                    color: Common.primary
                    radius: 8
                    border.width: 1
                    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
                    clip: true

                    LoadImage {
                        id: mapImage
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: parent.width * 0.42
                        visible: root.favoriteMap.name !== undefined
                        imgPath: root.favoriteMap.img_path || ""
                        fillMode: Image.PreserveAspectCrop
                    }

                    Rectangle {
                        anchors {
                            left: mapImage.right
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: 1
                        color: Qt.lighter(Common.secondary, Common.borderLightFactor)
                        visible: mapImage.visible
                    }

                    Column {
                        anchors {
                            left: mapImage.visible ? mapImage.right : parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            leftMargin: 14
                            rightMargin: 12
                        }
                        spacing: 7

                        Text {
                            width: parent.width
                            text: qsTr("MOST PLAYED MAP")
                            color: Common.team3Color
                            font.pixelSize: 12
                            font.bold: true
                        }

                        Text {
                            width: parent.width
                            text: root.favoriteMap.name || qsTr("No map data yet")
                            color: Common.textColor
                            font.pixelSize: 22
                            font.bold: true
                            elide: Text.ElideRight
                        }

                        Text {
                            width: parent.width
                            visible: root.favoriteMap.name !== undefined
                            text: qsTr("%1 games").arg(root.favoriteMap.games_played || 0)
                            color: Common.textSecondary
                            font.pixelSize: 14
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: gameModesModel
        ListElement { code: "1v1"; name: "1 vs 1" }
        ListElement { code: "1v1v1"; name: "1 vs 1 vs 1" }
        ListElement { code: "1v1v1v1"; name: "1 vs 1 vs 1 vs 1" }
        ListElement { code: "2v2"; name: "2 vs 2" }
    }

    ListModel {
        id: profilesModel
    }

    Component.onCompleted: {
        componentReady = true
        if (visible) {
            loadDashboard()
        }
    }

    onVisibleChanged: {
        if (visible && componentReady) {
            loadDashboard()
        }
    }

    function loadDashboard() {
        statusText.text = ""
        profilesModel.clear()

        const profiles = core.getProfiles()
        for (let i = 0; i < profiles.length; i++) {
            profilesModel.append({ id: profiles[i].id, name: profiles[i].name })
        }

        if (profilesModel.count === 0) {
            selectedProfileId = ""
            stats = ({})
            profileSelector.currentIndex = -1
            return
        }

        const defaultProfileId = core.getDefaultProfileId()
        let selectedIndex = 0
        for (let i = 0; i < profilesModel.count; i++) {
            if (profilesModel.get(i).id === defaultProfileId) {
                selectedIndex = i
                break
            }
        }

        profileSelector.currentIndex = selectedIndex
        selectProfile(selectedIndex)
    }

    function selectProfile(index) {
        if (index < 0 || index >= profilesModel.count) {
            return
        }

        statusText.text = ""
        selectedProfileId = profilesModel.get(index).id
        const saveResult = core.setDefaultProfileId(selectedProfileId)
        loadStats()
        if (!saveResult.ok && statusText.text.length === 0) {
            statusText.text = qsTr("Could not save the default profile")
        }
    }

    function loadStats() {
        statusText.text = ""
        if (selectedProfileId.length === 0) {
            stats = ({})
            return
        }

        const statsResult = core.getProfileStats(selectedProfileId, selectedModeCode())
        if (!statsResult.ok) {
            stats = ({})
            statusText.text = qsTr("Could not load profile statistics")
            return
        }
        stats = statsResult
    }

    function selectedModeCode() {
        if (gameModeSelector.currentIndex < 0 ||
                gameModeSelector.currentIndex >= gameModesModel.count) {
            return "1v1"
        }
        return gameModesModel.get(gameModeSelector.currentIndex).code
    }

    function formatPercent(value) {
        const number = Number(value)
        return (isNaN(number) ? 0 : number).toFixed(1) + "%"
    }

    function formatAverageHp(value) {
        if (value === undefined || value === null || value === "") {
            return "-"
        }
        const number = Number(value)
        return isNaN(number) ? "-" : number.toFixed(1)
    }
}
