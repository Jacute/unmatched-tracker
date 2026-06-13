pragma ComponentBehavior: Bound
import QtQuick

import Tracker

Grid {
    property alias model: repeater.model
    property real imgRadius: 0
    property string labelPosition: "top"
    property int cardImgFillMode: Image.PreserveAspectFit

    signal modelClicked(int index)

    id: root
    
    padding: height * 0.01
    columnSpacing: 15
    rowSpacing: 5

    Repeater {
        id: repeater

        delegate: Item {
            required property int index
            required property var modelData
            
            id: item

            width: (root.width - root.columnSpacing) / root.columns
            height: width * 1.4

            Card {
                imgRadius: root.imgRadius
                width: parent.width
                height: parent.height
                cardName: parent.modelData.name
                cardImg: parent.modelData.img_path
                fontSize: Common.defaultFontSize
                labelPosition: root.labelPosition
                cardImgFillMode: cardImgFillMode

                onImgClicked: root.modelClicked(item.index)
            }
        }
    }
}