#include <cassert>
#include <iostream>
#include "../firmware/MiniBaymax/ServoController.h"
bool allOff() {
  for (int n = 0; n < 16; ++n) if (Wire.regs[0x09 + 4*n] != 0x10) return false;
  return true;
}
int main() {
  ServoController disabled;
  assert(disabled.begin(false));
  assert(Wire.sda == 8 && Wire.scl == 9 && allOff());
  assert(!disabled.gesture(0) && Wire.pulses.empty());
  ServoController enabled;
  assert(enabled.begin(true));
  assert(Wire.regs[0xFE] == 130 && Wire.regs[0x01] == 4);
  assert(!enabled.gesture(3));
  for (int axis = 0; axis < 3; ++axis) {
    Wire.pulses.clear(); assert(enabled.gesture(axis));
    assert(!enabled.gesture((axis+1)%3)); // no overlapping gestures
    for (int n = 0; n < 310; ++n) { testClock += 20; enabled.tick(); }
    assert(!enabled.moving() && allOff());
    assert(Wire.pulses.size() > 50);
    int lo = 1000, hi = 0;
    int previous = Wire.pulses.front().second;
    for (auto sample : Wire.pulses) {
      assert(sample.first == axis);
      assert(sample.second >= 205 && sample.second <= 411); // 1000..2000 us nominal 90-degree travel
      assert(abs(sample.second - previous) <= 3); // no coarse PWM jumps
      previous = sample.second;
      lo = min(lo, sample.second); hi = max(hi, sample.second);
    }
    assert(lo == 205 && hi == 411); // reaches both configured endpoints
    assert(Wire.pulses.front().second == 308 && Wire.pulses.back().second == 308);
    // Starts and changes direction slowly, with no endpoint snap.
    assert(abs(Wire.pulses[15].second - 308) <= 1);
    int endpoint = axis == 2 ? lo : hi;
    for (int n = 77; n <= 83; ++n) assert(abs(Wire.pulses[n].second - endpoint) <= 1);
  }
  Wire.pulses.clear();
  assert(enabled.gesture(1, true, 75));
  for (int n = 0; n < 310; ++n) { testClock += 20; enabled.tick(); }
  bool headSeen = false, armSeen = false;
  for (auto sample : Wire.pulses) {
    assert(sample.first == 0 || sample.first == 1);
    assert(sample.second >= 205 && sample.second <= 411);
    headSeen |= sample.first == 0; armSeen |= sample.first == 1;
  }
  assert(headSeen && armSeen && allOff());
  Wire.pulses.clear();
  assert(enabled.gesture(2, true, 100, true));
  for (int n = 0; n < 310; ++n) { testClock += 20; enabled.tick(); }
  int previousArm = 308, crosses = 0, livelyLo = 1000, livelyHi = 0;
  for (auto sample : Wire.pulses) {
    assert(sample.second >= 205 && sample.second <= 411);
    if (sample.first == 2) {
      assert(abs(sample.second - previousArm) <= 6);
      if (previousArm < 308 && sample.second >= 308) ++crosses;
      livelyLo = min(livelyLo, sample.second); livelyHi = max(livelyHi, sample.second);
      previousArm = sample.second;
    }
  }
  assert(crosses >= 2 && previousArm == 308 && allOff());
  assert(livelyLo == 205 && livelyHi == 411); // repeated fast cycles still reach full travel
  assert(enabled.gesture(0));
  for (int n = 0; n < 35; ++n) { testClock += 20; enabled.tick(); }
  int beforeStall = Wire.pulses.back().second;
  testClock += 1500; enabled.tick();
  assert(abs(Wire.pulses.back().second - beforeStall) <= 6);
  testClock += 12000; enabled.tick(); assert(allOff() && !enabled.moving());
  assert(enabled.gesture(0)); enabled.stop(); assert(allOff() && !enabled.moving());
  assert(enabled.gesture(1));
  Wire.failed = true; testClock += 20; enabled.tick();
  assert(!enabled.permitted() && !enabled.moving());
  Wire.failed = false; enabled.stop();
  assert(!enabled.gesture(0)); // recovered I2C cannot silently re-enable motion
  std::cout << "PASS: servo controller: disabled boot, full configured travel, eased endpoints, bounded steps, stall handling, centering, stop and I2C failure\n";
}
