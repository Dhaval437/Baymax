#pragma once
#include <stdint.h>

// A single loud frame is often a switch/servo click, not an utterance.
// The existing preroll retains the opening audio while this gate confirms it.
class SpeechOnset {
  uint32_t loudMs_ = 0;
public:
  void reset() { loudMs_ = 0; }
  uint32_t durationMs() const { return loudMs_; }
  bool observe(bool loud, uint32_t ms) {
    loudMs_ = loud ? loudMs_ + ms : 0;
    return loudMs_ >= 48;
  }
};
