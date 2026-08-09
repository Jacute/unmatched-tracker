pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import "./GameParticipant.js" as GameParticipant

Item {
    required property string mode
    required property int playerCount

    property bool withHP: true
    property ListModel profiles: ListModel {}
    property ListModel heroes: ListModel {}

    signal profileSelectionChanged()

    id: root
    implicitHeight: participantsLayout.implicitHeight
    implicitWidth: participantsLayout.implicitWidth
    
    ColumnLayout {
        id: participantsLayout
        width: parent.width
        spacing: 10
        Repeater {
            id: participantRepeater
            model: root.playerCount

            GameParticipantInput {
                required property int index

                id: input
                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                withHP: root.withHP
                markerColor: GameParticipant.teamColor(GameParticipant.teamForParticipant(index))
                title: GameParticipant.participantTitle(index)
                profiles: root.profiles
                heroes: root.heroes
                onProfileSelectionChanged: root.profileSelectionChanged()
            }
        }
    }

    function inputAt(index) {
        return index >= 0 && index < participantRepeater.count
            ? participantRepeater.itemAt(index)
            : null
    }
}