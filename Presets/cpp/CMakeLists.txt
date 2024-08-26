cmake_minimum_required(VERSION 3.27)
project(CppPreset LANGUAGES CXX)

set(target cpp_preset)
message(STATUS "Target: ${target}")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage -fPIC")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")

add_executable(${target} main.cpp)

set_target_properties(${target} PROPERTIES LINK_FLAGS "--coverage")
