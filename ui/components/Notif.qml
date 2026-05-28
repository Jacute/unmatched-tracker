import QtQuick
import QtQuick.Controls

import Tracker

Popup {
    id: toast
    x: parent.width - width - 20
    y: parent.height - height - 20
    width: 250
    height: 50
    modal: false
    focus: false

    background: Rectangle {
        radius: 8
        color: Common.secondary
        opacity: 0.9
    }

    contentItem: Text {
        text: toast.message
        color: Common.textColor
        anchors.centerIn: parent
    }

    property string message: ""

    function show(msg) {
        message = msg
        open()

        timer.restart()
    }

    Timer {
        id: timer
        interval: 2000
        repeat: false
        onTriggered: toast.close()
    }
}