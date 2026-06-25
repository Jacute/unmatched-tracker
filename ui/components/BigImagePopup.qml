import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15

import Tracker

Popup {
    property string img
    property alias text: text.text

    id: imagePopup
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    width: ci.width
    height: ci.height
    parent: Overlay.overlay
    anchors.centerIn: parent
    
    background: Rectangle {
        color: "transparent"
    }
    
    contentItem: Rectangle {
        id: ci
        color: Common.secondary
        width: Screen.width * 0.8
        height: Screen.height * 0.5
        radius: width * 0.1
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: ci.width * 0.06

            LoadImage {
                id: enlargedImage
                imgPath: imagePopup.img
                Layout.preferredHeight: ci.height * 0.8
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                fillMode: Image.PreserveAspectFit
                smooth: true
            }
            Text {
                id: text
                color: Common.textColor
                font.pixelSize: Common.defaultFontSize + 4
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                wrapMode: Text.WordWrap
            }
        }
    }
    
    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
        ScaleAnimator { from: 0.8; to: 1; duration: 200; easing.type: Easing.OutBack }
    }
    
    exit: Transition {
        NumberAnimation { property: "opacity"; to: 0; duration: 150 }
        ScaleAnimator { to: 0.8; duration: 150 }
    }
}
