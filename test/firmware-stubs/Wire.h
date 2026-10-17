#pragma once
#include <cstdint>
#include <vector>
#include <array>
struct FakeWire {
  std::array<uint8_t, 256> regs{};
  std::vector<uint8_t> pending;
  std::vector<std::pair<int,int>> pulses;
  int cursor = 0, sda = -1, scl = -1;
  bool failed = false;
  void begin(int data, int clock) { sda = data; scl = clock; }
  void setClock(int) {}
  void setTimeOut(int) {}
  void beginTransmission(int) { pending.clear(); }
  void write(uint8_t n) { pending.push_back(n); }
  int endTransmission(bool = true) {
    if (failed || pending.empty()) return 4;
    cursor = pending[0];
    for (size_t n = 1; n < pending.size(); ++n) regs[pending[0] + n - 1] = pending[n];
    if (pending.size() == 5 && pending[0] >= 6 && pending[0] < 70) {
      int channel = (pending[0] - 6) / 4;
      pulses.emplace_back(channel, pending[3] | pending[4] << 8);
    }
    return 0;
  }
  int requestFrom(uint8_t, uint8_t n) { return failed ? 0 : n; }
  int read() { return regs[cursor++]; }
};
inline FakeWire Wire;
