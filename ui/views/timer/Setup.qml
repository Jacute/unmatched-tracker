pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../../components"
import "../../components/fields" as Fields
import "../../core/client.js" as CoreClient

Rectangle {
    signal startRequested(var configuration)

    property string validationMessage: ""

    id: root
    color: Common.bgColor

    ColumnLayout {
        anchors {
            fill: parent
            margins: Common.pageMargin
        }
        spacing: Common.fieldSpacing

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentWidth: availableWidth
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: parent.width
                spacing: Common.fieldSpacing

                GameModeComboBox {
                    id: gameMode
                    Layout.fillWidth: true
                    Layout.preferredHeight: 68

                    onActiveGameModeChanged: root.validationMessage = ""
                }

                GameParticipantInputGroup {
                    id: participantGroup
                    Layout.fillWidth: true
                    Layout.preferredHeight: implicitHeight
                    withHP: false

                    mode: Common.gameModesModel.get(gameMode.activeGameMode).code
                    playerCount: Common.gameModesModel.get(gameMode.activeGameMode).playerCount
                    heroes: heroesModel
                }

                Fields.TimeField {
                    id: startTime
                    Layout.fillWidth: true
                    label: qsTr("Start time")
                    defaultTime: gameMode.modeCode === "2v2" ? "20:00" : "10:00"
                }

                Fields.TimeField {
                    id: turnIncrement
                    Layout.fillWidth: true
                    label: qsTr("Additional time after turn")
                    defaultTime: gameMode.modeCode === "2v2" ? "00:20" : "00:45"
                }

                Fields.TimeField {
                    id: defenseIncrement
                    Layout.fillWidth: true
                    label: qsTr("Additional time after attack")
                    defaultTime: "00:00"
                }

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 2
                }
            }
        }

        Text {
            Layout.fillWidth: true
            visible: text.length > 0
            text: root.validationMessage
            color: Common.error
            font.pixelSize: Common.defaultFontSize * 0.82
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Btn {
            Layout.fillWidth: true
            Layout.preferredHeight: Common.defaultFontSize * 3.4
            enabled: heroesModel.count > 0
            radius: Common.defaultRadius
            text: qsTr("Start timer")
            bgColor: Common.accent
            bgColorPressed: Common.accentHover
            txtColor: Common.primary
            borderWidth: 0

            onClicked: root.startTimer()
        }
    }

    ListModel { id: heroesModel }

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
        if (heroesModel.count === 0) {
            CoreClient.loadHeroes(core, heroesModel)
        }
    }

    function startTimer() {
        validationMessage = ""

        const mode = Common.gameModesModel.get(gameMode.activeGameMode)
        const participants = []

        for (let i = 0; i < mode.playerCount; ++i) {
            const input = participantGroup.inputAt(i)
            if (!input || input.heroIndex < 0 || input.heroIndex >= heroesModel.count) {
                validationMessage = qsTr("Select a hero for every player")
                return
            }

            const hero = heroesModel.get(input.heroIndex)
            participants.push({
                heroId: hero.id,
                heroName: hero.name,
                imgPath: hero.img_path,
                team: mode.code === "2v2" ? i % 2 + 1 : i + 1
            })
        }

        const startSeconds = startTime.seconds()
        const turnIncrementSeconds = turnIncrement.seconds()
        const defenseIncrementSeconds = defenseIncrement.seconds()
        if (startSeconds <= 0 || turnIncrementSeconds < 0 || defenseIncrementSeconds < 0) {
            validationMessage = qsTr("Enter a valid time in MM:SS format")
            return
        }

        root.startRequested({
            mode: mode.code,
            startSeconds: startSeconds,
            turnIncrementSeconds: turnIncrementSeconds,
            defenseIncrementSeconds: defenseIncrementSeconds,
            participants: participants
        })
    }
}
