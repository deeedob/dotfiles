#include "../shared.h"
#include <proto/data.grpc.pb.h>
#include <proto/data.pb.h>

#include <grpcpp/ext/proto_server_reflection_plugin.h>
#include <grpcpp/grpcpp.h>

#include <format>
#include <iostream>

class TestService : public api::PingPongService::Service
{
public:
    grpc::Status UnaryCall(
        grpc::ServerContext *context, const api::UnaryCallRequest *request,
        api::UnaryCallResponse *response
    ) override
    {
        (void)context;
        Log("ping {}", request->ping());
        response->set_pong(request->ping());
        return grpc::Status::OK;
    }
    grpc::Status ServerStreaming(
        grpc::ServerContext *context, const api::ServerStreamingRequest *request,
        grpc::ServerWriter<api::ServerStreamingResponse> *writer
    ) override
    {
        (void)context;
        api::ServerStreamingResponse response;
        Log("ping {}", request->ping());
        for (size_t i = 0; i < request->ping(); ++i) {
            response.set_pong(i);
            writer->Write(response);
        }
        Log("finish");
        return grpc::Status::OK;
    }
    grpc::Status ClientStreaming(
        grpc::ServerContext *context, grpc::ServerReader<api::ClientStreamingRequest> *reader,
        api::ClientStreamingResponse *response
    ) override
    {
        (void)context;
        api::ClientStreamingRequest request;
        size_t count = 0;
        while (reader->Read(&request)) {
            Log("ping {}", request.ping());
            ++count;
        }
        response->set_pong(count);
        Log("finish");
        return grpc::Status::OK;
    }
    grpc::Status BiDirStreaming(
        grpc::ServerContext *context,
        grpc::ServerReaderWriter<api::BiDirStreamingResponse, api::BiDirStreamingRequest> *stream
    ) override
    {
        api::BiDirStreamingRequest request;
        api::BiDirStreamingResponse response;
        size_t count = 0;
        while (stream->Read(&request)) {
            Log("ping {}", request.ping());
            response.set_pong(request.ping());
            stream->Write(response);
            ++count;
        }
        response.set_pong(count);
        stream->Write(response);
        Log("finish");
        return grpc::Status::OK;
    }

private:
};

int main()
{
    std::unique_ptr<grpc::Server> server;
    TestService service;
    {
        grpc::reflection::InitProtoReflectionServerBuilderPlugin();
        grpc::ServerBuilder builder;
        builder.AddListeningPort(ServerUri.data(), grpc::InsecureServerCredentials());
        builder.RegisterService(&service);
        server = builder.BuildAndStart();
    }
    std::cout << std::format("Server listening on: {}\n", ServerUri.data());
    server->Wait();
}
