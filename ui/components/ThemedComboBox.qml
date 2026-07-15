pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import Tracker

ComboBox {
    property int popupWidth: width * 1
    id: combo

    font.pixelSize: Common.defaultFontSize

    contentItem: Text {
        leftPadding: 0
        rightPadding: combo.indicator.width + combo.spacing
        text: combo.displayText
        color: combo.enabled ? Common.textColor : Common.textHint
        font: combo.font
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    indicator: Item {
        x: combo.width - width
        y: (combo.height - height) / 2
        width: 18
        height: 18

        Rectangle {
            width: 9
            height: 2
            radius: 1
            color: Common.textSecondary
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -3
            rotation: 45
        }

        Rectangle {
            width: 9
            height: 2
            radius: 1
            color: Common.textSecondary
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 3
            rotation: -45
        }
    }

    background: Rectangle {
        color: "transparent"
    }

    delegate: ItemDelegate {
        required property int index

        id: item

        width: combo.popupWidth
        height: Math.max(42, Common.defaultFontSize * 2.6)
        highlighted: combo.highlightedIndex === index

        contentItem: Text {
            text: combo.textAt(item.index)
            color: item.highlighted ? Common.primary : Common.textColor
            font.pixelSize: Common.defaultFontSize
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            color: item.highlighted ? Common.accent : Common.secondary
        }
    }

    popup: Popup {
        y: combo.height + 4
        width: combo.popupWidth
        implicitHeight: Math.min(contentItem.implicitHeight, combo.height * 7)
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: combo.popup.visible ? combo.delegateModel : null
            currentIndex: combo.highlightedIndex
        }

        background: Rectangle {
            color: Common.secondary
            radius: Common.defaultRadius
            border.width: 1
            border.color: Qt.lighter(Common.secondary, Common.borderLightFactor)
        }
    }
}
