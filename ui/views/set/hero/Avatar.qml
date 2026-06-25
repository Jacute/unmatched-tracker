import QtQuick

import "../../../components"


Item {
    property alias imgPath: avatar.imgPath
    property int heroesCount: 0

    signal switchHero(int offset)

    id: root

    LoadImage {
        id: avatar
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
        visible: root.heroesCount > 1
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
        visible: root.heroesCount > 1
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
