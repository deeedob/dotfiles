cmake_minimum_required(VERSION 3.27)
project(QtPreset LANGUAGES CXX)

set(target qt_preset)
message(STATUS "Target: ${target}")

find_package(Qt6 REQUIRED COMPONENTS Core)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(${target} main.cpp)

message(STATUS "Qt6 Version: " ${Qt6_VERSION})
message(STATUS "Qt6 Path: " ${Qt6_DIR})

set_target_properties(${target}
    PROPERTIES
        WIN32_EXECUTABLE TRUE
        MACOSX_BUNDLE TRUE
)

target_link_libraries(${target}
    PRIVATE
        Qt6::Core
)

# TODO: add those to runtime. this is bullshit
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "Applying Qt Debug env variables")
    set(ENV{QT_DEBUG_PLUGINS} "1")
    set(ENV{QML_IMPORT_TRACE} "1")
endif ()

