import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "."
import Tracker

Rectangle {
    id: root
    anchors.fill: parent
    color: Common.bgColor

    signal pop()

    StackView {
        id: stack
        anchors.fill: parent
        background: null

        initialItem: Setup {
            onStartRequested: (configuration) => {
                stack.push(Qt.resolvedUrl("TurnTimer.qml"), {
                    "configuration": configuration
                })
            }
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
