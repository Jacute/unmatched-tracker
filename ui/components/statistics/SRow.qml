import QtQuick
import QtQuick.Layouts

import Tracker
import "./format.js" as Format

RowLayout {
    required property var stats
    required property bool hasGames

    id: root

    Layout.fillWidth: true
    spacing: 8

    Tile {
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight
        title: qsTr("GAMES")
        value: root.hasGames ? String(root.stats.games_played) : "0"
        detail: qsTr("played")
        accentColor: Common.accent
    }

    Tile {
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight
        title: qsTr("WIN RATE")
        value: Format.percent(root.stats.win_percentage)
        detail: root.hasGames
                ? qsTr("%1 wins").arg(root.stats.games_won)
                : qsTr("no games")
        accentColor: Common.success
    }

    Tile {
        Layout.fillWidth: true
        Layout.preferredHeight: implicitHeight
        title: qsTr("AVG HP IN WINS")
        description: "Statistic shows the hp percentage only in winning games where the hp parameter is set"
        value: Format.percent(root.stats.average_winning_hp)
        detail: qsTr("hero health")
        accentColor: Common.team3Color
    }
}