pragma ComponentBehavior: Bound

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import Tracker
import "../components"

Rectangle {
    readonly property string setImgPrefix: Common.imgPrefix + "/set"
    readonly property bool isMobile: Qt.platform.os === "android" || Qt.platform.os === "ios"

    id: root
    color: Common.primary

    // grid of addons
    ScrollView {
        id: view
        anchors {
            fill: parent
        }
        clip: true
        contentWidth: availableWidth
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        Grid {
            id: grid
            width: parent.width - parent.height * 0.02
            
            padding: height * 0.01
            columnSpacing: 15
            rowSpacing: 5
            columns: 2

            Repeater {
                model: setModel

                delegate: Item {
                    id: item
                    required property var modelData

                    width: (grid.width - grid.columnSpacing) / 2
                    height: width * 1.4

                    Card {
                        width: parent.width
                        height: parent.height
                        cardName: parent.modelData.name
                        cardImg: parent.modelData.img_path
                        fontSize: Common.defaultFontSize
                    }
                }
            }
        }
    }

    ListModel {
        id: setModel
    }

    Component.onCompleted: {
        setModel.clear()
        let backSets = backend.getSets()   
        for (let i = 0; i < backSets.length; i++) {
            setModel.append({
                id: backSets[i].id,
                name: backSets[i].name,
                img_path: backSets[i].img_path
            })
        }
    }
}
