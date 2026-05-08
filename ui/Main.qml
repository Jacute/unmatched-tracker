import QtQuick
import QtQuick.Window

import "views"

Window {
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"
    
    width: isMobile ? Screen.width : 360
    height: isMobile ? Screen.height : 800
    visible: true
    title: "Unmatched Tracker"
    
    Set {
        anchors.fill: parent
    }
}
