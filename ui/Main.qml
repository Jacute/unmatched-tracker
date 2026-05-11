pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15

import Tracker
import "./views"
import "./components"

Window {
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
    property string page: "set"
    
    id: root
    width: isMobile ? Screen.width : 360
    height: isMobile ? Screen.height : 800
    visible: true
    title: "Unmatched Tracker"

    Menu {
        id: menu
        width: parent.width * 0.7
        height: parent.height
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
    Set {
        anchors {
            top: hdr.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
    }
}
