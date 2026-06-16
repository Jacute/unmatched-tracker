import QtQuick
import QtQuick.Controls

import "../../../components"

Item {
    property int heroId: 0

    id: root

    ScrollView {
        id: view
        anchors.fill: parent
        clip: true
        contentWidth: availableWidth
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        CardGrid {
            model: cardModel
            width: view.availableWidth
            columnSpacing: 15
            rowSpacing: 5
            columns: 3
            labelPosition: "bottom"

            imgRadius: width / columns * 0.02
        }
    }

    ListModel {
        id: cardModel
    }

    onHeroIdChanged: loadCards()
    Component.onCompleted: loadCards()

    function loadCards() {
        cardModel.clear()
        if (root.heroId <= 0) {
            return
        }

        const cards = backend.getCardsByHeroId(root.heroId)
        for (let i = 0; i < cards.length; i++) {
            cardModel.append({
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
    }
}
