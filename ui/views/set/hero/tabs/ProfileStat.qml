import QtQuick
import QtQuick.Layouts

import Tracker
import "../../../../components/statistics" as Stat

Item {
    required property int heroId
    readonly property string mode: "1v1"
    property var stats: ({})
    property bool hasGames: false

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
    }

    Component.onCompleted: loadData()

    function loadData() {
        let res = core.getProfileHeroStats(heroId, mode)
        if (!res.ok) {
            console.error("[ProfileStat] " + res.error)
            return
        }
        root.stats = res.stats
        console.debug("[ProfileStat] stats:", JSON.stringify(stats))
        if (root.stats.games_played > 0) {
            root.hasGames = true
        }
    }
}
