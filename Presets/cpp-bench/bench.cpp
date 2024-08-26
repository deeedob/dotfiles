#include <benchmark/benchmark.h>
#include <memory>

class Pimpl {
  struct PimplPrivate {
    std::string name;
  };

public:
  explicit Pimpl(std::string s)
      : dPtr(std::make_unique<PimplPrivate>(std::move(s))) {}
  [[nodiscard]] std::string_view get() const { return dPtr->name; }
  void set(std::string s) { dPtr->name = std::move(s); }

private:
  std::unique_ptr<PimplPrivate> dPtr;
};

class Inline {
public:
  explicit Inline(std::string s) : name(std::move(s)) {}
  [[nodiscard]] std::string_view get() const { return name; }
  void set(std::string s) { name = std::move(s); }

private:
  std::string name;
};

static void BM_PimplGet(benchmark::State &state) {
  Pimpl data(std::string(1024 * 16, 'c'));
  for (auto _ : state) {
      benchmark::DoNotOptimize(data.get());
  }
}

static void BM_InlineGet(benchmark::State &state) {
  Inline data(std::string(1024 * 16, 'c'));
  for (auto _ : state) {
      benchmark::DoNotOptimize(data.get());
  }
}

static void BM_PimplRAII(benchmark::State &state) {
    std::string data(1024, 'c');
    for (auto _ : state)
        Pimpl temp(data);
}

static void BM_InlineRAII(benchmark::State &state) {
    std::string data(1024, 'c');
    for (auto _ : state)
        Inline temp(data);
}

BENCHMARK(BM_PimplGet);
BENCHMARK(BM_InlineGet);

BENCHMARK(BM_PimplRAII);
BENCHMARK(BM_InlineRAII);

BENCHMARK_MAIN();
