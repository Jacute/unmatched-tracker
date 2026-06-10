import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

import Tracker
import "ico"

Rectangle {
    id: root
    
    property alias text: pageName.text
    readonly property int headerFontPixelSize: parent.width / 20
    property string btnIconType
    signal btnClicked

    height: parent.height * 0.05
    width: parent.width

    color: Common.secondary

    anchors.top: parent.top

    Button {
        id: menuBtn
        height: parent.height
        width: parent.width * 0.15

        background: Rectangle {
            color: Common.secondary
        }
        
        contentItem: Loader {
            id: iconLoader
            source: {
                if (root.btnIconType === "back") {
                    return "ico/BackIco.qml"
                }
                return "ico/MenuIco.qml"
            }
            anchors.fill: parent
        }

        onClicked: {
            root.btnClicked()
        }
    }

    Text {
        id: pageName
        font.bold: true
        font.pixelSize: parent.headerFontPixelSize
        color: Common.textColor

        width: parent.width
        height: parent.height

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}