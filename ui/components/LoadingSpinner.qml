import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import Tracker

BusyIndicator {
    id: root

    property color indicatorColor: Common.accent

    running: visible
    Material.accent: indicatorColor
    palette.dark: indicatorColor
    palette.highlight: indicatorColor
    palette.text: indicatorColor
}
