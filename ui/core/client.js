function sortAfterLoad(a, b) {
    return a.name.localeCompare(b.name)
}

function loadProfiles(core, profilesModel) {
    profilesModel.clear()
    const profiles = core.getProfiles()
    profiles.sort(sortAfterLoad)
    for (let i = 0; i < profiles.length; i++) {
        profilesModel.append({
            id: profiles[i].id,
            name: profiles[i].name,
            created_at: profiles[i].created_at
        })
    }
}

function loadHeroes(core, heroesModel) {
    heroesModel.clear()
    const heroes = core.getHeroes()
    heroes.sort(sortAfterLoad)
    for (let i = 0; i < heroes.length; i++) {
        heroesModel.append({
            id: heroes[i].id,
            name: heroes[i].name,
            hp: heroes[i].hp,
            img_path: heroes[i].img_path
        })
    }
}

function loadMaps(core, mapsModel) {
    mapsModel.clear()
    mapsModel.append({ id: 0, name: qsTr("Not specified") })
    const maps = core.getMaps()
    maps.sort(sortAfterLoad)
    for (let i = 0; i < maps.length; i++) {
        mapsModel.append({
            id: maps[i].id,
            name: maps[i].name
        })
    }
}
