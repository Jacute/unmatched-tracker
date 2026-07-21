cmake_minimum_required(VERSION 3.16)

project(unmatched-tracker VERSION 0.0.1 LANGUAGES CXX)

set(TARGET tracker)
set(SRC_DIR src)
set(QML_DIR ui)
set(ASSETS_DIR ${QML_DIR}/assets)

find_package(Qt6 6.11 REQUIRED COMPONENTS Quick Sql Network)

qt_standard_project_setup()
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_executable(${TARGET}
    ${SRC_DIR}/main.cpp
    ${SRC_DIR}/log.cpp
    ${SRC_DIR}/config.cpp
    ${SRC_DIR}/api/api.cpp
    ${SRC_DIR}/db/db.cpp
    ${SRC_DIR}/db/migrator.cpp
    ${SRC_DIR}/core/core.cpp
    ${SRC_DIR}/core/db_exporter.cpp
    ${SRC_DIR}/files/filecache.cpp
    ${SRC_DIR}/files/provider.cpp
    ${SRC_DIR}/components/render/imagerounded.cpp
)

set(plain_qml_files
    ${QML_DIR}/Main.qml
    ${QML_DIR}/views/Home.qml
    ${QML_DIR}/views/set/SetStack.qml
    ${QML_DIR}/views/set/Set.qml
    ${QML_DIR}/views/set/hero/Hero.qml
    ${QML_DIR}/views/set/hero/Avatar.qml
    ${QML_DIR}/views/set/hero/TabMenu.qml
    ${QML_DIR}/views/set/hero/tabs/Cards.qml
    ${QML_DIR}/views/set/hero/tabs/CommonStat.qml
    ${QML_DIR}/views/set/hero/tabs/ProfileStat.qml
    ${QML_DIR}/views/set/hero/tabs/Matchups.qml
    ${QML_DIR}/views/Random.qml
    ${QML_DIR}/views/Profiles.qml
    ${QML_DIR}/views/Games.qml
    ${QML_DIR}/views/Settings.qml
    ${QML_DIR}/components/Card.qml
    ${QML_DIR}/components/CardGrid.qml
    ${QML_DIR}/components/BigImagePopup.qml
    ${QML_DIR}/components/Header.qml
    ${QML_DIR}/components/Menu.qml
    ${QML_DIR}/components/RandomWheel.qml
    ${QML_DIR}/components/RandomFilter.qml
    ${QML_DIR}/components/MultiSelectDropdown.qml
    ${QML_DIR}/components/FieldBox.qml
    ${QML_DIR}/components/ThemedComboBox.qml
    ${QML_DIR}/components/StatTile.qml
    ${QML_DIR}/components/DeleteConfirmPopup.qml
    ${QML_DIR}/components/VS.qml
    ${QML_DIR}/components/GameMap.qml
    ${QML_DIR}/components/GameHistory.qml
    ${QML_DIR}/components/GameParticipantInput.qml
    ${QML_DIR}/components/Notif.qml
    ${QML_DIR}/components/Btn.qml
    ${QML_DIR}/components/ImagePlaceholder.qml
    ${QML_DIR}/components/LoadImage.qml
    ${QML_DIR}/components/ico/MenuIco.qml
    ${QML_DIR}/components/ico/BackIco.qml
)

set(qml_singletons
    ${QML_DIR}/Tracker/Common.qml
)

file(GLOB_RECURSE rsc_files CONFIGURE_DEPENDS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    "ui/assets/img/*.jpg"
    "ui/assets/img/*.png"
    "ui/assets/img/*.webp"
    "ui/assets/fonts/*.ttf"
    "ui/*.js"
    "src/migrations/*.up.sql"
)
list(APPEND rsc_files
    "src/config.json"
)

set_source_files_properties(${qml_singletons}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(${TARGET}
    URI Tracker
    QML_FILES ${plain_qml_files} ${qml_singletons}
    RESOURCES ${rsc_files}
)

set_target_properties(${TARGET} PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if(ANDROID)
    math(EXPR ANDROID_VERSION_CODE
        "${PROJECT_VERSION_MAJOR} * 10000 + ${PROJECT_VERSION_MINOR} * 100 + ${PROJECT_VERSION_PATCH}"
    )

    set_target_properties(${TARGET} PROPERTIES
        QT_ANDROID_PACKAGE_SOURCE_DIR
            "${CMAKE_CURRENT_SOURCE_DIR}/android"

        QT_ANDROID_APP_ICON
            "@drawable/ic_launcher"

        QT_ANDROID_APP_NAME
            "Unmatched Tracker"

        QT_ANDROID_PACKAGE_NAME "com.jacute.unmatched_tracker"
        QT_ANDROID_VERSION_NAME "${PROJECT_VERSION}"
        QT_ANDROID_VERSION_CODE "${ANDROID_VERSION_CODE}"
    )
endif()
target_compile_definitions(${TARGET} PRIVATE
    PACKAGE_NAME="${PACKAGE_NAME}"
    API_URL="${API_URL}"
    APP_VERSION="${PROJECT_VERSION}"
)

target_link_libraries(${TARGET}
    PRIVATE
        Qt6::Quick
        Qt6::Sql
        Qt6::Network
)

include(GNUInstallDirs)
install(TARGETS tracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
