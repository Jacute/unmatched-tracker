function teamForParticipant(index) {
    return mode === "2v2" ? index % 2 + 1 : index + 1
}

function participantTitle(index) {
    if (mode === "2v2") {
        return qsTr("P%1\nTeam %2")
            .arg(Math.floor(index / 2) + 1)
            .arg(root.teamForParticipant(index))
    }
    return qsTr("Player %1").arg(index + 1)
}