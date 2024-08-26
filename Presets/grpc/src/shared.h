#pragma once

#include <format>
#include <iostream>
#include <source_location>
#include <string_view>
#include <chrono>
#include <thread>

constexpr std::string_view ServerUri = "localhost:50051";

using namespace std::chrono_literals;

template <typename... Args>
struct Log
{
    explicit Log(
        std::format_string<Args...> fmt, Args &&...args,
        const std::source_location &loc = std::source_location::current()
    )
    {
        auto fnName = std::string(loc.function_name());
        auto firstPos = fnName.find('(');
        auto lastPos = fnName.find(')') + 1;
        while (firstPos != std::string::npos && lastPos != std::string::npos) {
            fnName.erase(firstPos, lastPos - firstPos);
            firstPos = fnName.find('(');
            lastPos = fnName.find(')') + 1;
        }
        std::clog << std::format(
            "{:<80} {}\n", fnName,
            std::format(std::forward<decltype(fmt)>(fmt), std::forward<Args>(args)...)
        );
    }
};
template <typename... Args>
Log(std::format_string<Args...>, Args &&...) -> Log<Args...>;

#ifdef ENABLE_LOGGING
    #define DLOG(fmt, ...) Log(fmt __VA_OPT__(,) __VA_ARGS__)
#else
    #define DLOG(fmt, ...) // Do nothing
#endif

namespace Debug {

inline void setGrpcTrace(std::initializer_list<std::string_view> args = {})
{
    // https://github.com/grpc/grpc/blob/master/doc/environment_variables.md
    if (args.size() == 0)
        return;
    std::string constructedArg;
    for (size_t pos = 0; const auto &a : args) {
        constructedArg.append(a);
        if (++pos == args.size() - 1)
            constructedArg += ',';
    }
    Log("GrpcTrace: {}", constructedArg);
    setenv("GRPC_TRACE", constructedArg.data(), 1);
}

inline void setGrpcEnvs(
    std::initializer_list<std::pair<std::string_view, std::string_view>> args
    = { { "GRPC_ABORT_ON_LEAKS", "1" } }
)
{
    if (args.size() == 0)
        return;
    for (const auto &a : args)
        setenv(a.first.data(), a.second.data(), 1);
}

inline void setGrpcVerbosity(std::string_view verbosity = "error")
{
    if (verbosity != "debug" && verbosity != "info" && verbosity != "error") {
        Log("verbosity must be 'debug', 'info' or 'error', got: {}", verbosity);
        return;
    }
    setenv("GRPC_VERBOSITY", verbosity.data(), 1);
}

} // namespace Debug

