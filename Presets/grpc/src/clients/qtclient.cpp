#include "../shared.h"
#include <proto/qt/data.qpb.h>
#include <proto/qt/data_client.grpc.qpb.h>

#include <QtCore/QCoreApplication>
#include <QtGrpc/QtGrpc>

#include <memory>

class PingPongClient
{
public:
    explicit PingPongClient(std::shared_ptr<QGrpcHttp2Channel> channel)
    {
        mClient.attachChannel(std::move(channel));
    }

    static void finishHandler() { Log("Finish"); }

    static void errorOccurredHandler(const QGrpcStatus &status)
    {
        QString str;
        QDebug dbg(&str);
        dbg << status;
        Log("status: {}", str.toStdString());
    }

    void unaryCall(size_t amount)
    {
        static auto readHandler = [](const std::shared_ptr<QGrpcCallReply> &reply) {
            if (const auto res = reply->read<api::UnaryCallResponse>()) {
                Log("pong: {}", res->pong());
            } else {
                Log("read failed");
            }
        };

        api::UnaryCallRequest request;
        size_t count = 0;
        while (count++ < amount) {
            request.setPing(count);
            mClient.UnaryCall(request, &mClient, readHandler);
        }
    }

    void serverStreaming(size_t amount)
    {
        static auto readHandler = [](const std::shared_ptr<QGrpcServerStream> &reply) {
            if (const auto res = reply->read<api::ServerStreamingResponse>()) {
                Log("pong: {}", res->pong());
            } else {
                Log("read failed");
            }
        };

        api::ServerStreamingRequest request;
        request.setPing(amount);
        const auto stream = mClient.ServerStreaming(request, QGrpcCallOptions().withDeadline(2500ms));

        QObject::connect(stream.get(), &QGrpcServerStream::messageReceived, &mClient, [stream] {
            return readHandler(stream);
        });
        QObject::connect(
            stream.get(), &QGrpcServerStream::finished, &mClient, &PingPongClient::finishHandler
        );
        QObject::connect(
            stream.get(), &QGrpcServerStream::errorOccurred, &mClient,
            &PingPongClient::errorOccurredHandler
        );
    }

    void clientStreaming(size_t amount)
    {
        static auto readHandler = [](const std::shared_ptr<QGrpcClientStream> &reply) {
            if (const auto res = reply->read<api::ClientStreamingResponse>()) {
                Log("pong: {}", res->pong());
            } else {
                Log("read failed");
            }
        };

        api::ClientStreamingRequest request;
        request.setPing(amount);

        const auto stream = mClient.ClientStreaming(request);
        QObject::connect(stream.get(), &QGrpcClientStream::finished, &mClient, [stream]() {
            readHandler(stream);
        });
        QObject::connect(
            stream.get(), &QGrpcClientStream::errorOccurred, &mClient,
            &PingPongClient::errorOccurredHandler
        );

        size_t count = 0;
        while (count++ < amount) {
            request.setPing(count);
            // stream->writeMessage(request);
            Log("ping: {}", request.ping());
        }
        stream->writesDone();
    }

    void bidirStreaming(size_t amount)
    {
        static auto readHandler = [amount](const std::shared_ptr<QGrpcBidirStream> &reply) {
            if (const auto res = reply->read<api::BiDirStreamingResponse>()) {
                Log("pong: {}", res->pong());
                if (res->pong() < amount) {
                    api::BiDirStreamingRequest request;
                    request.setPing(res->pong() + 1);
                    // reply->writeMessage(request);
                } else {
                    reply->writesDone();
                }
            } else {
                Log("read failed");
                reply->cancel();
            }
        };

        api::BiDirStreamingRequest request;
        request.setPing(0);

        const auto stream = mClient.BiDirStreaming(request);
        QObject::connect(stream.get(), &QGrpcBidirStream::messageReceived, &mClient, [stream]{
            readHandler(stream);
        });
        QObject::connect(
            stream.get(), &QGrpcBidirStream::finished, &mClient, &PingPongClient::finishHandler
        );
        QObject::connect(
            stream.get(), &QGrpcBidirStream::errorOccurred, &mClient,
            &PingPongClient::errorOccurredHandler
        );
    }

private:
    api::PingPongService::Client mClient;
};

int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);

    QGrpcChannelOptions opts(QUrl(QString("http://") + QString(ServerUri.data())));
    PingPongClient client(std::make_shared<QGrpcHttp2Channel>(opts));

    // client.unaryCall(3);
    // client.serverStreaming(3);
    // client.clientStreaming(3);
    client.bidirStreaming(3);

    qDebug() << "++++ Starting event loop ++++";
    return app.exec();
}
