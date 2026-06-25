import QtQuick
import QtQuick.Controls

import "../../../components"

Item {
    property int heroId: 0
    property var cardsByHeroId: ({})
    property var currentCards: []

    id: root

    ScrollView {
        id: view
        anchors.fill: parent
        clip: true
        contentWidth: availableWidth
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        CardGrid {
            model: root.currentCards
            width: view.availableWidth
            columnSpacing: 15
            rowSpacing: 5
            columns: 3
            labelPosition: "bottom"
            pressedPopup: cardPopup

            imgRadius: width / columns * 0.02

            onModelLongPressed: (index) => {
                const card = root.currentCards[index]
                if (!card) {
                    return
                }
                cardPopup.img = card.img_path
                cardPopup.text = card.card_name
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
}
