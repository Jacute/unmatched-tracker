import QtQuick
import QtQuick.Layouts

import Tracker
import "../../../../components/statistics" as Stat

Item {
    required property int heroId
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

        Item {
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: loadData()

    function loadData() {
        const res = core.getHeroCommonStats(heroId)
        if (!res.ok) {
            logger.error(
                "CommonStat",
                "error getting common hero stats",
                {
                    "source": "ui",
                    "hero_id": heroId,
                    "error": res.error,
                },
            )
            return
        }

        root.stats = res.stats
        root.hasGames = root.stats.games_played > 0
        logger.debug(
            "CommonStat",
            "got common hero stats",
            {
                "source": "ui",
                "hero_id": heroId,
                "stats": root.stats,
            },
        )
    }
}
