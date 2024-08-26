cmake_minimum_required(VERSION 3.9)
project(GrpcPreset LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Protobuf CONFIG REQUIRED)
find_package(gRPC REQUIRED)

set(proto_file "${CMAKE_CURRENT_LIST_DIR}/data.proto" CACHE STRING "protobuf file")
set(proto_imp "${CMAKE_CURRENT_LIST_DIR}" CACHE STRING "protobuf import")
set(proto_out "${CMAKE_CURRENT_BINARY_DIR}/include/proto" CACHE STRING "protobuf output")

add_library(proto-object OBJECT ${proto_file})
target_include_directories(proto-object
    PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
)
target_link_libraries(proto-object PUBLIC
    protobuf::libprotobuf
    gRPC::grpc++
)

# https://github.com/protocolbuffers/protobuf/blob/main/docs/cmake_protobuf_generate.md
protobuf_generate(
    TARGET proto-object
    IMPORT_DIRS ${proto_imp}
    PROTOC_OUT_DIR ${proto_out}
)

protobuf_generate(
    TARGET proto-object
    LANGUAGE grpc
    GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc
    PLUGIN "protoc-gen-grpc=\$<TARGET_FILE:gRPC::grpc_cpp_plugin>"
    IMPORT_DIRS ${proto_imp}
    PROTOC_OUT_DIR "${proto_out}"
)

add_subdirectory(src/servers)
add_subdirectory(src/clients)

