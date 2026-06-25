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

    id: root
    color: "transparent"

    Repeater {
        id: heroPageRepeater
        model: heroesModel

        Item {
            required property int index
            required property var modelData

            id: heroPage
            anchors.fill: parent
            visible: index === root.heroInd

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // Hero avatar
                Item {
                    id: avatarWrapper

                    Layout.fillWidth: true
                    Layout.preferredHeight: root.height * 0.4
                    clip: true

                    LoadImage {
                        id: avatar
                        imgPath: heroPage.modelData.img_path
                        fillMode: Image.PreserveAspectCrop
                        width: parent.width
                        height: parent.height
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

                    Repeater {
                        model: tabsModel

                        Loader {
                            required property int index
                            required property var modelData

                            anchors.fill: parent
                            source: modelData.path
                            visible: index === root.activeTabInd

                            onLoaded: {
                                console.debug("Hero subpage loaded: ", item)
                                root.setLoadedSectionCtx(item, heroPage.modelData.id)
                            }
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: tabsModel
        ListElement {
            text: qsTr("Overview and Cards")
            path: "Cards.qml"
        }
        ListElement {
            text: qsTr("Global Stats")
            path: "CommonStat.qml"
        }
        ListElement {
            text: qsTr("Profile Stats")
            path: "ProfileStat.qml"
        }
        ListElement {
            text: qsTr("Matchups")
            path: "Matchups.qml"
        }
    }

    ListModel {
        id: heroesModel
    }

    onSetIdChanged: {
        console.debug("getting heroes for set id " + setId)
        heroesModel.clear()
        let backHeroes = core.getHeroesBySetId(setId)   
        root.heroInd = 0
        for (let i = 0; i < backHeroes.length; i++) {
            heroesModel.append({
                id: backHeroes[i].id,
                name: backHeroes[i].name,
                img_path: backHeroes[i].img_path
            })
        }
    }

    function switchHero(offset) {
        if (heroesModel.count <= 1) {
            return
        }

        root.heroInd = (root.heroInd + offset + heroesModel.count) % heroesModel.count
    }

    function setLoadedSectionCtx(page, heroId) {
        if (!page || typeof page.heroId === "undefined") {
            return
        }

        page.heroId = heroId
    }

}
