pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color primary: "#202030"      // Тёмный фон
    readonly property color secondary: "#313244"    // Карточки, панели
    
    readonly property color shadow2: "#181825"
    readonly property color shadow1: "#11111B"
    
    readonly property color accent: "#89B4FA"       // Голубой акцент
    readonly property color accentHover: "#B4BEFE"  // Светлее для наведения
    
    readonly property color textColor: "#CDD6F4"    // Основной текст
    readonly property color textSecondary: "#A6ADC8" // Второстепенный текст
    readonly property color textHint: "#6C7086"     // Подсказки/плейсхолдеры
    
    readonly property color success: "#A6E3A1"
    readonly property color error: "#F38BA8"
    readonly property color warning: "#F9E2AF"
    
    // prefix for root
    readonly property string assetsPrefix: "../assets"
    readonly property string imgPrefix: assetsPrefix + "/img"
    readonly property string heroAvatarFormat: imgPrefix + "/set/%1/heroes/%2/avatar.webp"
    readonly property string fontsPrefix: assetsPrefix + "/fonts"

    // pages
    readonly property string pageSet: "set"
    readonly property string pageRandom: "random"
}