pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color primary: "#202030"      // Тёмный фон
    readonly property color bgColor: Qt.darker(primary, 1.15)
    readonly property color secondary: "#313244"    // Карточки, панели
    
    readonly property color shadow2: "#181825"
    readonly property color shadow1: "#11111B"
    
    readonly property color accent: "#89B4FA"       // Голубой акцент
    readonly property color accentHover: "#B4BEFE"  // Светлее для наведения
    
    readonly property color textColor: "#CDD6F4"    // Основной текст
    readonly property color textSecondary: "#A6ADC8" // Второстепенный текст
    readonly property color textHint: "#6C7086"     // Подсказки/плейсхолдеры
    
    readonly property color success: "#A6E3A1"
    readonly property color error: "#F38BA8"
    readonly property color warning: "#F9E2AF"
    
    // file path
    readonly property string assetsPrefix: "qrc:/qt/qml/Tracker/ui/assets"
    readonly property string imgPrefix: assetsPrefix + "/img"
    readonly property string setPrefix: imgPrefix + "/set"

    // %1 - set name, %2 - hero name
    readonly property string heroAvatarFormat: setPrefix + "/%1/heroes/%2/avatar.webp"
    // %1 - set name, %2 - map name
    readonly property string mapFormat: setPrefix + "/%1/maps/%2.webp"
    
    readonly property string fontsPrefix: assetsPrefix + "/fonts"
    readonly property string avatarPlug: "qrc:/qt/qml/Tracker/ui/assets/img/ui/avatar_plug.png"

    // pages
    readonly property string pageSet: "set"
    readonly property string pageRandom: "random"

    readonly property int defaultFontSize: 16
    readonly property int defaultRadius: 10

    readonly property var heroes: [
        {
            id: "dracula",
            name: "Дракула",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("dracula")
        },
        {
            id: "sherlock_holmes",
            name: "Шерлок Холмс",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("sherlock_holmes")
        },
        {
            id: "jekyll_hyde",
            name: "Джекил и Хайд",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("jekyll_hyde")
        },
        {
            id: "invisible_man",
            name: "Невидимка",
            img: qsTr(Common.heroAvatarFormat).arg("cobble_fog").arg("invisible_man")
        },
        {
            id: "medusa",
            name: "Медуза",
            img: qsTr(Common.heroAvatarFormat).arg("battle_of_legends1").arg("medusa")
        },
    ]
    readonly property var plugHero: ({
        name: "Plug",
        img_path: avatarPlug
    })
    readonly property var maps: [
        {
            id: "marmoreal",
            set_id: "battle_of_legends1",
            name: "Мармореал",
            set_name: "Битва легенд: Том 1",
            img: qsTr(mapFormat).arg("battle_of_legends1").arg("marmoreal")
        },
        {
            id: "sarpedon",
            set_id: "battle_of_legends1",
            name: "Сарпедон",
            set_name: "Битва легенд: Том 1",
            img: qsTr(mapFormat).arg("battle_of_legends1").arg("sarpedon")
        },
        {
            id: "hanging_gardens",
            set_id: "battle_of_legends2",
            name: "Висячие Сады",
            set_name: "Битва легенд: Том 2",
            img: qsTr(mapFormat).arg("battle_of_legends2").arg("hanging_gardens")
        },
        {
            id: "baskerville_manor",
            set_id: "cobble_fog",
            name: "Поместье Баскервиль",
            set_name: "Туман над мостовой",
            img: qsTr(mapFormat).arg("cobble_fog").arg("baskerville_manor")
        },
        {
            id: "soho",
            set_id: "cobble_fog",
            name: "Сохо",
            set_name: "Туман над мостовой",
            img: qsTr(mapFormat).arg("cobble_fog").arg("soho")
        },
    ]
}