pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

import Tracker
import "../../../components"

Rectangle {
    property int setId
    property int heroInd: 0
    property var currentPage: null

    id: root
    color: "transparent"

    // hero avatar
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.6
            
            Image {
                id: avatar
                source: heroesModel.get(root.heroInd).img_path
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
            }
            
            Rectangle {
                anchors {
                    left: avatar.left
                    right: avatar.right
                    bottom: avatar.bottom
                }
                height: avatar.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: Common.bgColor }
                }
            }
        }

        RowLayout {
            id: selector
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.05
            spacing: 0

            Repeater {
                id: repeater
                model: ListModel {
                    id: tabsModel
                    ListElement {
                        text: "Описание и карты"
                        path: "Description.qml"
                        active: true
                    }
                    ListElement {
                        text: "Общая статистика"
                        path: "CommonStat.qml"
                        active: false
                    }
                    ListElement {
                        text: "Статистика профиля"
                        path: "ProfileStat.qml"
                        active: false
                    }
                    ListElement {
                        text: "Матчапы"
                        path: "Matchups.qml"
                        active: false
                    }
                }

                Item {
                    required property int index
                    required property var modelData

                    id: btnWrapper
                    Layout.fillWidth: true
                    Layout.preferredHeight: selector.height
                    
                    Btn {
                        id: btn
                        anchors.fill: parent
                        bgColor: !btnWrapper.modelData.active ? Common.primary : Common.secondary
                        text: btnWrapper.modelData.text
                        fontSize: btnWrapper.height *  0.3
                        borderWidth: 0
                        
                        onClicked: {
                            for (let i = 0; i < tabsModel.count; i++) {
                                tabsModel.setProperty(i, "active", false)
                            }
                            tabsModel.setProperty(btnWrapper.index, "active", true)
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

        Item {
            id: body
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            Loader {
                id: pageLoader
                anchors.fill: parent
                onStatusChanged: {
                    if (status === Loader.Ready) {
                        console.log("Page loaded:", item)
                    }
                }
            }
        }
    }

    ListModel {
        id: heroesModel
    }

    onSetIdChanged: {
        console.debug("getting heroes for set id " + setId)
        heroesModel.clear()
        let backHeroes = backend.getHeroesBySetId(setId)   
        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                img_path: backHeroes[i].img_path
            })
        }
    }
}