pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

import Tracker
import "../../../components"

RowLayout {
    property int activeTabInd: 0
    required property ListModel tabs

    signal changeActiveTabInd(int activeTabInd)
    
    id: root

    Repeater {
        id: repeater
        model: root.tabs

        Item {
            required property int index
            required property var modelData

            id: btnWrapper
            Layout.fillWidth: true
            Layout.preferredHeight: root.height

            Btn {
                id: btn
                anchors.fill: parent
                bgColor: btnWrapper.index != root.activeTabInd ? Common.primary : Common.secondary
                text: btnWrapper.modelData.text
                fontSize: btnWrapper.height *  0.3
                borderWidth: 0

                onClicked: {
                    root.changeActiveTabInd(btnWrapper.index)
                }
            }

            // vertical borders
            Rectangle {
                visible: btnWrapper.index > 0
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 1
                color: Common.secondary
            }

            Rectangle {
                visible: btnWrapper.index !== repeater.count - 1
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 1
                color: Common.secondary
            }
        }
    }
}
