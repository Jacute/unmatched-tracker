pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


import "../../components"
import Tracker


Rectangle {
    property StackView pager: null

    id: root
    color: Common.bgColor

    // grid of sets
    ScrollView {
        id: view
        anchors {
            fill: parent
        }
        clip: true
        contentWidth: availableWidth
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        CardGrid {
            model: setModel
            width: parent.width - parent.height * 0.02            
            columns: 2
            anchors.centerIn: parent

            onModelClicked: (index) => {
                if (!root.pager) {
                    return
                }
                if (setModel.get(index).name == "Bruce Lee") {
                    return // bruce lee set can't be open because set with ali contains him
                }

                root.pager.push(
                    "hero/Hero.qml", 
                    {
                        setId: setModel.get(index).id
                    }
                )
            }
        }
    }

    ListModel {
        id: setModel
    }

    Component.onCompleted: {
        setModel.clear()
        let backSets = core.getSets()   
        for (let i = 0; i < backSets.length; i++) {
            setModel.append({
                id: backSets[i].id,
                name: backSets[i].name,
                img_path: backSets[i].img_path
            })
        }
    }
}