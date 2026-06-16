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
    property string page: Common.pageSet
    
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
            case Common.pageSet:
                return qsTr("Character Sets")
            case Common.pageRandom:
                return qsTr("Randomizer")
            case Common.pageProfiles:
                return qsTr("Player Profiles")
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

        Random {
            id: randomPage
            anchors.fill: parent
            visible: root.page === Common.pageRandom
        }

        Profiles {
            id: profilesPage
            anchors.fill: parent
            visible: root.page === Common.pageProfiles
        }
    }

    onClosing: (close) => {
        if (Qt.platform.os !== "android") {
            return
        }

        close.accepted = true
        switch (root.page) {
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
        }
    }
}
