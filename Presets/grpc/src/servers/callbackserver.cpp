#include "../shared.h"
#include <proto/data.grpc.pb.h>
#include <proto/data.pb.h>

#include <grpcpp/ext/proto_server_reflection_plugin.h>
#include <grpcpp/grpcpp.h>

static std::atomic<uint64_t> sStreamCount = 0;

class PingPongService : public api::PingPongService::CallbackService
{
public:
    grpc::ServerUnaryReactor *UnaryCall(
        grpc::CallbackServerContext *context, const api::UnaryCallRequest *request,
        api::UnaryCallResponse *response
    ) override
    {
        class UnaryReactor : public grpc::ServerUnaryReactor
        {
        public:
            UnaryReactor(
                grpc::CallbackServerContext *context, const api::UnaryCallRequest *request,
                api::UnaryCallResponse *response
            )
                : mContext(context), mRequest(request), mResponse(response)
            {
                ++sStreamCount;
                DLOG("created: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                DLOG("ping {}", mRequest->ping());
                mResponse->set_pong(mRequest->ping());
                Finish(grpc::Status::OK);
            }
            void OnSendInitialMetadataDone(bool ok) override
            {
                DLOG("on send initial metadata: {}", ok);
            }
            void OnDone() override
            {
                --sStreamCount;
                DLOG("deleted: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                delete this;
            }
            void OnCancel() override
            {
                DLOG("client cancelled");
                Finish(grpc::Status::CANCELLED);
            }

        private:
            grpc::CallbackServerContext *mContext = nullptr;
            const api::UnaryCallRequest *mRequest = nullptr;
            api::UnaryCallResponse *mResponse = nullptr;
        };
        return new UnaryReactor(context, request, response);
    }
    grpc::ServerWriteReactor<api::ServerStreamingResponse> *ServerStreaming(
        grpc::CallbackServerContext *context, const api::ServerStreamingRequest *request
    ) override
    {
        class WriteReactor : public grpc::ServerWriteReactor<api::ServerStreamingResponse>
        {
        public:
            explicit WriteReactor(
                grpc::CallbackServerContext *context, const api::ServerStreamingRequest *request
            )
                : mContext(context), mRequest(request)
            {
                ++sStreamCount;
                DLOG("created: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                DLOG("ping {}", mRequest->ping());
                mResponse.set_pong(0);
                StartWrite(&mResponse);
            }
            void OnSendInitialMetadataDone(bool ok) override { Log("initial metadata: {}", ok); }

            void OnWriteDone(bool ok) override
            {
                DLOG("writeDone({})", ok);
                std::this_thread::sleep_for(1000ms);
                if (ok) {
                    if (mResponse.pong() < mRequest->ping()) {
                        mResponse.set_pong(mResponse.pong() + 1);
                        StartWrite(&mResponse);
                    } else {
                        Finish(grpc::Status::OK);
                    }
                }
            }
            void OnDone() override
            {
                --sStreamCount;
                DLOG("deleted: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                delete this;
            }
            void OnCancel() override
            {
                DLOG("client cancelled");
                Finish(grpc::Status::CANCELLED);
            }

        private:
            grpc::CallbackServerContext *mContext;
            const api::ServerStreamingRequest *mRequest = nullptr;
            api::ServerStreamingResponse mResponse;
        };
        return new WriteReactor(context, request);
    }
    grpc::ServerReadReactor<api::ClientStreamingRequest> *ClientStreaming(
        grpc::CallbackServerContext *context, api::ClientStreamingResponse *response
    ) override
    {
        class ReadReactor : public grpc::ServerReadReactor<api::ClientStreamingRequest>
        {
        public:
            explicit ReadReactor(
                grpc::CallbackServerContext *context, api::ClientStreamingResponse *response
            )
                : mContext(context), mResponse(response)
            {
                ++sStreamCount;
                DLOG("created: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                StartRead(&mRequest);
            }
            void OnSendInitialMetadataDone(bool ok) override { Log("initial metadata: {}", ok); }
            void OnReadDone(bool ok) override
            {
                DLOG("readDone({}): ping {}", ok, mRequest.ping());
                if (ok) {
                    StartRead(&mRequest);
                } else {
                    if (mContext->IsCancelled())
                        return;
                    mResponse->set_pong(mCallCount);
                    Finish(grpc::Status::OK);
                }
                ++mCallCount;
            }
            void OnDone() override
            {
                --sStreamCount;
                DLOG("deleted: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                delete this;
            }
            void OnCancel() override
            {
                DLOG("client cancelled");
                Finish(grpc::Status::CANCELLED);
            }

        private:
            grpc::CallbackServerContext *mContext;
            api::ClientStreamingRequest mRequest;
            api::ClientStreamingResponse *mResponse;
            size_t mCallCount = 0;
        };
        return new ReadReactor(context, response);
    }
    grpc::ServerBidiReactor<api::BiDirStreamingRequest, api::BiDirStreamingResponse> *
    BiDirStreaming(grpc::CallbackServerContext *context) override
    {
        class BidiReactor : public grpc::ServerBidiReactor<
                                api::BiDirStreamingRequest, api::BiDirStreamingResponse>
        {
        public:
            explicit BidiReactor(grpc::CallbackServerContext *context) : mContext(context)
            {
                ++sStreamCount;
                DLOG("created: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                StartRead(&mRequest);
            }
            void OnSendInitialMetadataDone(bool ok) override
            {
                DLOG("send initial metadata: {}", ok);
            }
            void OnReadDone(bool ok) override
            {
                DLOG("readDone({}): ping {}", ok, mRequest.ping());
                if (ok) {
                    mResponse.set_pong(mRequest.ping());
                    StartWrite(&mResponse);
                } else {
                    if (mContext->IsCancelled())
                        return;
                    Finish(grpc::Status::OK);
                }
                ++mCallCount;
            }
            void OnWriteDone(bool ok) override
            {
                DLOG("writeDone({})", ok);
                if (ok) {
                    StartRead(&mRequest);
                }
            }
            void OnDone() override
            {
                --sStreamCount;
                DLOG("deleted: #{}; streamCount: {}", reinterpret_cast<intptr_t>(this),
                    sStreamCount.load());
                delete this;
            }
            void OnCancel() override
            {
                DLOG("client cancelled");
                Finish(grpc::Status::CANCELLED);
            }

        private:
            grpc::CallbackServerContext *mContext;
            api::BiDirStreamingRequest mRequest;
            api::BiDirStreamingResponse mResponse;
            size_t mCallCount = 0;
        };
        return new BidiReactor(context);
    }
};

int main(int argc, char *argv[])
{
    Debug::setGrpcEnvs();
    Debug::setGrpcTrace();
    Debug::setGrpcVerbosity();

    std::unique_ptr<grpc::Server> server;
    PingPongService service;
    {
        grpc::reflection::InitProtoReflectionServerBuilderPlugin();
        grpc::ServerBuilder builder;
        builder.AddListeningPort(ServerUri.data(), grpc::InsecureServerCredentials());
        builder.RegisterService(&service);
        server = builder.BuildAndStart();
    }
    std::cout << std::format("Server listening on: {}\n", ServerUri);
    server->Wait();
}
