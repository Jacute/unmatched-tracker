pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "../../components"

Rectangle {
    property int setId
    property StackView pager

    id: root
    color: "transparent"

    // grid of heroes
    ScrollView {
        id: view
        anchors {
            fill: parent
        }
        clip: true
        contentWidth: availableWidth
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        CardGrid {
            model: heroesModel
            width: parent.width - parent.height * 0.02
            columnSpacing: 15
            rowSpacing: 5
            anchors.topMargin: 15
            columns: 2

            onModelClicked: (index) => {
                root.pager.push(
                    "Hero.qml", 
                    {
                        hero: heroesModel.get(index)
                    }
                )
            }
        }
    }

    ListModel {
        id: heroesModel
    }

    onSetIdChanged: {
        console.debug("getting heroes for set id " + setId)
        heroesModel.clear()
        let backHeroes = backend.getHeroesBySetId(setId)   
        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                img_path: backHeroes[i].img_path
            })
        }
    }
}