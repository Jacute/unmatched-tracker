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

    Rectangle {
        id: filtergroup
        width: root.width * 0.96
        height: filterBtn.height + filterWrapper.height
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: root.top
        anchors.topMargin: root.height * 0.02
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

            height: root.filtersVisible ? root.height * 0.1 : 0
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
                sets: setModel
            }
        }
    }

    ColumnLayout {
        anchors {
            top: filtergroup.bottom
            left: root.left
            right: root.right
            bottom: root.bottom
            margins: root.height * 0.02
        }
        spacing: root.height * 0.02

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

                    const enabledMaps = root.getEnabledMaps()
                    if (enabledMaps.length === 0) {
                        notif.show("No maps available")
                        return
                    }

                    const randomMap = enabledMaps[Math.floor(Math.random() * enabledMaps.length)]
                    gm.src = randomMap.img_path
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
            radius: height
            text: "Save results"
        }

        Rectangle {
            id: delimiter
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.001
            color: Common.secondary
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            RandomWheel {
                id: rw
                anchors.centerIn: parent
                anchors.fill: parent

                // function after hero is randomized
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
                layer.enabled: true
                scale: Math.min(
                    parent.width / width,
                    parent.height / height
                )
            }
        }
    }

    Notif {
        id: notif
    }

    ListModel {
        id: heroesModel

        onDataChanged: {
            rw.heroes = root.getEnabledHeroes()
            rw.paint()
        }
    }
    ListModel {
        id: mapsModel
    }
    ListModel {
        id: setModel

        onDataChanged: {
            rw.heroes = root.getEnabledHeroes()
            rw.paint()
        }
    }

    Component.onCompleted: {
        loadData()
        rw.heroes = root.getEnabledHeroes().sort(() => Math.random() - 0.5)
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
        console.debug("maps loaded " + mapsModel)

        setModel.clear()
        let backSets = backend.getSHM()   
        for (let i = 0; i < backSets.length; i++) {
            setModel.append({
                id: backSets[i].id,
                name: backSets[i].name,
                img_path: backSets[i].img_path,
                heroes: backSets[i].heroes,
                maps: backSets[i].maps,
                enabled: true
            })
        }
        console.debug("sets loaded " + setModel)
    }

    function modelFind(model, field, value) {
        let idx = -1

        for (let i = 0; i < model.count; ++i) {
            if (model.get(i)[field] === value[field]) {
                idx = i
                break
            }
        }
        return idx
    }

    function getEnabledMaps() {
        let maps = []
        for (let i = 0; i < setModel.count; ++i) {
            const set = setModel.get(i)
            if (set.enabled) {
                const setMaps = set.maps
                for (let j = 0; j < setMaps.count; ++j) {
                    maps.push(setMaps.get(j))
                }
            }
        }

        for (let i = 0; i < mapsModel.count; ++i) {
            const map = mapsModel.get(i)
            if (!map.enabled) {
                maps = maps.filter(x => x.id != map.id)
            }
        }

        return maps
    }
    
    function getEnabledHeroes() {
        let heroes = []
        for (let i = 0; i < setModel.count; ++i) {
            if (setModel.get(i).enabled) {
                const heroesModel = setModel.get(i).heroes
                for (let j = 0; j < heroesModel.count; ++j) {
                    heroes.push(heroesModel.get(j))
                }
            }
        }

        for (let i = 0; i < heroesModel.count; ++i) {
            if (!heroesModel.get(i).enabled) {
                heroes = heroes.filter(x => x.id != heroesModel.get(i).id)
            }
        }

        return heroes
    }
}
