import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../../../../components/info" as Info

Item {
    required property int heroId
    property int activeMode: 0
    property bool defaultProfileSelected: true

    id: root

    ListModel {
        id: matchupsModel
    }

    ListModel {
        id: unplayedMatchupsModel
    }

    RowLayout {
        anchors {
            top: parent.top
            left: parent.left
            topMargin: Common.pageMargin / 2
            leftMargin: Common.pageMargin
        }
        width: Math.min(280, parent.width - Common.pageMargin * 2 - 34)
        height: 30
        spacing: 0

        Btn {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Win rates")
            fontSize: Common.defaultFontSize * 0.82
            radius: 6
            bgColor: root.activeMode === 0 ? Common.secondary : Common.primary
            borderColor: root.activeMode === 0 ? Common.accent : Common.imagePlaceholderSoft

            onClicked: root.activeMode = 0
        }

        Btn {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Unplayed")
            fontSize: Common.defaultFontSize * 0.82
            radius: 6
            bgColor: root.activeMode === 1 ? Common.secondary : Common.primary
            borderColor: root.activeMode === 1 ? Common.accent : Common.imagePlaceholderSoft

            onClicked: root.activeMode = 1
        }
    }

    ListView {
        id: matchupsList
        anchors {
            fill: parent
            leftMargin: Common.pageMargin
            rightMargin: Common.pageMargin
            bottomMargin: Common.pageMargin
            topMargin: Common.pageMargin + 38
        }
        spacing: Common.fieldSpacing
        clip: true
        model: root.activeMode === 0 ? matchupsModel : unplayedMatchupsModel
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }

        delegate: Rectangle {
            required property var model
            readonly property bool unplayed: root.activeMode === 1
            readonly property real winRate: Number(model.win_percentage)
            readonly property bool lowConfidence: !unplayed && Number(model.games_played) < 5
            readonly property color rateColor: unplayed ? Common.accent : root.winRateColor(winRate)

            width: matchupsList.width
            height: Math.max(72, Common.defaultFontSize * 4.5)
            radius: 8
            color: Common.secondary
            border.width: 1
            border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
            clip: true

            Rectangle {
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 4
                color: parent.rateColor
            }

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 14
                    rightMargin: 16
                    topMargin: 10
                    bottomMargin: 10
                }
                spacing: 12

                Rectangle {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    radius: 6
                    color: Common.imagePlaceholder
                    clip: true

                    LoadImage {
                        anchors.fill: parent
                        imgPath: model.hero_img_path || ""
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 3

                    Text {
                        Layout.fillWidth: true
                        text: model.hero_name
                        color: Common.textColor
                        font.pixelSize: Common.defaultFontSize
                        font.bold: true
                        elide: Text.ElideRight
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 5

                        Rectangle {
                            Layout.preferredWidth: 7
                            Layout.preferredHeight: 7
                            radius: width / 2
                            color: Common.warning
                            visible: lowConfidence
                        }

                        Text {
                            Layout.fillWidth: true
                            text: unplayed
                                  ? qsTr("Not played")
                                  : lowConfidence
                                  ? qsTr("%1 games - low confidence").arg(model.games_played)
                                  : qsTr("%1 games").arg(model.games_played)
                            color: unplayed
                                   ? Common.textHint
                                   : lowConfidence ? Common.warning : Common.textSecondary
                            font.pixelSize: Common.defaultFontSize * 0.82
                            elide: Text.ElideRight
                        }
                    }
                }

                Text {
                    Layout.preferredWidth: Math.max(64, implicitWidth)
                    text: unplayed
                          ? qsTr("NEW")
                          : winRate.toLocaleString(Qt.locale(), "f", 1) + "%"
                    color: rateColor
                    font.pixelSize: unplayed
                                    ? Common.defaultFontSize * 0.85
                                    : Common.defaultFontSize * 1.25
                    font.bold: true
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        Text {
            anchors.centerIn: parent
            visible: matchupsList.count === 0
            text: root.emptyStateText()
            color: Common.textHint
            font.pixelSize: Common.defaultFontSize
        }
    }

    Info.Tooltip {
        anchors {
            top: parent.top
            topMargin: Common.pageMargin / 2
            right: parent.right
            rightMargin: Common.pageMargin
        }
        description: root.activeMode === 0
                     ? qsTr("Statistics are calculated across all profiles for 1 vs 1 games only")
                     : qsTr("Unplayed matchups are determined from the default profile's 1 vs 1 game history")
    }

    Component.onCompleted: {
        loadData()
        loadUnplayedData()
    }

    function loadData() {
        const res = core.getHeroMatchups(heroId)
        if (!res.ok) {
            logger.error(
                "Matchups",
                "error getting hero matchups",
                {
                    "source": "ui",
                    "hero_id": heroId,
                    "error": res.error,
                },
            )
            return
        }

        matchupsModel.clear()
        for (let i = 0; i < res.matchups.length; ++i) {
            matchupsModel.append(res.matchups[i])
        }
        logger.debug(
            "Matchups",
            "got hero matchups",
            {
                "source": "ui",
                "hero_id": heroId,
                "matchups_count": matchupsModel.count,
            },
        )
    }

    function loadUnplayedData() {
        const res = core.getUnplayedHeroMatchups(heroId)
        if (!res.ok) {
            logger.error(
                "Matchups",
                "error getting unplayed hero matchups",
                {
                    "source": "ui",
                    "hero_id": heroId,
                    "error": res.error,
                },
            )
            return
        }

        root.defaultProfileSelected = res.profile_selected
        unplayedMatchupsModel.clear()
        for (let i = 0; i < res.matchups.length; ++i) {
            unplayedMatchupsModel.append(res.matchups[i])
        }
        logger.debug(
            "Matchups",
            "got unplayed hero matchups",
            {
                "source": "ui",
                "hero_id": heroId,
                "matchups_count": unplayedMatchupsModel.count,
            },
        )
    }

    function emptyStateText() {
        if (root.activeMode === 0) {
            return qsTr("No matchup data yet")
        }
        if (!root.defaultProfileSelected) {
            return qsTr("Select a default profile in Settings")
        }
        return qsTr("All matchups have been played")
    }

    function winRateColor(rate) {
        const clamped = Math.max(0, Math.min(100, rate))
        if (clamped <= 50) {
            return mixColor(Common.error, Common.warning, clamped / 50)
        }
        return mixColor(Common.warning, Common.success, (clamped - 50) / 50)
    }

    function mixColor(from, to, amount) {
        return Qt.rgba(
            from.r + (to.r - from.r) * amount,
            from.g + (to.g - from.g) * amount,
            from.b + (to.b - from.b) * amount,
            1,
        )
    }
}
