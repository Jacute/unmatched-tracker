import QtQuick
import QtQuick.Controls

import Tracker
import ".."

FieldBox {
    property string defaultTime: ""
    readonly property bool acceptableTime: {
        if (!time.acceptableInput || !/^\d{2}:\d{2}$/.test(time.text)) {
            return false
        }
        return parseInt(time.text.substring(3, 5), 10) < 60
    }

    id: root
    TextField {
        id: time
        anchors.fill: parent
        color: Common.textColor
        text: root.defaultTime
        placeholderTextColor: Common.textHint
        selectionColor: Common.accent
        selectedTextColor: Common.primary
        font.pixelSize: Common.defaultFontSize
        inputMask: "00:00;_"
        inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
        background: null
        verticalAlignment: TextInput.AlignVCenter
        padding: 0
        leftPadding: 0

    }

    function seconds() {
        if (!acceptableTime) {
            return -1
        }

        const minutes = parseInt(time.text.substring(0, 2), 10)
        const seconds = parseInt(time.text.substring(3, 5), 10)
        return minutes * 60 + seconds
    }
}
