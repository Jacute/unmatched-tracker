import QtQuick
import QtQuick.Layouts
import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.bgColor

    property var hero1: Common.plugHero
    property var hero2: Common.plugHero
    property bool filtersVisible: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: root.height * 0.02
        spacing: root.height * 0.02

        Rectangle {
            id: filtergroup
            Layout.fillWidth: true
            Layout.preferredHeight: filterBtn.height + filterWrapper.height
            color: "transparent"
            radius: 5
            // Open filter btn
            Btn {
                id: filterBtn
                anchors.top: filtergroup.top
                anchors.left: filtergroup.left
                anchors.right: filtergroup.right
                height: root.height * 0.04
                radius: 5

                contentItem: Item {
                    anchors.fill: parent

                    Text {
                        anchors.centerIn: parent
                        text: "Filters"
                        color: Common.textColor
                        font.pixelSize: Common.defaultFontSize
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width * 0.05
                        anchors.verticalCenter: parent.verticalCenter
                        text: "›"
                        color: Common.textColor
                        font.pixelSize: 16
                        font.bold: true
                        rotation: root.filtersVisible ? 270 : 90
                        Behavior on rotation { NumberAnimation { duration: 100 } }
                    }
                }

                onClicked: root.filtersVisible = !root.filtersVisible
            }

            Rectangle {
                id: filterWrapper
                anchors {
                    top: filterBtn.bottom
                    left: parent.left
                    right: parent.right
                }

                height: root.filtersVisible ? root.height * 0.04 : 0
                color: Qt.lighter(Common.secondary, 1.25)
                clip: true

                Behavior on height {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }

                RandomFilter {
                    anchors.fill: parent
                    heroes: heroesModel
                    maps: mapsModel
                }
            }
        }

        VS {
            id: vs
            src1: root.hero1.img_path
            src2: root.hero2.img_path
            textColor: Common.textColor
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.height * 0.18
            Layout.preferredWidth: gm.implicitWidth
            color: "transparent"

            GameMap {
                id: gm
                visible: false
                anchors.fill: parent
            }

            Btn {
                id: rndMap
                anchors.fill: parent
                radius: 0
                text: "Random map"
                onClicked: {
                    if (root.hero1.name === Common.plugHero.name ||
                        root.hero2.name === Common.plugHero.name) {
                        notif.show("First you should randomize two heroes")
                        return
                    }

                    let enabledMaps = []
                    for (let i = 0; i < mapsModel.count; ++i) {
                        const map = mapsModel.get(i)

                        if (map.enabled)
                            enabledMaps.push(map)
                    }

                    gm.src = enabledMaps[Math.floor(Math.random() * enabledMaps.length)].img_path
                    gm.visible = true
                    rndMap.visible = false
                }
            }
        }

        Btn {
            id: saveBtn
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width * 0.65
            Layout.preferredHeight: root.height * 0.05
            text: "Save results"
        }

        Rectangle {
            id: delimiter
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.001
            color: Common.secondary
        }

        RandomWheel {
            id: rw
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            heroes: heroesModel
            onRandomHeroChanged: {
                if (root.hero1.img_path === Common.avatarPlug) {
                    root.hero1 = randomHero
                    let idx = root.modelFind(heroesModel, "id", randomHero)
                    heroesModel.setProperty(idx, "enabled", false)
                    return
                }
                if (root.hero2.img_path === Common.avatarPlug) {
                    root.hero2 = randomHero
                    for (let i = 0; i < heroesModel.count; i++) {
                        heroesModel.setProperty(i, "enabled", true)
                    }
                    return
                }
                root.hero1 = randomHero
                let idx = root.modelFind(heroesModel, "id", randomHero)
                heroesModel.setProperty(idx, "enabled", false)
                root.hero2 = Common.plugHero
                gm.visible = false
                rndMap.visible = true
            }
        }
    }

    Notif {
        id: notif
    }

    ListModel {
        id: heroesModel

        onDataChanged: {
            rw.heroesLoad()
            rw.paint()
        }
    }
    ListModel {
        id: mapsModel

        onDataChanged: {

        }
    }

    function loadData() {
        heroesModel.clear()
        let backHeroes = backend.getHeroes()

        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                img_path: backHeroes[i].img_path,
                enabled: true
            })
        }
        console.debug("heroes loaded " + heroesModel)

        mapsModel.clear()
        let backMaps = backend.getMaps()
        for (let i = 0; i < backMaps.length; i++) {
            mapsModel.append({
                id: backMaps[i].id,
                name: backMaps[i].name,
                img_path: backMaps[i].img_path,
                enabled: true
            })
        }
    }

    Component.onCompleted: {
        loadData()
    }

    function modelFind(model, field, value) {
        let idx = -1

        for (let i = 0; i < heroesModel.count; ++i) {
            if (heroesModel.get(i)[field] === value[field]) {
                idx = i
                break
            }
        }
        return idx
    }
}