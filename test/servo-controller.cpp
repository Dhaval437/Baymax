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
    for (int n = 0; n < 180; ++n) { testClock += 20; enabled.tick(); }
    assert(!enabled.moving() && allOff());
    assert(Wire.pulses.size() > 50);
    int lo = 1000, hi = 0;
    for (auto sample : Wire.pulses) {
      assert(sample.first == axis);
      assert(sample.second >= 288 && sample.second <= 329); // 1400..1600 us
      lo = min(lo, sample.second); hi = max(hi, sample.second);
    }
    assert(hi - lo > 20);
    assert(Wire.pulses.front().second == 308 && Wire.pulses.back().second == 308);
  }
  assert(enabled.gesture(0)); enabled.stop(); assert(allOff() && !enabled.moving());
  assert(enabled.gesture(1));
  Wire.failed = true; testClock += 20; enabled.tick();
  assert(!enabled.permitted() && !enabled.moving());
  Wire.failed = false; enabled.stop();
  assert(!enabled.gesture(0)); // recovered I2C cannot silently re-enable motion
  std::cout << "PASS: real firmware servo controller: disabled boot, channels, bounds, ramp, centering, stop and I2C failure\n";
}
