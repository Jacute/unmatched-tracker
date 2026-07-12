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
    readonly property real controlHeight: Common.defaultFontSize * 3.8
    readonly property real fieldSpacing: height * 0.01
    property int participantRevision: 0

    ColumnLayout {
        anchors {
            fill: parent
            margins: root.pageMargin
        }
        spacing: root.fieldSpacing

        ColumnLayout {
            id: contentColumn
            Layout.fillWidth: true
            Layout.preferredHeight: contentColumn.implicitHeight
            spacing: root.fieldSpacing

            FieldBox {
                Layout.fillWidth: true
                label: qsTr("Game mode")

                ThemedComboBox {
                    id: modeSelect
                    anchors.fill: parent
                    model: gameModesModel
                    textRole: "name"

                    onActivated: root.changeGameMode()
                }
            }

            Repeater {
                id: participantRepeater
                model: root.selectedPlayerCount()

                GameParticipantInput {
                    required property int index

                    Layout.fillWidth: true
                    Layout.preferredHeight: implicitHeight
                    title: root.participantTitle(index)
                    markerColor: root.teamColor(root.teamForParticipant(index))
                    profileOptions: profilesModel
                    heroOptions: heroesModel

                    onProfileSelectionChanged: root.participantRevision++
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: root.fieldSpacing

                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Map")
                    ThemedComboBox {
                        id: mapSelect
                        anchors.fill: parent
                        model: mapsInputModel
                        textRole: "name"
                    }
                }

                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Winner")
                    ThemedComboBox {
                        id: winner
                        anchors.fill: parent
                        model: root.winnerOptions()
                    }
                }
            }

            // Game date
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: root.controlHeight
                spacing: root.fieldSpacing

                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Played at")
                    TextField {
                        id: playedAtInput
                        anchors.fill: parent
                        color: Common.textColor
                        placeholderText: activeFocus || text != "" ? "" : qsTr("DD-MM-YYYY")
                        placeholderTextColor: Common.textHint
                        selectionColor: Common.accent
                        selectedTextColor: Common.primary
                        font.pixelSize: Common.defaultFontSize
                        padding: 0
                        inputMask: ""
                        background: null
                        verticalAlignment: TextInput.AlignVCenter

                        onActiveFocusChanged: {
                            if (activeFocus) {
                                inputMask = "00-00-0000;_"
                                return
                            }

                            if (root.isMaskedDateEmpty(text)) {
                                inputMask = ""
                                text = ""
                            }
                        }
                    }
                }

                Btn {
                    Layout.preferredWidth: root.width * 0.3
                    Layout.preferredHeight: root.controlHeight
                    Layout.alignment: Qt.AlignVCenter
                    radius: Common.defaultRadius
                    text: qsTr("Add game")
                    fontSize: Common.defaultFontSize
                    onClicked: root.createGame()
                }
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

        GameHistory {
            id: gameHistory
            Layout.fillWidth: true
            Layout.fillHeight: true
            fieldSpacing: root.fieldSpacing
            controlHeight: root.controlHeight
        }
    }

    ListModel {
        id: gameModesModel
        ListElement { code: "1v1"; name: "1 vs 1"; playerCount: 2; teamCount: 2 }
        ListElement { code: "1v1v1"; name: "1 vs 1 vs 1"; playerCount: 3; teamCount: 3 }
        ListElement { code: "1v1v1v1"; name: "1 vs 1 vs 1 vs 1"; playerCount: 4; teamCount: 4 }
        ListElement { code: "2v2"; name: "2 vs 2"; playerCount: 4; teamCount: 2 }
    }
    ListModel { id: profilesModel }
    ListModel { id: heroesModel }
    ListModel { id: mapsInputModel }
    Component.onCompleted: {
        if (visible) {
            loadData()
        }
    }

    onVisibleChanged: {
        if (visible) {
            loadData()
        }
    }

    function loadData() {
        loadProfiles()
        loadHeroes()
        loadMaps()
        gameHistory.reload()
    }

    function loadProfiles() {
        profilesModel.clear()
        const profiles = core.getProfiles()
        for (let i = 0; i < profiles.length; i++) {
            profilesModel.append({
                id: profiles[i].id,
                name: profiles[i].name
            })
        }
    }

    function loadHeroes() {
        heroesModel.clear()
        const heroes = core.getHeroes()
        for (let i = 0; i < heroes.length; i++) {
            heroesModel.append({
                id: heroes[i].id,
                name: heroes[i].name,
                hp: heroes[i].hp
            })
        }
    }

    function loadMaps() {
        mapsInputModel.clear()
        mapsInputModel.append({ id: 0, name: qsTr("Not specified") })
        const maps = core.getMaps()
        for (let i = 0; i < maps.length; i++) {
            mapsInputModel.append({
                id: maps[i].id,
                name: maps[i].name
            })
        }
    }

    function selectedId(model, index) {
        if (index < 0 || index >= model.count) {
            return 0
        }
        return model.get(index).id
    }

    function optionalSelectedId(model, index) {
        const id = selectedId(model, index)
        return id > 0 ? id : undefined
    }

    function selectedModeValue(role, fallback) {
        if (modeSelect.currentIndex < 0 || modeSelect.currentIndex >= gameModesModel.count) {
            return fallback
        }
        return gameModesModel.get(modeSelect.currentIndex)[role]
    }

    function selectedModeCode() {
        return root.selectedModeValue("code", "1v1")
    }

    function selectedPlayerCount() {
        return root.selectedModeValue("playerCount", 2)
    }

    function selectedTeamCount() {
        return root.selectedModeValue("teamCount", 2)
    }

    function teamForParticipant(index) {
        return root.selectedModeCode() === "2v2" ? index % 2 + 1 : index + 1
    }

    function participantTitle(index) {
        if (root.selectedModeCode() === "2v2") {
            return qsTr("P%1\nTeam %2")
                .arg(Math.floor(index / 2) + 1)
                .arg(root.teamForParticipant(index))
        }
        return qsTr("Player %1").arg(index + 1)
    }

    function teamColor(team) {
        switch (team) {
        case 1: return Common.team1Color
        case 2: return Common.team2Color
        case 3: return Common.team3Color
        default: return Common.team4Color
        }
    }

    function participantInputAt(index) {
        return index >= 0 && index < participantRepeater.count
            ? participantRepeater.itemAt(index)
            : null
    }

    function winnerOptions() {
        root.participantRevision
        const participants = []
        for (let i = 0; i < participantRepeater.count; i++) {
            const input = root.participantInputAt(i)
            if (!input || input.profileIndex < 0) {
                return []
            }
            participants.push({
                name: input.profileName,
                team: root.teamForParticipant(i)
            })
        }

        if (root.selectedModeCode() !== "2v2") {
            return participants.map(participant => participant.name)
        }

        const teams = [[], []]
        for (let i = 0; i < participants.length; i++) {
            teams[participants[i].team - 1].push(participants[i].name)
        }
        return [
            qsTr("Team 1: %1").arg(teams[0].join(", ")),
            qsTr("Team 2: %1").arg(teams[1].join(", "))
        ]
    }

    function clearParticipants() {
        for (let i = 0; i < participantRepeater.count; i++) {
            const input = root.participantInputAt(i)
            if (input) {
                input.clear()
            }
        }
        root.participantRevision++
    }

    function changeGameMode() {
        statusText.text = ""
        winner.currentIndex = -1
        root.participantRevision++
        Qt.callLater(root.clearParticipants)
    }

    function isMaskedDateEmpty(text) {
        return text.replace(/[-_]/g, "").trim().length === 0
    }

    function normalizedPlayedAt() {
        const value = playedAtInput.text.trim()
        return root.isMaskedDateEmpty(value) ? "" : value
    }

    function createGame() {
        const playerCount = root.selectedPlayerCount()
        if (profilesModel.count < playerCount) {
            statusText.text = qsTr("Create at least %1 player profiles").arg(playerCount)
            return
        }

        if (winner.currentIndex < 0) {
            statusText.text = qsTr("Choose the winner")
            return
        }

        const participants = []
        const profileIds = ({})
        const winningTeam = winner.currentIndex + 1
        let winningHpSpecified = false
        for (let i = 0; i < playerCount; i++) {
            const input = root.participantInputAt(i)
            if (!input || input.profileId === 0) {
                statusText.text = qsTr("Choose a profile for %1").arg(root.participantTitle(i))
                return
            }

            const profileKey = String(input.profileId)
            if (profileIds[profileKey]) {
                statusText.text = qsTr("Choose different player profiles")
                return
            }
            profileIds[profileKey] = true

            const hp = input.hpResult()
            if (!hp.valid) {
                statusText.text = hp.error
                return
            }

            const participant = {
                position: i + 1,
                team: root.teamForParticipant(i),
                profile_id: input.profileId,
                hero_id: input.heroId,
                hero_remaining_hp: hp.specified ? hp.value : null
            }
            if (participant.team === winningTeam && hp.specified) {
                winningHpSpecified = true
            }
            if (participant.team !== winningTeam && hp.specified && hp.value > 0) {
                statusText.text = qsTr("Only the winning side can have remaining HP")
                return
            }
            participants.push(participant)
        }

        for (let i = 0; i < participants.length; i++) {
            if (!winningHpSpecified) {
                participants[i].hero_remaining_hp = null
            } else if (participants[i].team !== winningTeam
                       && participants[i].hero_remaining_hp === null) {
                participants[i].hero_remaining_hp = 0
            }
        }

        const payload = {
            mode: root.selectedModeCode(),
            participants: participants,
            winning_team: winningTeam
        }

        const mapId = root.optionalSelectedId(mapsInputModel, mapSelect.currentIndex)
        if (mapId !== undefined) {
            payload.map_id = mapId
        }

        const playedAt = root.normalizedPlayedAt()
        if (playedAt.length > 0) {
            if (!/^\d{2}-\d{2}-\d{4}$/.test(playedAt)) {
                statusText.text = qsTr("Enter full played date or leave it empty")
                return
            }
            payload.played_at = playedAt
        }

        const result = core.createGameRecord(payload)
        if (!result.ok) {
            statusText.text = result.error
            return
        }

        clearFields()
        gameHistory.reload()
    }

    function clearFields() {
        statusText.text = ""
        playedAtInput.text = ""
        root.clearParticipants()
        winner.currentIndex = -1
    }
}
