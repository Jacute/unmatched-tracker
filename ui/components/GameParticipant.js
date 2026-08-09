function teamForParticipant(index) {
    return mode === "2v2" ? index % 2 + 1 : index + 1
}

function participantTitle(index) {
    if (mode === "2v2") {
        return qsTr("P%1\nTeam %2")
            .arg(Math.floor(index / 2) + 1)
            .arg(teamForParticipant(index))
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