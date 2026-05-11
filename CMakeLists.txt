cmake_minimum_required(VERSION 3.16)

project(unmatched-tracker VERSION 0.1 LANGUAGES CXX)

# build variables
set(ANDROID_ABI arm64-v8a)
set(ANDROID_PLATFORM android-31)

set(SRC_DIR src)
set(QML_DIR ui)
set(ASSETS_DIR ${QML_DIR}/assets)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(tracker
    ${SRC_DIR}/main.cpp
)

set(plain_qml_files
    ${QML_DIR}/Main.qml
    ${QML_DIR}/views/Set.qml
    ${QML_DIR}/views/Random.qml
    ${QML_DIR}/components/Card.qml
    ${QML_DIR}/components/Header.qml
    ${QML_DIR}/components/Menu.qml
)

set(qml_singletons
    ${QML_DIR}/Tracker/Common.qml
)

set(rsc_files
    ${ASSETS_DIR}/img/set/battle_of_legends1/cover_ru.jpg
    ${ASSETS_DIR}/img/set/battle_of_legends2/cover_eng.jpg
    ${ASSETS_DIR}/img/set/cobble_fog/cover_ru.jpg
    ${ASSETS_DIR}/img/set/robingood_vs_bigfoot/cover_ru.jpg
    ${ASSETS_DIR}/img/ui/menu_logo.jpg
    ${ASSETS_DIR}/fonts/BebasNeue-Regular.ttf
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
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS tracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)