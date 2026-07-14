import QtQuick
import QtQuick.Layouts
import Tracker
import "../components"

Rectangle {
    id: root
    color: Common.bgColor

    property var hero1: Common.plugHero
    property var hero2: Common.plugHero
    property var selectedMap: null
    property bool filtersVisible: false
    property var mapImageUrls: ({})
    property var requestedMapImagePaths: ({})
    readonly property bool canSaveResults: root.hero1.id !== undefined
        && root.hero2.id !== undefined
        && root.selectedMap !== null

    signal saveResultsRequested(var hero1, var hero2, var gameMap)

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
                    text: qsTr("Filters")
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
                id: randomFilter
                anchors.fill: parent
                heroes: heroesModel
                maps: mapsModel
                sets: setModel
                onFiltersChanged: {
                    root.updateWheelHeroes()
                    root.saveRandomizerConfig()
                }
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
            hero1AvatarPath: root.hero1.img_path
            hero2AvatarPath: root.hero2.img_path
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
                text: qsTr("Random map")
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

                    const unloadedMap = enabledMaps.find(map => !root.mapImageUrls[map.img_path])
                    if (unloadedMap) {
                        root.requestMapImages()
                        notif.show("Maps are still loading")
                        return
                    }

                    const randomMap = enabledMaps[Math.floor(Math.random() * enabledMaps.length)]
                    root.selectedMap = randomMap
                    gm.sourceUrl = root.mapImageUrls[randomMap.img_path]
                    gm.imgPath = randomMap.img_path
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
            text: qsTr("Save results")
            enabled: root.canSaveResults
            opacity: enabled ? 1 : 0.45
            onClicked: root.saveResultsRequested(
                root.hero1,
                root.hero2,
                root.selectedMap
            )
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
                        root.updateWheelHeroes()
                        return
                    }
                    if (root.hero2.img_path === Common.avatarPlug) {
                        root.hero2 = randomHero
                        root.updateWheelHeroes()
                        return
                    }
                    root.hero1 = randomHero
                    root.hero2 = Common.plugHero
                    root.selectedMap = null
                    gm.visible = false
                    rndMap.visible = true
                    root.updateWheelHeroes()
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

    Connections {
        target: core

        function onImageReady(path, sourceUrl) {
            if (root.requestedMapImagePaths[path] !== true) {
                return
            }

            root.requestedMapImagePaths[path] = false
            root.mapImageUrls[path] = sourceUrl
        }

        function onImageFailed(path) {
            if (root.requestedMapImagePaths[path] !== true) {
                return
            }

            root.requestedMapImagePaths[path] = false
            console.error("[Random] map image " + path + " not loaded")
        }
    }

    ListModel { id: heroesModel }
    ListModel { id: mapsModel }
    ListModel { id: setModel }

    Component.onCompleted: {
        loadData()
        rw.heroes = root.getEnabledHeroes().sort(() => Math.random() - 0.5)
    }

    function loadData() {
        const config = core.loadRandomizerConfig()
        if (!config.ok) {
            console.error("[Random] can't load config: " + config.error)
        }
        const heroStates = config.ok && config.exists ? config.heroes : ({})
        const mapStates = config.ok && config.exists ? config.maps : ({})

        heroesModel.clear()
        let backHeroes = core.getHeroes()

        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                img_path: backHeroes[i].img_path,
                set_id: backHeroes[i].set_id,
                enabled: root.savedEnabled(heroStates, backHeroes[i].id)
            })
        }
        console.debug("heroes loaded " + heroesModel)

        mapsModel.clear()
        let backMaps = core.getMaps()
        for (let i = 0; i < backMaps.length; i++) {
            mapsModel.append({
                id: backMaps[i].id,
                name: backMaps[i].name,
                img_path: backMaps[i].img_path,
                set_id: backMaps[i].set_id,
                enabled: root.savedEnabled(mapStates, backMaps[i].id)
            })
        }
        console.debug("maps loaded " + mapsModel)
        root.requestMapImages()

        setModel.clear()
        let backSets = core.getSets()
        for (let i = 0; i < backSets.length; i++) {
            setModel.append({
                id: backSets[i].id,
                name: backSets[i].name,
                img_path: backSets[i].img_path,
                enabled: true
            })
        }
        randomFilter.syncSetStates()
        console.debug("sets loaded " + setModel)
    }

    function savedEnabled(states, id) {
        const enabled = states[String(id)]
        return enabled === undefined ? true : enabled
    }

    function configItems(model) {
        const items = []
        for (let i = 0; i < model.count; ++i) {
            const item = model.get(i)
            items.push({ id: item.id, enabled: item.enabled })
        }
        return items
    }

    function saveRandomizerConfig() {
        const result = core.saveRandomizerConfig(
            root.configItems(heroesModel),
            root.configItems(mapsModel)
        )
        if (!result.ok) {
            console.error("[Random] can't save config: " + result.error)
        }
    }

    function getEnabledMaps() {
        let maps = []
        for (let i = 0; i < mapsModel.count; ++i) {
            const map = mapsModel.get(i)
            if (map.enabled) {
                maps.push(map)
            }
        }

        return maps
    }

    function requestMapImages() {
        for (let i = 0; i < mapsModel.count; ++i) {
            const path = mapsModel.get(i).img_path
            if (!path || root.mapImageUrls[path] || root.requestedMapImagePaths[path] === true) {
                continue
            }

            root.requestedMapImagePaths[path] = true
            core.requestImage(path)
        }
    }
    
    function getEnabledHeroes() {
        let heroes = []
        for (let i = 0; i < heroesModel.count; ++i) {
            const hero = heroesModel.get(i)
            if (hero.enabled) {
                heroes.push(hero)
            }
        }

        return heroes
    }

    function updateWheelHeroes() {
        let heroes = root.getEnabledHeroes()
        if (root.hero1.img_path !== Common.avatarPlug
                && root.hero2.img_path === Common.avatarPlug) {
            heroes = heroes.filter(hero => hero.id !== root.hero1.id)
        }

        rw.heroes = heroes
        rw.paint()
    }
}
