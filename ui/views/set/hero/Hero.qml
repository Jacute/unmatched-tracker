pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15

import Tracker
import "../../../components"

Rectangle {
    required property int setId
    property int heroInd: 0
    property int activeTabInd: 0
    property var currentPage: null
    property int pendingHeroInd: 0
    property int switchDirection: 1
    property bool switchingHero: false

    id: root
    color: "transparent"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Hero avatar
        Item {
            id: avatarWrapper

            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.4
            clip: true
            
            Image {
                id: avatar
                source: heroesModel.count > root.heroInd
                    ? heroesModel.get(root.heroInd).img_path
                    : ""
                fillMode: Image.PreserveAspectCrop
                width: parent.width
                height: parent.height
            }

            Image {
                id: nextAvatar
                source: root.switchingHero && heroesModel.count > root.pendingHeroInd
                    ? heroesModel.get(root.pendingHeroInd).img_path
                    : ""
                fillMode: Image.PreserveAspectCrop
                width: parent.width
                height: parent.height
                visible: root.switchingHero
            }
            
            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: parent.height * 0.3
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: Common.bgColor }
                }
            }

            Btn {
                id: prevHeroBtn
                visible: heroesModel.count > 1
                width: Math.min(parent.width * 0.14, parent.height * 0.22)
                height: width
                radius: width / 2
                bgColor: Common.secondary
                borderColor: Qt.lighter(Common.secondary, Common.borderLightFactor)
                text: "‹"
                fontSize: height * 0.65
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.04
                    verticalCenter: parent.verticalCenter
                }

                onClicked: root.switchHero(-1)
            }

            Btn {
                id: nextHeroBtn
                visible: heroesModel.count > 1
                width: prevHeroBtn.width
                height: width
                radius: width / 2
                bgColor: Common.secondary
                borderColor: Qt.lighter(Common.secondary, Common.borderLightFactor)
                text: "›"
                fontSize: height * 0.65
                anchors {
                    right: parent.right
                    rightMargin: parent.width * 0.04
                    verticalCenter: parent.verticalCenter
                }

                onClicked: root.switchHero(1)
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
                onLoaded: {
                    console.debug("Hero subpage loaded: ", item)
                    root.setLoadedSectionCtx()
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

    onHeroIndChanged: setLoadedSectionCtx()

    onSetIdChanged: {
        console.debug("getting heroes for set id " + setId)
        heroesModel.clear()
        let backHeroes = backend.getHeroesBySetId(setId)   
        root.heroInd = 0
        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                img_path: backHeroes[i].img_path
            })
        }
        setLoadedSectionCtx()
    }

    function switchHero(offset) {
        if (heroesModel.count <= 1 || root.switchingHero) {
            return
        }

        root.switchDirection = offset > 0 ? 1 : -1
        root.pendingHeroInd = (root.heroInd + offset + heroesModel.count) % heroesModel.count
        avatar.x = 0
        nextAvatar.x = root.switchDirection * avatarWrapper.width
        root.switchingHero = true
        heroSwitchAnimation.start()
    }

    function setLoadedSectionCtx() {
        if (!pageLoader.item || heroesModel.count <= root.heroInd) {
            return
        }

        if (typeof pageLoader.item.heroId !== "undefined") {
            pageLoader.item.heroId = heroesModel.get(root.heroInd).id
        }
    }

    ParallelAnimation {
        id: heroSwitchAnimation

        NumberAnimation {
            target: avatar
            property: "x"
            to: -root.switchDirection * avatarWrapper.width
            duration: 220
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: nextAvatar
            property: "x"
            to: 0
            duration: 220
            easing.type: Easing.InOutQuad
        }

        onStopped: {
            root.heroInd = root.pendingHeroInd
            avatar.x = 0
            nextAvatar.x = root.switchDirection * avatarWrapper.width
            root.switchingHero = false
        }
    }
}
