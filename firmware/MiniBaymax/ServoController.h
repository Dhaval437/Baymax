#pragma once
#include <Arduino.h>
#include <Wire.h>
#include "RobotSettings.h"

// PCA9685 only. The microphone/speaker use GPIO4–7; I2C uses GPIO8/9.
class ServoController {
  bool healthy = false, enabled = false;
  int axis = -1, current = 1500;
  bool accompanyHead = false;
  bool expressive = false;
  int scale = 100;
  uint32_t started = 0, lastStep = 0, progress = 0;
  static int eased(int from, int to, uint32_t at, uint32_t duration) {
    float t = float(at) / duration;
    // Quintic easing: zero velocity and acceleration at each endpoint.
    float s = t * t * t * (10.0f + t * (-15.0f + 6.0f * t));
    return int(from + (to - from) * s + 0.5f);
  }
  bool writeReg(uint8_t reg, uint8_t value) {
    Wire.beginTransmission(0x40); Wire.write(reg); Wire.write(value);
    return Wire.endTransmission() == 0;
  }
  int readReg(uint8_t reg) {
    Wire.beginTransmission(0x40); Wire.write(reg);
    if (Wire.endTransmission(false) || Wire.requestFrom(uint8_t(0x40), uint8_t(1)) != 1) return -1;
    return Wire.read();
  }
  bool pulse(uint8_t channel, int us) {
    us = constrain(us, JOINTS[channel].minimum, JOINTS[channel].maximum);
    constexpr uint64_t divisor = uint64_t(PCA_PRESCALE + 1) * 1000000ULL;
    uint16_t ticks = uint16_t((uint64_t(us) * PCA_OSCILLATOR_HZ + divisor / 2) / divisor);
    Wire.beginTransmission(0x40); Wire.write(0x06 + 4 * channel);
    Wire.write(0); Wire.write(0); Wire.write(ticks & 255); Wire.write(ticks >> 8);
    return Wire.endTransmission() == 0;
  }
 public:
  bool begin(bool allowMotion) {
    Wire.begin(8, 9); Wire.setClock(100000); Wire.setTimeOut(50);
    healthy = true; stop();
    if (!healthy) return false;
    healthy = writeReg(0x00, 0x30) && writeReg(0xFE, PCA_PRESCALE) && writeReg(0x01, 0x04) && writeReg(0x00, 0x20);
    delay(1);
    healthy = healthy && writeReg(0x00, 0xA0) && readReg(0xFE) == PCA_PRESCALE &&
      (readReg(0x00) & 0x70) == 0x20 && readReg(0x01) == 0x04;
    enabled = healthy && allowMotion;
    for (const auto &j : JOINTS) {
      if (j.minimum < 1000 || j.maximum > 2000 || j.minimum > j.centre || j.maximum < j.centre || abs(j.direction) != 1)
        enabled = false;
    }
    return healthy;
  }
  void stop() {
    axis = -1;
    bool ok = true;
    for (int channel = 0; channel < 16; ++channel) {
      uint8_t reg = 0x09 + 4 * channel;
      if (!writeReg(reg, 0x10) || readReg(reg) != 0x10) ok = false;
    }
    healthy = ok;
    if (!ok) enabled = false;
  }
  bool available() const { return healthy; }
  bool permitted() const { return healthy && enabled; }
  bool moving() const { return axis >= 0; }
  bool gesture(uint8_t channel = 0, bool withHead = false, int strength = 100, bool lively = false) {
    if (!permitted() || channel > 2 || moving()) return false;
    accompanyHead = withHead && channel != 0; scale = constrain(strength, 25, 100);
    expressive = lively;
    axis = channel; current = JOINTS[axis].centre; started = lastStep = millis(); progress = 0;
    if (!pulse(axis, current)) { stop(); enabled = false; return false; }
    return true;
  }
  void tick() {
    if (axis < 0) return;
    uint32_t elapsed = millis() - started;
    if (elapsed >= 12000) { stop(); return; } // bounded output even if foreground stalls
    if (millis() - lastStep < 20) return;
    lastStep = millis();
    // Advance only one frame after a slow network/phone request; never jump
    // ahead to a distant target to catch up with wall-clock time.
    progress += 20;
    const auto &j = JOINTS[axis];
    int first = j.direction > 0 ? j.maximum : j.minimum;
    int second = j.direction > 0 ? j.minimum : j.maximum;
    first = j.centre + (first - j.centre) * scale / 100;
    second = j.centre + (second - j.centre) * scale / 100;
    int target = j.centre;
    uint32_t frame = expressive ? (progress * 2) % GESTURE_DURATION_MS : progress;
    if (frame >= 200 && frame < 1600) target = eased(j.centre, first, frame - 200, 1400);
    else if (frame >= 1600 && frame < 4400) target = eased(first, second, frame - 1600, 2800);
    else if (frame >= 4400 && frame < 5800) target = eased(second, j.centre, frame - 4400, 1400);
    target = constrain(target, j.minimum, j.maximum);
    const int step = expressive ? 28 : 14;
    current += constrain(target - current, -step, step);
    bool ok = pulse(axis, current);
    if (accompanyHead) ok = pulse(0, JOINTS[0].centre + (current - j.centre) * j.direction * JOINTS[0].direction) && ok;
    if (!ok) { stop(); enabled = false; }
    else if (progress >= GESTURE_DURATION_MS) stop();
  }
};
