pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

import Tracker
import "../../../components"

Rectangle {
    required property int setId
    property int heroInd: 0
    property int activeTabInd: 0
    property var currentPage: null

    id: root
    color: "transparent"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Hero avatar
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.4
            
            Image {
                id: avatar
                source: heroesModel.count > root.heroInd
                    ? heroesModel.get(root.heroInd).img_path
                    : ""
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

        // Hero menu
        RowLayout {
            id: selector
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.05
            spacing: 0

            Repeater {
                id: repeater
                model: tabsModel

                Item {
                    required property int index
                    required property var modelData

                    id: btnWrapper
                    Layout.fillWidth: true
                    Layout.preferredHeight: selector.height
                    
                    Btn {
                        id: btn
                        anchors.fill: parent
                        bgColor: btnWrapper.index != root.activeTabInd ? Common.primary : Common.secondary
                        text: btnWrapper.modelData.text
                        fontSize: btnWrapper.height *  0.3
                        borderWidth: 0
                        
                        onClicked: {
                            root.activeTabInd = btnWrapper.index
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

        // Page body - information about hero
        Item {
            id: body
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            Loader {
                id: pageLoader
                anchors.fill: parent
                onStatusChanged: {
                    if (status === Loader.Ready) {
                        console.debug("Hero subpage loaded:", item)
                    }
                }
                source: tabsModel.get(root.activeTabInd).path
            }
        }
    }

    ListModel {
        id: tabsModel
        ListElement {
            text: "Описание и карты"
            path: "Cards.qml"
        }
        ListElement {
            text: "Общая статистика"
            path: "CommonStat.qml"
        }
        ListElement {
            text: "Статистика профиля"
            path: "ProfileStat.qml"
        }
        ListElement {
            text: "Матчапы"
            path: "Matchups.qml"
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