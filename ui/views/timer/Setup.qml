pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Tracker
import "../../components"

Rectangle {
    anchors.fill: parent
    color: Common.bgColor

    RowLayout {
        GameParticipantInput {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            title: "123"

            withHP: false
            heroes: [
                "123",
                "456"
            ]
        }
    }
}
