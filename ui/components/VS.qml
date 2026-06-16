import QtQuick
import QtQuick.Layouts

import Tracker
import Render

Rectangle {
    id: root

    property string src1: Common.avatarPlug
    property string src2: Common.avatarPlug
    property alias textColor: vs.color

    radius: 20
    color: Common.secondary

    border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
    border.width: 1

    implicitWidth: vsLayout.implicitWidth + 28
    implicitHeight: vsLayout.implicitHeight + 24

    RowLayout {
        id: vsLayout

        anchors.centerIn: parent
        spacing: 18

        ImageRounded {
            src: root.src1
            Layout.preferredWidth: 120
            Layout.preferredHeight: 120
        }

        Text {
            id: vs
            text: "VS"

            font.pixelSize: Common.defaultFontSize * 1.8
            font.bold: true
            opacity: 0.9
        }

        ImageRounded {
            src: root.src2
            Layout.preferredWidth: 120
            Layout.preferredHeight: 120
        }
    }
}
