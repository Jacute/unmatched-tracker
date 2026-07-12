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

    ColumnLayout {
        anchors {
            fill: parent
            margins: root.pageMargin
        }
        spacing: root.fieldSpacing

        ColumnLayout {
            id: contentColumn
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(contentColumn.implicitHeight, root.height * 0.48)
            spacing: root.fieldSpacing

            // Player 1
            RowLayout {
                Layout.fillWidth: true
                spacing: root.fieldSpacing

                // Profile
                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Player 1")
                    ThemedComboBox {
                        id: player1Profile
                        anchors.fill: parent
                        model: profilesModel
                        textRole: "name"
                    }
                }

                // Hero
                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Hero 1")
                    ThemedComboBox {
                        id: player1Hero
                        anchors.fill: parent
                        model: heroesModel
                        textRole: "name"
                    }
                }
            }

            // Player 2
            RowLayout {
                Layout.fillWidth: true
                spacing: root.fieldSpacing

                // Profile
                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Player 2")
                    ThemedComboBox {
                        id: player2Profile
                        anchors.fill: parent
                        model: profilesModel
                        textRole: "name"
                    }
                }

                // Hero
                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Hero 2")
                    ThemedComboBox {
                        id: player2Hero
                        anchors.fill: parent
                        model: heroesModel
                        textRole: "name"
                    }
                }
            }

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
                    model: {
                        if (player1Profile.currentIndex != -1 && player2Profile.currentIndex != -1) {
                            return [
                                profilesModel.get(player1Profile.currentIndex).name,
                                profilesModel.get(player2Profile.currentIndex).name
                            ]
                        }
                        return []
                    }
                }
            }

            // HP
            RowLayout {
                Layout.fillWidth: true
                spacing: root.fieldSpacing

                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Hero 1 HP")
                    TextField {
                        id: hero1HpInput
                        anchors.fill: parent
                        color: Common.textColor
                        placeholderText: activeFocus || text != "" ? "" : qsTr("Optional")
                        placeholderTextColor: Common.textHint
                        selectionColor: Common.accent
                        selectedTextColor: Common.primary
                        font.pixelSize: Common.defaultFontSize
                        padding: 0
                        enabled: player1Hero.currentIndex != -1
                        validator: IntValidator {
                            bottom: 0
                            top: root.selectedHeroHp(player1Hero.currentIndex)
                        }
                        inputMethodHints: Qt.ImhDigitsOnly
                        background: null
                        verticalAlignment: TextInput.AlignVCenter
                    }
                }

                FieldBox {
                    Layout.fillWidth: true
                    label: qsTr("Hero 2 HP")
                    TextField {
                        id: hero2HpInput
                        anchors.fill: parent
                        color: Common.textColor
                        placeholderText: activeFocus || text != "" ? "" : qsTr("Optional")
                        placeholderTextColor: Common.textHint
                        selectionColor: Common.accent
                        selectedTextColor: Common.primary
                        font.pixelSize: Common.defaultFontSize
                        padding: 0
                        enabled: player2Hero.currentIndex != -1
                        validator: IntValidator {
                            bottom: 0
                            top: root.selectedHeroHp(player2Hero.currentIndex)
                        }
                        inputMethodHints: Qt.ImhDigitsOnly
                        background: null
                        verticalAlignment: TextInput.AlignVCenter
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

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: Common.secondary
        }

        FieldBox {
            Layout.fillWidth: true
            label: qsTr("History sort")
            ThemedComboBox {
                id: historySortSelect
                anchors.fill: parent
                model: historySortModel
                textRole: "name"

                onCurrentIndexChanged: root.loadHistory()
            }
        }

        ListView {
            id: historyList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: historyModel
            spacing: root.fieldSpacing

            delegate: Rectangle {
                required property var modelData

                id: game
                readonly property var participants: modelData.participants
                readonly property var player1: root.participantAt(participants, 0)
                readonly property var player2: root.participantAt(participants, 1)
                readonly property bool player1Won: Number(root.participantValue(player1, "team", 0))
                                                   === Number(modelData.winning_team)

                width: historyList.width
                height: historyContent.implicitHeight + root.fieldSpacing * 2
                color: Common.secondary
                radius: Common.defaultRadius
                border.width: 1
                border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

                Btn {
                    id: deleteGameBtn
                    anchors {
                        top: parent.top
                        right: parent.right
                        topMargin: root.fieldSpacing
                        rightMargin: root.fieldSpacing
                    }
                    width: root.controlHeight * 0.48
                    height: width
                    radius: width / 2
                    text: "×"
                    fontSize: height * 0.55
                    bgColor: Common.error
                    bgColorPressed: Qt.lighter(Common.error, 1.15)
                    borderWidth: 0
                    txtColor: Common.textColor

                    onClicked: {
                        deleteConfirmPopup.gameId = game.modelData.id
                        deleteConfirmPopup.gameText = qsTr("%1 vs %2")
                            .arg(root.participantHistoryText(game.player1))
                            .arg(root.participantHistoryText(game.player2))
                        deleteConfirmPopup.open()
                    }
                }

                ColumnLayout {
                    id: historyContent
                    anchors {
                        left: parent.left
                        right: deleteGameBtn.left
                        verticalCenter: parent.verticalCenter
                        margins: root.fieldSpacing
                        rightMargin: root.fieldSpacing * 1.5
                    }
                    spacing: 3

                    Text {
                        Layout.fillWidth: true
                        text: root.valueText(game.modelData.played_at, "Date not specified")
                        color: Common.textHint
                        font.pixelSize: Common.defaultFontSize * 0.82
                        elide: Text.ElideRight
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        Text {
                            Layout.fillWidth: true
                            text: root.participantHistoryText(game.player1)
                            color: game.player1Won ? Common.success : Common.error
                            font.pixelSize: Common.defaultFontSize
                            font.bold: true
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            text: qsTr("vs")
                            color: Common.textHint
                            font.pixelSize: Common.defaultFontSize * 0.86
                            Layout.alignment: Qt.AlignTop
                        }

                        Text {
                            Layout.fillWidth: true
                            text: root.participantHistoryText(game.player2)
                            color: game.player1Won ? Common.error : Common.success
                            font.pixelSize: Common.defaultFontSize
                            font.bold: true
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: root.historyMetaText(
                            game.modelData.map_name,
                            root.participantValue(game.player1, "hero_remaining_hp"),
                            root.participantValue(game.player2, "hero_remaining_hp")
                        )
                        color: Common.textSecondary
                        font.pixelSize: Common.defaultFontSize * 0.86
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: historyModel.count === 0
            text: qsTr("No games yet")
            color: Common.textHint
            font.pixelSize: Common.defaultFontSize
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Popup {
        property string gameId: ""
        property string gameText: ""

        id: deleteConfirmPopup
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        parent: Overlay.overlay
        anchors.centerIn: parent
        width: Math.min(root.width * 0.86, 360)
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
                text: qsTr("Delete game?")
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
                text: deleteConfirmPopup.gameText
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

                    onClicked: deleteConfirmPopup.close()
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
                        const gameId = deleteConfirmPopup.gameId
                        deleteConfirmPopup.close()
                        root.deleteGameRecord(gameId)
                    }
                }
            }
        }
    }

    ListModel { id: profilesModel }
    ListModel { id: heroesModel }
    ListModel { id: mapsInputModel }
    ListModel {
        id: historySortModel
        ListElement {
            key: "created_at"
            name: qsTr("Created time")
        }
        ListElement {
            key: "played_at"
            name: qsTr("Played date")
        }
    }
    ListModel {
        id: historyModel
        dynamicRoles: true
    }

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
        loadHistory()
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

    function loadHistory() {
        historyModel.clear()
        const history = core.getGameHistory(root.selectedHistorySort())
        for (let i = 0; i < history.length; i++) {
            historyModel.append(history[i])
        }
    }

    function selectedHistorySort() {
        if (historySortSelect.currentIndex < 0 || historySortSelect.currentIndex >= historySortModel.count) {
            return "created_at"
        }
        return historySortModel.get(historySortSelect.currentIndex).key
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

    function selectedHeroHp(index) {
        if (index < 0 || index >= heroesModel.count) {
            return 0
        }
        return heroesModel.get(index).hp
    }

    function optionalHp(field, heroNumber) {
        const value = field.text.trim()
        if (value.length === 0) {
            return { valid: true }
        }
        if (!field.acceptableInput || !/^\d+$/.test(value)) {
            return {
                valid: false,
                error: qsTr("Hero %1 HP must be between 0 and %2")
                    .arg(heroNumber)
                    .arg(root.selectedHeroHp(heroNumber === 1
                                             ? player1Hero.currentIndex
                                             : player2Hero.currentIndex))
            }
        }
        return { valid: true, value: parseInt(value, 10) }
    }

    function isMaskedDateEmpty(text) {
        return text.replace(/[-_]/g, "").trim().length === 0
    }

    function normalizedPlayedAt() {
        const value = playedAtInput.text.trim()
        return root.isMaskedDateEmpty(value) ? "" : value
    }

    function createGame() {
        if (profilesModel.count < 2) {
            statusText.text = qsTr("Create at least two player profiles")
            return
        }
        if (heroesModel.count === 0) {
            statusText.text = qsTr("No heroes available")
            return
        }

        const player1 = {
            position: 1,
            team: 1,
            profile_id: root.selectedId(profilesModel, player1Profile.currentIndex),
            hero_id: root.selectedId(heroesModel, player1Hero.currentIndex),
            hero_remaining_hp: 0
        }
        const player2 = {
            position: 2,
            team: 2,
            profile_id: root.selectedId(profilesModel, player2Profile.currentIndex),
            hero_id: root.selectedId(heroesModel, player2Hero.currentIndex),
            hero_remaining_hp: 0
        }
        const payload = {
            mode: "1v1",
            participants: [player1, player2],
            winning_team: winner.currentIndex + 1
        }

        if (player1.profile_id === player2.profile_id) {
            statusText.text = qsTr("Choose two different players")
            return
        }

        const mapId = root.optionalSelectedId(mapsInputModel, mapSelect.currentIndex)
        if (mapId !== undefined) {
            payload.map_id = mapId
        }

        const hero1Hp = root.optionalHp(hero1HpInput, 1)
        if (!hero1Hp.valid) {
            statusText.text = hero1Hp.error
            return
        }
        if (hero1Hp.value !== undefined) {
            player1.hero_remaining_hp = hero1Hp.value
        }

        const hero2Hp = root.optionalHp(hero2HpInput, 2)
        if (!hero2Hp.valid) {
            statusText.text = hero2Hp.error
            return
        }
        if (hero2Hp.value !== undefined) {
            player2.hero_remaining_hp = hero2Hp.value
        }

        if (player1.hero_remaining_hp != 0 && player2.hero_remaining_hp != 0) {
            statusText.text = "Both heroes cannot have more than 0 hp"
            return
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
        loadHistory()
    }

    function deleteGameRecord(gameId) {
        const result = core.deleteGameRecord(gameId)
        if (!result.ok) {
            switch (result.error) {
            case Common.gameErrNotFound:
                statusText.text = qsTr("Game has already been deleted")
                break
            default:
                statusText.text = qsTr("Could not delete game")
                break
            }
            loadHistory()
            return
        }

        statusText.text = ""
        loadHistory()
    }

    function valueText(value, fallback) {
        return value === undefined || value === null || value === "" ? fallback : value
    }

    function participantAt(participants, index) {
        if (!participants) {
            return {}
        }

        if (typeof participants.get === "function") {
            const participant = index < participants.count ? participants.get(index) : null
            return participant || {}
        }

        const participant = index < participants.length ? participants[index] : null
        return participant || {}
    }

    function participantValue(participant, key, fallback) {
        if (!participant || participant[key] === undefined || participant[key] === null) {
            return fallback
        }
        return participant[key]
    }

    function participantHistoryText(participant) {
        return root.playerHistoryText(
            root.participantValue(participant, "profile_name", ""),
            root.participantValue(participant, "hero_name", "")
        )
    }

    function playerHistoryText(profileName, heroName) {
        return qsTr("%1 (%2)").arg(profileName).arg(heroName)
    }

    function historyMetaText(mapName, hp1, hp2) {
        const mapText = root.valueText(mapName, qsTr("Map not specified"))
        const hpText = qsTr("HP: %1 / %2").arg(root.valueText(hp1, "-")).arg(root.valueText(hp2, "-"))
        return qsTr("%1 · %2").arg(mapText).arg(hpText)
    }

    function clearFields() {
        statusText.text = ""
        hero1HpInput.text = ""
        hero2HpInput.text = ""
        playedAtInput.text = ""
        player1Profile.currentIndex = -1
        player1Hero.currentIndex = -1
        player2Profile.currentIndex = -1
        player2Hero.currentIndex = -1
        winner.currentIndex = -1
    }
}
