import QtQuick 2.15
import QtQuick.Controls 2.15

import Tracker

Popup {
    property alias img: enlargedImage.source
    property alias text: text.text

    id: imagePopup
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    width: col.width
    height: col.height
    anchors.centerIn: parent.Overlay.overlay
    
    background: Rectangle {
        color: "transparent"
    }
    
    contentItem: Column {
        id: col
        spacing: 10
        anchors.centerIn: parent
        
        Image {
            id: enlargedImage
            width: Screen.width * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
        
        Text {
            id: text
            color: Common.textColor
            font.pixelSize: Common.defaultFontSize + 4
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: imagePopup.width
            wrapMode: Text.WordWrap
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