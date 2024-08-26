cmake_minimum_required(VERSION 3.9)

add_executable(syncserver syncserver.cpp)
target_link_libraries(syncserver PRIVATE proto-object gRPC::grpc++_reflection)

add_executable(callbackserver callbackserver.cpp)
target_link_libraries(callbackserver PRIVATE proto-object gRPC::grpc++_reflection)
