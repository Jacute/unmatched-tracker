function findProfileById(profilesModel, id) {
    for (let i = 0; i < profilesModel.count; i++) {
        if (profilesModel.get(i).id == id) {
            return i
        }
    }
    return -1
}