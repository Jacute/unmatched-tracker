pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15

import Tracker
import "../../../components"
import "."

Rectangle {
    required property int setId
    property int heroInd: 0
    property int activeTabInd: 0

    id: root
    color: "transparent"

    Repeater {
        id: heroPageRepeater
        model: heroesModel

        Item {
            required property int index
            required property var modelData

            id: heroPage
            anchors.fill: parent
            visible: index === root.heroInd

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // Hero avatar
                Avatar {
                    imgPath: heroPage.modelData.img_path
                    heroesCount: heroesModel.count
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.height * 0.4
                    clip: true

                    onSwitchHero: (offset) => {
                        if (heroesModel.count <= 1) {
                            return
                        }

                        root.heroInd = (root.heroInd + offset + heroesModel.count) % heroesModel.count
                    }
                }

                // Hero menu
                TabMenu {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.height * 0.05
                    spacing: 0
                    
                    tabs: tabsModel
                    activeTabInd: root.activeTabInd
                    onChangeActiveTabInd: (tabInd) => {
                        root.activeTabInd = tabInd
                    }
                }                

                // Page body - information about hero
                Item {
                    id: body

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Repeater {
                        model: tabsModel

                        Loader {
                            required property int index
                            required property var modelData

                            anchors.fill: parent
                            source: modelData.path
                            visible: index === root.activeTabInd
                            asynchronous: true

                            onLoaded: {
                                console.debug("Hero tab loaded: ", item)
                                root.setLoadedSectionCtx(item, heroPage.modelData)
                            }
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: tabsModel
        ListElement {
            text: qsTr("Overview and Cards")
            path: "tabs/Cards.qml"
        }
        ListElement {
            text: qsTr("Global Stats")
            path: "tabs/CommonStat.qml"
        }
        ListElement {
            text: qsTr("Profile Stats")
            path: "tabs/ProfileStat.qml"
        }
        ListElement {
            text: qsTr("Matchups")
            path: "tabs/Matchups.qml"
        }
    }

    ListModel {
        id: heroesModel
        dynamicRoles: true
    }

    onSetIdChanged: {
        console.debug("getting heroes for set id " + setId)
        heroesModel.clear()
        let backHeroes = core.getHeroesBySetId(setId)   
        root.heroInd = 0
        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                hp: backHeroes[i].hp,
                move: backHeroes[i].move,
                img_path: backHeroes[i].img_path,
                ability: backHeroes[i].ability,
                attack_type: backHeroes[i].attack_type,
                assistants: backHeroes[i].assistants
            })
        }
    }

    function setLoadedSectionCtx(page, heroData) {
        if (!page) {
            return
        }

        if (typeof page.heroId !== "undefined") {
            page.heroId = heroData.id
        }
        if (typeof page.heroData !== "undefined") {
            page.heroData = heroData
        }
    }

}
