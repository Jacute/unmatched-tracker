pragma ComponentBehavior: Bound
import QtQuick

import Tracker

Grid {
    property alias model: repeater.model

    signal modelClicked(int index)

    id: root
    width: parent.width - parent.height * 0.02
    
    padding: height * 0.01
    columnSpacing: 15
    rowSpacing: 5
    columns: 2

    Repeater {
        id: repeater

        delegate: Item {
            required property int index
            required property var modelData
            
            id: item

            width: (root.width - root.columnSpacing) / 2
            height: width * 1.4

            Card {
                width: parent.width
                height: parent.height
                cardName: parent.modelData.name
                cardImg: parent.modelData.img_path
                fontSize: Common.defaultFontSize

                onImgClicked: root.modelClicked(item.index)
            }
        }
    }
}