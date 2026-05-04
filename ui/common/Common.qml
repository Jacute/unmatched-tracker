pragma Singleton
import QtQuick

QtObject {
    readonly property color background: "#4A4A4A"
    readonly property color shadow1: "#1E1E1E"
    readonly property color shadow2: "#2E2E2E"
    readonly property color border: "#2A2A2A"

    readonly property color textColor: "#B0B0B0"

    // prefix for root
    readonly property string assetsPrefix: "./assets"
    readonly property string imgPrefix: qsTr("%1/img").arg(assetsPrefix)
}