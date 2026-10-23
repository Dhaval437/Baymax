#pragma once
// Credentials stay in config.h. These defaults supersede the old ENABLE_SERVO /
// ENABLE_HURT_WAKE bench flags. No physical talk button is used.
#ifndef BAYMAX_AUTO_LISTEN
#define BAYMAX_AUTO_LISTEN 1
#endif
#ifndef BAYMAX_MOTION_ENABLED
#define BAYMAX_MOTION_ENABLED 0
#endif
#ifndef BAYMAX_MIC_THRESHOLD
#define BAYMAX_MIC_THRESHOLD 450
#endif
#ifndef BAYMAX_VOICE_PEAK
#define BAYMAX_VOICE_PEAK 20000
#endif
// Set only after centering the bare servos and checking the assembled joints.
// Each row is {centre us, minimum us, maximum us, direction}.
// Wider commissioning range; not a claim of measured assembled 0–180 travel.
struct JointLimit { int centre, minimum, maximum, direction; };
constexpr JointLimit JOINTS[3] = {
  {1500, 1000, 2000, 1}, // head, PCA channel 0
  {1500, 1000, 2000, 1}, // robot's left arm, PCA channel 1
  {1500, 1000, 2000, -1} // robot's right arm, PCA channel 2
};
constexpr uint32_t GESTURE_DURATION_MS = 6000;
constexpr uint32_t PCA_OSCILLATOR_HZ = 26920000;
constexpr uint8_t PCA_PRESCALE = 130; // measured approximately 50.07 Hz
constexpr uint32_t CONVERSATION_WINDOW_MS = 30000;
static_assert(BAYMAX_VOICE_PEAK > 0 && BAYMAX_VOICE_PEAK <= 24000, "Voice peak must leave digital headroom");
static_assert(BAYMAX_MIC_THRESHOLD > 0, "Microphone threshold must be positive");
