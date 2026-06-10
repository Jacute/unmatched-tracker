cmake_minimum_required(VERSION 3.16)

project(unmatched-tracker VERSION 0.1 LANGUAGES CXX)

set(SRC_DIR src)
set(QML_DIR ui)
set(ASSETS_DIR ${QML_DIR}/assets)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup()
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_executable(tracker
    ${SRC_DIR}/main.cpp
    ${SRC_DIR}/log.cpp
    ${SRC_DIR}/config.cpp
    ${SRC_DIR}/db/db.cpp
    ${SRC_DIR}/db/migrator.cpp
    ${SRC_DIR}/backend/backend.cpp
    ${SRC_DIR}/components/render/imagerounded.cpp
)

set(plain_qml_files
    ${QML_DIR}/Main.qml
    ${QML_DIR}/views/set/SetStack.qml
    ${QML_DIR}/views/set/Set.qml
    ${QML_DIR}/views/set/Heroes.qml
    ${QML_DIR}/views/set/Hero.qml
    ${QML_DIR}/views/Random.qml
    ${QML_DIR}/components/Card.qml
    ${QML_DIR}/components/CardGrid.qml
    ${QML_DIR}/components/Header.qml
    ${QML_DIR}/components/Menu.qml
    ${QML_DIR}/components/RandomWheel.qml
    ${QML_DIR}/components/RandomFilter.qml
    ${QML_DIR}/components/MultiSelectDropdown.qml
    ${QML_DIR}/components/VS.qml
    ${QML_DIR}/components/GameMap.qml
    ${QML_DIR}/components/Notif.qml
    ${QML_DIR}/components/Btn.qml
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

qt_add_qml_module(tracker
    URI Tracker
    QML_FILES ${plain_qml_files} ${qml_singletons}
    RESOURCES ${rsc_files}
)

set_target_properties(tracker PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

set_property(TARGET tracker PROPERTY
    QT_ANDROID_PACKAGE_NAME "com.jacute.unmatched_tracker"
)
target_compile_definitions(tracker PRIVATE
    PACKAGE_NAME="${PACKAGE_NAME}"
)

target_link_libraries(tracker
    PRIVATE
        Qt6::Quick
        Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS tracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)