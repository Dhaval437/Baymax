#pragma once
#include <stdint.h>

// Estimate quiet-room level from a window, not every sub-threshold frame.
// A burst of almost-triggering speech must not ratchet the threshold upwards.
class NoiseFloor {
  static constexpr unsigned WINDOW = 125; // approximately two seconds of 16ms frames
  uint16_t levels_[WINDOW] = {};
  unsigned count_ = 0;
  float floor_ = 80;
  static float bounded(float value) {
    return value < 30 ? 30 : (value > 800 ? 800 : value);
  }
public:
  void reset(float initial) { floor_ = bounded(initial); count_ = 0; }
  float value() const { return floor_; }
  float threshold(float minimum) const {
    const float scaled = floor_ * 2.5f;
    return scaled > minimum ? scaled : minimum;
  }
  void observe(float rms, bool eligible) {
    // Never mix old quiet samples with a new capture or motor-noise window.
    if (!eligible) { count_ = 0; return; }
    levels_[count_++] = uint16_t(rms < 0 ? 0 : rms > 32767 ? 32767 : rms);
    if (count_ < WINDOW) return;
    // Small fixed window; insertion sort avoids dynamic allocation.
    for (unsigned i = 1; i < WINDOW; ++i) {
      const uint16_t sample = levels_[i];
      unsigned j = i;
      while (j && levels_[j - 1] > sample) { levels_[j] = levels_[j - 1]; --j; }
      levels_[j] = sample;
    }
    const float quiet = bounded(levels_[WINDOW / 5]);
    // Recover promptly after silence. Raise sensitivity threshold only slowly.
    floor_ = quiet < floor_ ? quiet : bounded(floor_ * 0.95f + quiet * 0.05f);
    count_ = 0;
  }
};
