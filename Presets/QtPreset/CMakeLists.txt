cmake_minimum_required(VERSION 3.27)
project(QtPreset LANGUAGES CXX)

set(target qt_preset)
message(STATUS "Target: ${target}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(${target} main.cpp)

message(STATUS "Qt6 Version: " ${Qt6_VERSION})
message(STATUS "Qt6 Path: " ${Qt6_DIR})

set_target_properties(${target}
    PROPERTIES
        WIN32_EXECUTABLE TRUE
        MACOSX_BUNDLE TRUE
)

qt_add_qml_module(${target}
    URI "${CMAKE_PROJECT_NAME}Module"
    VERSION 1.0
    QML_FILES "Main.qml"
)

target_link_libraries(${target}
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
)

get_target_property(qt_target_type Qt6::Core TYPE)
if (${qt_target_type} STREQUAL "STATIC_LIBRARY")
    message(STATUS "Qt6 is linked statically")
    message(STATUS "Include qml plugins for static build")
    # https://doc.qt.io/qt-6/qt-import-qml-plugins.html
    find_package(Qt6QmlImportScanner REQUIRED)
    target_link_libraries(${target} PRIVATE
            Qt6::qtquick2plugin
            Qt6::QmlMeta
    )
    qt_import_qml_plugins(${target}) # Call as late as possible
else ()
    message(STATUS "Qt6 is linked dynamically")
endif ()

# check if build type is debug and set Qt Debug env variables
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "Build type is Debug")
    message(STATUS "Set Qt Debug env variables")
    set(ENV{QT_DEBUG_PLUGINS} "1")
    set(ENV{QML_IMPORT_TRACE} "1")
endif ()

