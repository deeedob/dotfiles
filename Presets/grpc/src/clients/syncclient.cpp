#include "../shared.h"
#include <proto/data.grpc.pb.h>
#include <proto/data.pb.h>

#include <grpcpp/grpcpp.h>

#include <memory>
#include <iostream>

class PingPongClient
{
public:
    explicit PingPongClient(const std::shared_ptr<grpc::Channel>& channel)
        : mStub(api::PingPongService::NewStub(channel))
    {
    }

    void unaryCall(size_t amount)
    {
        size_t count = 0;
        api::UnaryCallRequest request;
        api::UnaryCallResponse response;
        while (count++ < amount) {
            grpc::ClientContext ctx;
            request.set_ping(count);
            const auto status = mStub->UnaryCall(&ctx, request, &response);
            Log("pong: {}", response.pong());
        }
    }

    void serverStreaming(size_t amount)
    {
        api::ServerStreamingRequest request;
        request.set_ping(amount);
        api::ServerStreamingResponse response;

        grpc::ClientContext ctx;
        const auto time = std::chrono::system_clock::now() +
            std::chrono::milliseconds(1000);
        ctx.set_deadline(time);

        auto stream = mStub->ServerStreaming(&ctx, request);
        while (stream->Read(&response)) {
            Log("pong {}", response.pong());
        }
        const auto status = stream->Finish();
        Log("status: code {}", status.error_message());
    }

    void clientStreaming(size_t amount)
    {
        size_t count = 0;
        api::ClientStreamingRequest request;
        api::ClientStreamingResponse response;
        grpc::ClientContext ctx;
        auto stream = mStub->ClientStreaming(&ctx, &response);
        while (count++ < amount) {
            request.set_ping(count);
            stream->Write(request);
            Log("ping {}", request.ping());
        }
        stream->WritesDone();
        Log("pong: ", response.pong());
        const auto status = stream->Finish();
        Log("status: code {}", status.error_message());
    }

    void bidirStreaming(size_t amount)
    {

        size_t count = 0;
        api::BiDirStreamingRequest request;
        api::BiDirStreamingResponse response;
        grpc::ClientContext ctx;
        auto stream = mStub->BiDirStreaming(&ctx);
        while (count++ < amount) {
            request.set_ping(count);
            assert(stream->Write(request));
            stream->Read(&response);
            assert(request.ping() == response.pong());
            std::cout << "BiDirStreaming got pong: " << response.pong() << "\n";
        }
        stream->WritesDone();
        const auto status = stream->Finish();
        Log("status: code {}", status.error_message());
    }
private:
    std::unique_ptr<api::PingPongService::Stub> mStub;
};

int main()
{
    Debug::setGrpcTrace();
    Debug::setGrpcEnvs();
    Debug::setGrpcVerbosity();

    PingPongClient client(grpc::CreateChannel(ServerUri.data(), grpc::InsecureChannelCredentials()));
    client.serverStreaming(3);
    // client.unaryCall(3);
    // client.serverStreaming(3);
    // client.clientStreaming(3);
    // client.bidirStreaming(3);

    return 0;
}
