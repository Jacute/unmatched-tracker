pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color primary: "#202030" // Main app color
    readonly property color bgColor: "#1B1B29"
    readonly property color secondary: "#313244"
    readonly property color imagePlaceholder: "#27283A"
    readonly property color imagePlaceholderSoft: "#3B3C52"
    
    readonly property color shadow2: "#181825"
    readonly property color shadow1: "#11111B"
    
    readonly property color accent: "#89B4FA"
    readonly property color accentHover: "#B4BEFE"
    
    readonly property color textColor: "#CDD6F4"    // Main text color
    readonly property color textSecondary: "#A6ADC8"
    readonly property color textHint: "#6C7086"
    
    readonly property color warning: "#F9E2AF"
    readonly property color error: "#B65C72"
    readonly property color success: "#6FA86F"

    readonly property color team1Color: "#4CC9F0"
    readonly property color team2Color: "#FF6B6B"
    readonly property color team3Color: "#FFD166"
    readonly property color team4Color: "#C77DFF"

    readonly property int defaultFontSize: 16
    readonly property int defaultRadius: 10
    readonly property real borderLightFactor: 1.25
    
    // file path
    readonly property string assetsPrefix: "qrc:/qt/qml/Tracker/ui/assets"
    readonly property string imgPrefix: assetsPrefix + "/img"
    readonly property string setPrefix: imgPrefix + "/set"

    // %1 - set name, %2 - hero name
    readonly property string heroAvatarFormat: setPrefix + "/%1/heroes/%2/avatar.webp"
    // %1 - set name, %2 - map name
    readonly property string mapFormat: setPrefix + "/%1/maps/%2.webp"
    
    readonly property string fontsPrefix: assetsPrefix + "/fonts"
    readonly property string avatarPlug: "/img/ui/avatar_plug.png"
    readonly property var plugHero: ({
        name: "Plug",
        img_path: avatarPlug
    })

    // pages
    readonly property string pageHome: "home"
    readonly property string pageSet: "set"
    readonly property string pageRandom: "random"
    readonly property string pageProfiles: "profiles"
    readonly property string pageGames: "games"
    readonly property string pageSettings: "settings"
    readonly property string pageTimer: "timer"

    // core profile creation errors
    readonly property string profileErrEmptyName: "empty_name"
    readonly property string profileErrNameTooLong: "name_too_long"
    readonly property string profileErrDuplicateName: "duplicate_name"
    readonly property string profileErrNotFound: "not_found"
    readonly property string profileErrHasGameRecords: "has_game_records"
    readonly property string profileErrDbError: "db_error"

    // core game history errors
    readonly property string gameErrNotFound: "not_found"
    readonly property string gameErrDbError: "db_error"

    readonly property ListModel gameModesModel: ListModel {
        ListElement { code: "1v1"; name: "1 vs 1"; playerCount: 2; teamCount: 2 }
        ListElement { code: "1v1v1"; name: "1 vs 1 vs 1"; playerCount: 3; teamCount: 3 }
        ListElement { code: "1v1v1v1"; name: "1 vs 1 vs 1 vs 1"; playerCount: 4; teamCount: 4 }
        ListElement { code: "2v2"; name: "2 vs 2"; playerCount: 4; teamCount: 2 }
    }

    readonly property real pageMargin: Screen.width * 0.04
    readonly property real fieldSpacing: Screen.height * 0.01
}
