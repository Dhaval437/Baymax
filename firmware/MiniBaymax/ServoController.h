#pragma once
#include <Arduino.h>
#include <Wire.h>
#include "RobotSettings.h"

// PCA9685 only. The microphone/speaker use GPIO4–7; I2C uses GPIO8/9.
class ServoController {
  bool healthy = false, enabled = false;
  int axis = -1, current = 1500;
  uint32_t started = 0, lastStep = 0;
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
  bool gesture(uint8_t channel = 0) {
    if (!permitted() || channel > 2 || moving()) return false;
    axis = channel; current = JOINTS[axis].centre; started = lastStep = millis();
    if (!pulse(axis, current)) { stop(); enabled = false; return false; }
    return true;
  }
  void tick() {
    if (axis < 0) return;
    uint32_t elapsed = millis() - started;
    if (elapsed >= 3500) { stop(); return; }
    if (millis() - lastStep < 20) return;
    lastStep = millis();
    const auto &j = JOINTS[axis];
    int target = j.centre;
    if (elapsed >= 300 && elapsed < 1200) target += 80 * j.direction;
    else if (elapsed >= 1200 && elapsed < 2100) target -= 80 * j.direction;
    target = constrain(target, j.minimum, j.maximum);
    current += constrain(target - current, -3, 3);
    if (!pulse(axis, current)) { stop(); enabled = false; }
  }
};
