import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "."
import Tracker

Rectangle {
    readonly property string setImgPrefix: Common.imgPrefix + "/set"
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"

    id: root
    anchors.fill: parent
    color: Common.bgColor

    signal pop()

    StackView {
        id: stack
        anchors.fill: parent
        background: null

        initialItem: Set {
            pager: stack
        }
    }

    function canPop() {
        if (stack.depth == 1) {
            return false
        }
        return true
    }

    onPop: stack.pop()
}
