pragma ComponentBehavior: Bound
import QtQuick

import Tracker

Grid {
    property alias model: repeater.model
    property real imgRadius: 0
    property string labelPosition: "top"

    signal modelClicked(int index)

    id: root
    
    padding: 8
    columnSpacing: 15
    rowSpacing: 5

    readonly property real cellWidth: Math.max(0,
        (width - padding * 2 - columnSpacing * (columns - 1)) / columns
    )

    Repeater {
        id: repeater

        delegate: Item {
            required property int index
            required property var modelData
            
            id: item

            width: root.cellWidth
            height: width * 1.4

            Card {
                imgRadius: root.imgRadius
                width: parent.width
                height: parent.height
                cardName: parent.modelData.name
                cardImg: parent.modelData.img_path
                fontSize: Common.defaultFontSize
                labelPosition: root.labelPosition

                onImgClicked: root.modelClicked(item.index)
            }
        }
    }
}
