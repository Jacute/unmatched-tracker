import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Tracker
import Render

Rectangle {
    property string src1: Common.avatarPlug
    property string src2: Common.avatarPlug
    property alias textColor: vs.color

    id: root

    RowLayout {
        id: vsLayout
        anchors.fill: parent
        spacing: 10

        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        ImageRounded {
            src: src1
            Layout.preferredWidth: root.parent.width * 0.3
            Layout.preferredHeight: root.parent.width * 0.3
        }

        Text {
            id: vs
            font.pixelSize: Common.defaultFontSize * 1.5
            text: "VS"
        }

        ImageRounded {
            src: src2
            Layout.preferredWidth: root.parent.width * 0.3
            Layout.preferredHeight: root.parent.width * 0.3
        }
    }

    implicitWidth: vsLayout.implicitWidth
    implicitHeight: vsLayout.implicitHeight
}