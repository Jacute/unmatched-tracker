pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtMultimedia

import Tracker
import "../../components/timer" as TimerUi
import "../../components/GameParticipant.js" as GameParticipant

Rectangle {
    required property var configuration

    property string mode: "1v1"
    property int activeIndex: -1
    property int turnOwnerIndex: -1
    property int defenderIndex: -1
    property int turnNumber: 1
    property string phase: "turn"
    property bool paused: false
    property double lastTickMs: 0
    property int currentRemainingMs: 0
    property int turnIncrementMs: 0
    property int defenseIncrementMs: 0
    property bool turnIncrementCapped: false
    property bool defenseIncrementCapped: false
    property bool activeTimedOut: false
    readonly property int participantCount: participantsModel.count
    readonly property bool keepAwakeRequired: visible && StackView.status === StackView.Active

    Component.onDestruction: keepAwakeHelper.disable()
    onKeepAwakeRequiredChanged: {
        if (keepAwakeRequired) {
            keepAwakeHelper.enable()
        } else {
            keepAwakeHelper.disable()
        }
    }

    id: root
    color: Common.bgColor
    clip: true

    Repeater {
        model: participantsModel

        TimerUi.TimerHeroPane {
            required property int index
            required property int team

            x: root.paneX(index)
            y: root.paneY(index)
            width: root.paneWidth(index)
            height: root.paneHeight(index)
            active: index === root.activeIndex
            flipped: root.paneIsTop(index)
            markerColor: GameParticipant.teamColor(team)
        }
    }

    Item {
        id: actionLayer
        x: root.activeIndex >= 0 ? root.paneX(root.activeIndex) : 0
        y: root.activeIndex >= 0 ? root.paneY(root.activeIndex) : 0
        width: root.activeIndex >= 0 ? root.paneWidth(root.activeIndex) : 0
        height: root.activeIndex >= 0 ? root.paneHeight(root.activeIndex) : 0
        visible: root.activeIndex >= 0 && !root.paused
        z: 10

        Row {
            anchors.centerIn: parent
            spacing: Math.max(10, actionLayer.width * 0.04)
            rotation: root.paneIsTop(root.activeIndex) ? 180 : 0

            TimerUi.TimerActionButton {
                width: root.actionButtonSize(actionLayer.width, actionLayer.height)
                height: width
                visible: root.phase === "turn" && !root.activeTimedOut
                iconSource: Common.imgPrefix + "/ui/timer/attack.webp"

                onClicked: root.requestAttack()
            }

            TimerUi.TimerActionButton {
                width: root.actionButtonSize(actionLayer.width, actionLayer.height)
                height: width
                visible: root.phase === "turn"
                iconSource: Common.imgPrefix + "/ui/timer/turn.webp"

                onClicked: root.endTurn()
            }

            TimerUi.TimerActionButton {
                width: root.actionButtonSize(actionLayer.width, actionLayer.height)
                height: width
                visible: root.phase === "defense"
                iconSource: Common.imgPrefix + "/ui/timer/defense.webp"

                onClicked: root.finishDefense()
            }
        }
    }

    TimerUi.TimerCenterPanel {
        anchors.centerIn: parent
        width: Math.min(root.width * 0.43, 170)
        height: Math.min(root.height * 0.18, 120)
        heroName: root.activeHeroName()
        timeText: root.formatTime(root.currentRemainingMs)
        turnNumber: root.turnNumber
        paused: root.paused
        flipped: root.activeIndex >= 0 && root.paneIsTop(root.activeIndex)
        z: 20

        onPauseClicked: root.togglePause()
    }

    TimerUi.TimerTargetPicker {
        id: targetPicker

        onTargetSelected: (participantIndex) => {
            root.beginDefense(participantIndex)
        }
    }

    SoundEffect {
        id: attackSound
        source: Common.audioPrefix + "/timer/attack.wav"
    }

    SoundEffect {
        id: defenseSound
        source: Common.audioPrefix + "/timer/defense.wav"
    }

    SoundEffect {
        id: turnSound
        source: Common.audioPrefix + "/timer/turn.wav"
    }

    SoundEffect {
        id: timerFinishedSound
        source: Common.audioPrefix + "/timer/timer_finished.wav"
    }

    Timer {
        interval: 100
        repeat: true
        running: root.participantCount > 0
            && !root.paused
            && root.activeIndex >= 0
            && root.currentRemainingMs > 0

        onTriggered: root.settleClock()
    }

    ListModel { id: participantsModel }

    Component.onCompleted: initialize()

    function initialize() {
        keepAwakeHelper.enable()
        participantsModel.clear()
        if (!configuration || !configuration.participants) {
            paused = true
            return
        }

        mode = configuration.mode || "1v1"
        turnIncrementMs = Math.max(0, configuration.turnIncrementSeconds || 0) * 1000
        defenseIncrementMs = Math.max(0, configuration.defenseIncrementSeconds || 0) * 1000
        turnIncrementCapped = configuration.turnIncrementCapped || false
        defenseIncrementCapped = configuration.defenseIncrementCapped || false
        const startMs = Math.max(0, configuration.startSeconds || 0) * 1000

        for (let i = 0; i < configuration.participants.length; ++i) {
            const participant = configuration.participants[i]
            participantsModel.append({
                heroId: participant.heroId,
                heroName: participant.heroName,
                imgPath: participant.imgPath,
                team: participant.team,
                mainRemainingMs: startMs,
                turnBonusRemainingMs: 0,
                defenseBonusRemainingMs: 0,
                timedOut: false
            })
        }

        if (participantsModel.count === 0) {
            paused = true
            return
        }

        turnNumber = 1
        phase = "turn"
        turnOwnerIndex = 0
        defenderIndex = -1
        paused = false
        activateParticipant(turnOwnerIndex)
    }

    function settleClock() {
        if (paused || activeIndex < 0 || lastTickMs <= 0 || activeTimedOut) {
            return
        }

        const now = Date.now()
        const elapsed = Math.max(0, now - lastTickMs)
        lastTickMs = now
        if (elapsed < 1) {
            return
        }

        consumeTime(activeIndex, elapsed)

        // timer end
        if (currentRemainingMs <= 0) {
            markParticipantTimedOut(activeIndex)
        }
    }

    function togglePause() {
        if (activeIndex < 0) {
            return
        }

        if (paused) {
            lastTickMs = Date.now()
            paused = false
            return
        }

        settleClock()
        paused = true
    }

    function requestAttack() {
        if (paused || phase !== "turn" || activeTimedOut) {
            return
        }

        const candidates = attackCandidates()
        if (candidates.length === 1) {
            beginDefense(candidates[0].participantIndex)
            return
        }
        if (candidates.length > 1) {
            targetPicker.openFor(candidates, paneIsTop(turnOwnerIndex))
        }
    }

    function beginDefense(participantIndex) {
        if (paused || phase !== "turn" || participantTimedOut(turnOwnerIndex)
                || participantIndex < 0
                || participantIndex >= participantsModel.count) {
            return
        }

        settleClock()
        if (paused || participantTimedOut(turnOwnerIndex)) {
            return
        }

        applyDefenseIncrement(participantIndex)
        phase = "defense"
        defenderIndex = participantIndex
        activateParticipant(defenderIndex)
        attackSound.play()
    }

    function finishDefense() {
        if (paused || phase !== "defense") {
            return
        }

        settleClock()
        if (paused) {
            return
        }

        if (defenseIncrementCapped) {
            participantsModel.setProperty(defenderIndex, "defenseBonusRemainingMs", 0)
        }
        phase = "turn"
        defenderIndex = -1
        activateParticipant(turnOwnerIndex)
        defenseSound.play()
    }

    function endTurn() {
        if (paused || phase !== "turn" || turnOwnerIndex < 0) {
            return
        }

        settleClock()
        if (paused) {
            return
        }

        applyTurnIncrement(turnOwnerIndex)
        const nextTurnOwnerIndex = (turnOwnerIndex + 1) % participantsModel.count
        if (nextTurnOwnerIndex === 0) {
            turnNumber += 1
        }
        turnOwnerIndex = nextTurnOwnerIndex
        defenderIndex = -1
        phase = "turn"
        activateParticipant(turnOwnerIndex)
        turnSound.play()
    }

    function activateParticipant(index) {
        activeIndex = index
        activeTimedOut = participantTimedOut(index)
        currentRemainingMs = activeTimedOut ? 0 : displayedRemainingAt(index)
        lastTickMs = Date.now()
    }

    function attackCandidates() {
        const candidates = []
        if (turnOwnerIndex < 0 || turnOwnerIndex >= participantsModel.count) {
            return candidates
        }

        const attackerTeam = participantsModel.get(turnOwnerIndex).team
        for (let i = 0; i < participantsModel.count; ++i) {
            if (i === turnOwnerIndex) {
                continue
            }

            const participant = participantsModel.get(i)
            if (mode === "2v2" && participant.team === attackerTeam) {
                continue
            }

            candidates.push({
                participantIndex: i,
                heroName: participant.heroName,
                imgPath: participant.imgPath
            })
        }
        return candidates
    }

    function displayedRemainingAt(index) {
        if (index < 0 || index >= participantsModel.count) {
            return 0
        }

        const participant = participantsModel.get(index)
        if (participant.timedOut) {
            return 0
        }

        let remaining = participant.mainRemainingMs
        if (phase === "turn" && turnIncrementCapped) {
            remaining += participant.turnBonusRemainingMs
        } else if (phase === "defense" && defenseIncrementCapped) {
            remaining += participant.defenseBonusRemainingMs
        }
        return remaining
    }

    function consumeTime(index, elapsed) {
        if (index < 0 || index >= participantsModel.count) {
            return
        }
        if (participantTimedOut(index)) {
            currentRemainingMs = 0
            return
        }

        let remainingElapsed = Math.max(0, elapsed)
        if (phase === "turn" && turnIncrementCapped) {
            remainingElapsed = consumeBonus(
                index,
                "turnBonusRemainingMs",
                remainingElapsed
            )
        } else if (phase === "defense" && defenseIncrementCapped) {
            remainingElapsed = consumeBonus(
                index,
                "defenseBonusRemainingMs",
                remainingElapsed
            )
        }

        if (remainingElapsed > 0) {
            const mainRemaining = participantsModel.get(index).mainRemainingMs
            participantsModel.setProperty(
                index,
                "mainRemainingMs",
                Math.max(0, Math.round(mainRemaining - remainingElapsed))
            )
        }

        currentRemainingMs = displayedRemainingAt(index)
    }

    function consumeBonus(index, role, elapsed) {
        const participant = participantsModel.get(index)
        const bonus = role === "turnBonusRemainingMs"
            ? participant.turnBonusRemainingMs
            : participant.defenseBonusRemainingMs
        const consumed = Math.min(bonus, elapsed)
        participantsModel.setProperty(
            index,
            role,
            Math.max(0, Math.round(bonus - consumed))
        )
        return elapsed - consumed
    }

    function applyTurnIncrement(index) {
        if (participantTimedOut(index)) {
            return
        }

        if (turnIncrementCapped) {
            participantsModel.setProperty(
                index,
                "turnBonusRemainingMs",
                turnIncrementMs
            )
        } else {
            addToMainTime(index, turnIncrementMs)
        }
    }

    function applyDefenseIncrement(index) {
        if (participantTimedOut(index)) {
            return
        }

        if (defenseIncrementCapped) {
            participantsModel.setProperty(
                index,
                "defenseBonusRemainingMs",
                defenseIncrementMs
            )
        } else {
            addToMainTime(index, defenseIncrementMs)
        }
    }

    function addToMainTime(index, value) {
        if (index < 0 || index >= participantsModel.count
                || participantTimedOut(index)) {
            return
        }

        const participant = participantsModel.get(index)
        participantsModel.setProperty(
            index,
            "mainRemainingMs",
            participant.mainRemainingMs + value
        )
    }

    function participantTimedOut(index) {
        if (index < 0 || index >= participantsModel.count) {
            return false
        }
        return participantsModel.get(index).timedOut || false
    }

    function markParticipantTimedOut(index) {
        if (index < 0 || index >= participantsModel.count
                || participantTimedOut(index)) {
            return
        }

        participantsModel.setProperty(index, "timedOut", true)
        participantsModel.setProperty(index, "mainRemainingMs", 0)
        participantsModel.setProperty(index, "turnBonusRemainingMs", 0)
        participantsModel.setProperty(index, "defenseBonusRemainingMs", 0)

        if (index === activeIndex) {
            activeTimedOut = true
            currentRemainingMs = 0
        }

        timerFinishedSound.play()
    }

    function activeHeroName() {
        if (activeIndex < 0 || activeIndex >= participantsModel.count) {
            return ""
        }
        return participantsModel.get(activeIndex).heroName
    }

    function formatTime(milliseconds) {
        const totalSeconds = Math.max(0, Math.ceil(milliseconds / 1000))
        const minutes = Math.floor(totalSeconds / 60)
        const seconds = totalSeconds % 60
        return twoDigits(minutes) + ":" + twoDigits(seconds)
    }

    function twoDigits(value) {
        return value < 10 ? "0" + value : String(value)
    }

    function visualSlot(index) {
        if (mode === "2v2" && participantCount === 4) {
            const slots = [0, 2, 1, 3]
            return slots[index]
        }
        return index
    }

    function paneIsTop(index) {
        const slot = visualSlot(index)
        if (participantCount === 3) {
            return slot === 0
        }
        return slot < Math.ceil(participantCount / 2)
    }

    function paneX(index) {
        const slot = visualSlot(index)
        if (participantCount <= 2 || (participantCount === 3 && slot === 0)) {
            return 0
        }
        if (participantCount === 3) {
            return (slot - 1) * width / 2
        }
        return (slot % 2) * width / 2
    }

    function paneY(index) {
        return paneIsTop(index) ? 0 : height / 2
    }

    function paneWidth(index) {
        const slot = visualSlot(index)
        if (participantCount <= 2 || (participantCount === 3 && slot === 0)) {
            return width
        }
        return width / 2
    }

    function paneHeight(index) {
        return height / 2
    }

    function actionButtonSize(areaWidth, areaHeight) {
        return Math.max(52, Math.min(92, areaWidth * 0.28, areaHeight * 0.3))
    }
}
