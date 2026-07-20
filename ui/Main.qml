pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import Tracker
import "./views"
import "./views/set"
import "./components"

ApplicationWindow {
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
    property string page: Common.pageHome
    
    id: root
    width: isMobile ? Screen.width : 360
    height: isMobile ? Screen.height : 800
    visible: true
    title: "Unmatched Tracker"

    Menu {
        id: menu
        width: parent.width * 0.7
        height: parent.height

        onChangePage: (pageName) => {
            root.page = pageName
            menu.close();
        }
    }
    
    Header {
        id: hdr
        text: getHeaderText()
        btnIconType: getIconType()
        onBtnClicked: {
            switch (btnIconType) {
            case "back":
                if (setPage.canPop()) {
                    setPage.pop()
                }
                break
            case "menu":
                menu.open()
                break
            }
        }

        function getHeaderText() {
            switch (root.page) {
            case Common.pageHome:
                return qsTr("Overview")
            case Common.pageSet:
                return setPage.headerText
            case Common.pageRandom:
                return qsTr("Randomizer")
            case Common.pageProfiles:
                return qsTr("Player Profiles")
            case Common.pageGames:
                return qsTr("Game History")
            case Common.pageSettings:
                return qsTr("Settings")
            default:
                return qsTr("Unmatched Tracker")
            }
        }

        function getIconType() {
            if (root.page === Common.pageSet && setPage.canPop()) {
                return "back"
            }
            return "menu"
        }
    }

    Item {
        anchors {
            top: hdr.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        SetStack {
            id: setPage
            anchors.fill: parent
            visible: root.page === Common.pageSet
        }

        Home {
            id: homePage
            anchors.fill: parent
            visible: root.page === Common.pageHome

            onOpenProfilesRequested: root.page = Common.pageProfiles
        }

        Random {
            id: randomPage
            anchors.fill: parent
            visible: root.page === Common.pageRandom

            onSaveResultsRequested: (hero1, hero2, gameMap) => {
                root.page = Common.pageGames
                Qt.callLater(
                    gamesPage.prefillFromRandomizer,
                    hero1.id,
                    hero2.id,
                    gameMap.id
                )
            }
        }

        Profiles {
            id: profilesPage
            anchors.fill: parent
            visible: root.page === Common.pageProfiles
        }

        Games {
            id: gamesPage
            anchors.fill: parent
            visible: root.page === Common.pageGames
        }

        Settings {
            id: settingsPage
            anchors.fill: parent
            visible: root.page === Common.pageSettings
        }
    }

    onClosing: (close) => {
        if (Qt.platform.os !== "android") {
            return
        }

        close.accepted = true
        switch (root.page) {
        case Common.pageHome:
            break
        case Common.pageSet:
            if (setPage.canPop()) {
                close.accepted = false
                setPage.pop()
            }
            break
        case Common.pageRandom:
            break
        case Common.pageProfiles:
            break
        case Common.pageGames:
            break
        case Common.pageSettings:
            break
        }
    }
}
