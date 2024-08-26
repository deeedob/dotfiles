cmake_minimum_required(VERSION 3.9)

add_executable(syncclient syncclient.cpp)
target_link_libraries(syncclient PRIVATE proto-object)

find_package(Qt6 COMPONENTS Grpc)

if (Qt6_FOUND)
    cmake_policy(SET CMP0071 NEW)
    qt_standard_project_setup()

    qt_add_executable(qtclient qtclient.cpp)

    qt_add_protobuf(qtclient-proto
        PROTO_FILES ${proto_file}
        PROTO_INCLUDES ${proto_imp}
        OUTPUT_DIRECTORY "${proto_out}/qt"
    )

    qt_add_grpc(qtclient-proto CLIENT
        PROTO_FILES ${proto_file}
        PROTO_INCLUDES ${proto_imp}
        OUTPUT_DIRECTORY "${proto_out}/qt"
    )

    target_link_libraries(qtclient PRIVATE Qt6::Grpc qtclient-proto)
    target_include_directories(qtclient
        PUBLIC "$<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/include>"
    )
endif()


