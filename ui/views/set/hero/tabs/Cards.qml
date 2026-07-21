pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Tracker
import "../../../../components"

Item {
    property int heroId: 0
    property var heroData: ({})
    property var cardsByHeroId: ({})
    property var currentCards: []
    readonly property var assistants: heroData.assistants || []
    readonly property int assistantsCount: assistants.count !== undefined
                                           ? assistants.count
                                           : assistants.length || 0

    id: root

    ScrollView {
        id: view
        anchors.fill: parent
        clip: true
        contentWidth: availableWidth
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        Column {
            width: view.availableWidth
            spacing: 10
            topPadding: 10

            Text {
                width: parent.width - 16
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Hero")
                color: Common.textSecondary
                font.pixelSize: 12
                font.bold: true
            }

            Rectangle {
                width: parent.width - 16
                height: heroInfoContent.implicitHeight + 24
                anchors.horizontalCenter: parent.horizontalCenter
                color: Common.primary
                radius: 8
                border.width: 1
                border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)

                ColumnLayout {
                    id: heroInfoContent
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        margins: 12
                    }
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        Repeater {
                            model: [
                                {
                                    label: qsTr("ATTACK"),
                                    value: root.attackTypeName(root.heroData.attack_type),
                                    color: root.heroData.attack_type == 'r' ? Common.accent : Common.team2Color
                                },
                                {
                                    label: qsTr("MOVE"),
                                    value: root.valueOrDash(root.heroData.move),
                                    color: Common.team3Color
                                },
                                {
                                    label: qsTr("HEALTH"),
                                    value: root.valueOrDash(root.heroData.hp),
                                    color: Common.success
                                }
                            ]

                            Item {
                                required property int index
                                required property var modelData

                                Layout.fillWidth: true
                                Layout.preferredHeight: 48

                                Column {
                                    anchors.centerIn: parent
                                    width: parent.width - 8
                                    spacing: 2

                                    Text {
                                        width: parent.width
                                        text: parent.parent.modelData.label
                                        color: Common.textHint
                                        font.pixelSize: 11
                                        font.bold: true
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Text {
                                        width: parent.width
                                        text: parent.parent.modelData.value
                                        color: parent.parent.modelData.color
                                        font.pixelSize: 21
                                        font.bold: true
                                        horizontalAlignment: Text.AlignHCenter
                                        elide: Text.ElideRight
                                    }
                                }

                                Rectangle {
                                    anchors {
                                        top: parent.top
                                        right: parent.right
                                        bottom: parent.bottom
                                    }
                                    visible: parent.index < 2
                                    width: 1
                                    color: Common.secondary
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: Common.secondary
                    }

                    Text {
                        Layout.fillWidth: true
                        text: qsTr("ABILITY")
                        color: Common.accent
                        font.pixelSize: 12
                        font.bold: true
                    }

                    Text {
                        Layout.fillWidth: true
                        text: root.heroData.ability || qsTr("Not specified")
                        color: root.heroData.ability ? Common.textColor : Common.textHint
                        font.pixelSize: 14
                        wrapMode: Text.WordWrap
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: Common.secondary
                    }

                    Text {
                        Layout.fillWidth: true
                        text: qsTr("SIDEKICKS")
                        color: Common.accent
                        font.pixelSize: 12
                        font.bold: true
                    }

                    Text {
                        Layout.fillWidth: true
                        visible: root.assistantsCount === 0
                        text: qsTr("No sidekicks")
                        color: Common.textHint
                        font.pixelSize: 14
                    }

                    Repeater {
                        model: root.assistants

                        RowLayout {
                            required property var modelData

                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                Layout.fillWidth: true
                                text: parent.modelData.name
                                color: Common.textColor
                                font.pixelSize: 15
                                font.bold: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "×" + parent.modelData.count
                                color: Common.textSecondary
                                font.pixelSize: 14
                            }

                            Text {
                                text: root.attackTypeName(parent.modelData.attack_type)
                                color: Common.accentHover
                                font.pixelSize: 14
                            }

                            Text {
                                text: qsTr("%1 HP").arg(parent.modelData.hp_per_one)
                                color: Common.success
                                font.pixelSize: 14
                                font.bold: true
                            }
                        }
                    }
                }
            }

            Text {
                width: parent.width - 16
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Cards")
                color: Common.textSecondary
                font.pixelSize: 12
                font.bold: true
            }

            CardGrid {
                model: root.currentCards
                width: parent.width
                columnSpacing: 0
                rowSpacing: 0
                columns: 3
                topPadding: 0
                cellHeightRatio: 1.6
                labelPosition: "bottom"
                clickedPopup: cardPopup

                imgRadius: width / columns * 0.02

                onModelClicked: (index) => {
                    const card = root.currentCards[index]
                    if (!card) {
                        return
                    }
                    cardPopup.img = card.img_path
                    cardPopup.text = card.card_name
                }
            }
        }
    }

    BigImagePopup {
        id: cardPopup
    }

    onHeroIdChanged: loadCards()
    Component.onCompleted: loadCards()

    function loadCards() {
        if (root.heroId <= 0) {
            root.currentCards = []
            return
        }

        const key = String(root.heroId)
        if (root.cardsByHeroId[key]) {
            root.currentCards = root.cardsByHeroId[key]
            return
        }

        const cards = core.getCardsByHeroId(root.heroId)
        const mappedCards = []
        for (let i = 0; i < cards.length; i++) {
            mappedCards.push({
                id: cards[i].id,
                name: "x" + cards[i].count,
                card_name: cards[i].name,
                description: cards[i].description,
                count: cards[i].count,
                img_path: cards[i].img_path,
                hero_id: cards[i].hero_id,
                card_type_id: cards[i].card_type_id
            })
        }
        root.cardsByHeroId[key] = mappedCards
        root.currentCards = mappedCards
    }

    function attackTypeName(attackType) {
        if (attackType === "m") {
            return qsTr("Melee")
        }
        if (attackType === "r") {
            return qsTr("Ranged")
        }
        return "-"
    }

    function valueOrDash(value) {
        return value === undefined || value === null || value === "" ? "-" : String(value)
    }
}
