pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import Tracker
import "./views"
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
        onMenuClicked: {
            menu.open()
        }

        function getHeaderText() {
            if (root.page === Common.pageSet) return "Наборы персонажей"
            if (root.page === Common.pageRandom) return "Рандомайзер"
            return "Unmatched Tracker"
        }
    }

    Item {
        anchors {
            top: hdr.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Set {
            id: setPage
            anchors.fill: parent
            visible: root.page === Common.pageSet
        }

        Random {
            id: randomPage
            anchors.fill: parent
            visible: root.page === Common.pageRandom
        }
    }
}
