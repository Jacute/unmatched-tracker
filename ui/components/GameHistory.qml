pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker

Item {
    id: root

    property real fieldSpacing: 8
    property real controlHeight: Common.defaultFontSize * 3.8
    readonly property int pageSize: 5
    property int pageOffset: 0
    property bool hasMore: false
    property bool loading: false
    readonly property bool hasGames: historyModel.count > 0

    ColumnLayout {
        anchors.fill: parent
        spacing: root.fieldSpacing

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

                onActivated: root.reload()
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

        ListView {
            id: historyList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: historyModel
            spacing: root.fieldSpacing
            cacheBuffer: height * 0.6

            onMovementEnded: {
                if (contentY + height >= contentHeight - height * 0.5) {
                    root.loadNextPage()
                }
            }

            delegate: Rectangle {
                required property var modelData

                id: game
                readonly property var participants: modelData.participants

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
                        deleteConfirmPopup.gameText = root.gameTitle(game.participants)
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
                        text: root.valueText(game.modelData.played_at, qsTr("Date not specified"))
                        color: Common.textHint
                        font.pixelSize: Common.defaultFontSize * 0.82
                        elide: Text.ElideRight
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        Repeater {
                            model: root.participantCount(game.participants)

                            RowLayout {
                                required property int index
                                readonly property var participant: root.participantAt(
                                                                       game.participants,
                                                                       index)

                                id: participantRow
                                Layout.fillWidth: true
                                spacing: 8

                                Rectangle {
                                    Layout.preferredWidth: Common.defaultFontSize * 2.35
                                    Layout.preferredHeight: Common.defaultFontSize * 2.35
                                    radius: Common.defaultRadius * 0.5
                                    color: Common.imagePlaceholder
                                    clip: true

                                    LoadImage {
                                        anchors.fill: parent
                                        imgPath: root.participantValue(
                                            participantRow.participant,
                                            "hero_img_path",
                                            ""
                                        )
                                        fillMode: Image.PreserveAspectCrop
                                    }
                                }

                                Text {
                                    Layout.fillWidth: true
                                    text: root.participantLabel(
                                        game.modelData.mode,
                                        index,
                                        participantRow.participant
                                    )
                                    color: Number(root.participantValue(participantRow.participant,
                                                                        "team",
                                                                        0))
                                           === Number(game.modelData.winning_team)
                                        ? Common.success
                                        : Common.error
                                    font.pixelSize: Common.defaultFontSize
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: root.metaText(game.modelData.map_name, game.participants)
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
            visible: historyModel.count === 0 && !root.loading
            text: qsTr("No games yet")
            color: Common.textHint
            font.pixelSize: Common.defaultFontSize
            horizontalAlignment: Text.AlignHCenter
        }
    }

    DeleteConfirmPopup {
        property string gameId: ""
        property string gameText: ""

        id: deleteConfirmPopup
        title: qsTr("Delete game?")
        message: gameText
        fieldSpacing: root.fieldSpacing
        controlHeight: root.controlHeight

        onConfirmed: root.deleteGame(gameId)
    }

    ListModel {
        id: historySortModel
        ListElement { key: "created_at"; name: qsTr("Created time") }
        ListElement { key: "played_at"; name: qsTr("Played date") }
    }

    ListModel {
        id: historyModel
        dynamicRoles: true
    }

    function reload() {
        statusText.text = ""
        historyModel.clear()
        root.pageOffset = 0
        root.hasMore = true
        root.loadNextPage()
    }

    function scrollToBeginning() {
        if (historyModel.count > 0) {
            historyList.positionViewAtBeginning()
        }
    }

    function loadNextPage() {
        if (root.loading || !root.hasMore) {
            return
        }

        root.loading = true
        const history = core.getGameHistory(
            root.selectedSort(),
            root.pageSize,
            root.pageOffset
        )
        for (let i = 0; i < history.length; i++) {
            historyModel.append(history[i])
        }
        root.pageOffset += history.length
        root.hasMore = history.length === root.pageSize
        root.loading = false
    }

    function selectedSort() {
        if (historySortSelect.currentIndex < 0
                || historySortSelect.currentIndex >= historySortModel.count) {
            return "created_at"
        }
        return historySortModel.get(historySortSelect.currentIndex).key
    }

    function deleteGame(gameId) {
        const result = core.deleteGameRecord(gameId)
        if (!result.ok) {
            const errorText = result.error === Common.gameErrNotFound
                ? qsTr("Game has already been deleted")
                : qsTr("Could not delete game")
            root.reload()
            statusText.text = errorText
            return
        }
        root.reload()
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

    function participantCount(participants) {
        if (!participants) {
            return 0
        }
        return typeof participants.count === "number" ? participants.count : participants.length
    }

    function participantValue(participant, key, fallback) {
        if (!participant || participant[key] === undefined || participant[key] === null) {
            return fallback
        }
        return participant[key]
    }

    function participantText(participant) {
        const profileName = root.participantValue(participant, "profile_name", "")
        const heroName = root.participantValue(participant, "hero_name", "")
        return qsTr("%1 (%2)").arg(profileName).arg(heroName)
    }

    function participantLabel(mode, index, participant) {
        const text = root.participantText(participant)
        if (mode === "2v2") {
            return qsTr("Team %1 · %2")
                .arg(root.participantValue(participant, "team", "-"))
                .arg(text)
        }
        return qsTr("Player %1 · %2").arg(index + 1).arg(text)
    }

    function gameTitle(participants) {
        const names = []
        for (let i = 0; i < root.participantCount(participants); i++) {
            names.push(root.participantText(root.participantAt(participants, i)))
        }
        return names.join(qsTr(" vs "))
    }

    function metaText(mapName, participants) {
        const mapText = root.valueText(mapName, qsTr("Map not specified"))
        const hpValues = []
        for (let i = 0; i < root.participantCount(participants); i++) {
            const participant = root.participantAt(participants, i)
            hpValues.push(root.valueText(
                root.participantValue(participant, "hero_remaining_hp"),
                "-"
            ))
        }
        return qsTr("%1 · HP: %2").arg(mapText).arg(hpValues.join(" / "))
    }
}
