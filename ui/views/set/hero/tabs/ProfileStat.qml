import QtQuick
import QtQuick.Layouts

import Tracker
import "../../../../components/statistics" as Stat

Item {
    required property int heroId
    readonly property string mode: "1v1"
    property var stats: ({})
    property bool hasGames: false
    readonly property bool hasDatedGames: root.stats.first_played_at !== undefined
                                          && root.stats.first_played_at !== ""
                                          && root.stats.last_played_at !== undefined
                                          && root.stats.last_played_at !== ""

    id: root

    ColumnLayout {
        anchors {
            fill: parent
            margins: Common.pageMargin
        }
        spacing: Common.fieldSpacing

        Stat.SRow {
            Layout.preferredHeight: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            stats: root.stats
            hasGames: root.hasGames
        }

        RowLayout {
            Layout.preferredHeight: root.hasDatedGames ? 100 : 0
            Layout.fillWidth: true
            spacing: Common.fieldSpacing
            visible: root.hasDatedGames

            Stat.Tile {
                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                title: qsTr("FIRST GAME")
                value: root.stats.first_played_at || ""
                detail: qsTr("played date")
                accentColor: Common.accent
            }

            Stat.Tile {
                Layout.fillWidth: true
                Layout.preferredHeight: implicitHeight
                title: qsTr("LAST GAME")
                value: root.stats.last_played_at || ""
                detail: qsTr("played date")
                accentColor: Common.success
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: loadData()

    function loadData() {
        let res = core.getProfileHeroStats(heroId, mode)
        if (!res.ok) {
            logger.warning(
                "ProfileStat",
                "error getting profile hero stats",
                {
                    "source": "ui",
                    "hero_id": heroId,
                    "error": res.error,
                },
            )
            return
        }
        root.stats = res.stats
        logger.debug(
            "ProfileStat",
            "got profile stats",
            {
                "source": "ui",
                "stats": stats,
            },
        )
        if (root.stats.games_played > 0) {
            root.hasGames = true
        }
    }
}
