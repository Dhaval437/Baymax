#pragma once
#include <stdint.h>

// Audio-time endpointing: longer speech and observed hesitation allow longer pauses.
// This detects silence, not semantic sentence completion.
class ListeningPolicy {
  uint32_t speechMs_ = 0, quietMs_ = 0, longestPauseMs_ = 0;
  bool conversation_ = false;
public:
  void begin(bool conversation) {
    speechMs_ = quietMs_ = longestPauseMs_ = 0; conversation_ = conversation;
  }
  void observe(bool speech, uint32_t ms) {
    if (speech) {
      if (quietMs_ > longestPauseMs_) longestPauseMs_ = quietMs_;
      quietMs_ = 0; speechMs_ += ms;
    } else quietMs_ += ms;
  }
  uint32_t pauseMs() const {
    // Allow thinking pauses inside a turn; wake-only calls still finish quickly.
    uint32_t pause = (conversation_ ? 1200 : 700) + speechMs_ / 12;
    if (pause < longestPauseMs_ + 600) pause = longestPauseMs_ + 600;
    return pause > 2600 ? 2600 : pause;
  }
  bool finished() const { return quietMs_ >= pauseMs(); }
};
