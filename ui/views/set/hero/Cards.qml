import QtQuick

import "../../../components"

Item {
    id: root
    CardGrid {
        model: cardModel
        width: parent.width
        columnSpacing: 15
        rowSpacing: 5
        columns: 3
        labelPosition: "bottom"

        imgRadius: width / columns * 0.02
        cardImgFillMode: Image.Stretch
    }

    ListModel {
        id: cardModel
        ListElement {
            name: "x2"
            img_path: "qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/1.png"
        }
        ListElement {
            name: "x2"
            img_path: "qrc:/qt/qml/Tracker/ui/assets/img/set/battle_of_legends1/heroes/sinbad/cards/2.png"
        }
    }
}