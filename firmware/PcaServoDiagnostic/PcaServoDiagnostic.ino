#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
#include <ESP32Servo.h>

// PCA9685: SDA=8, SCL=9, logic VCC=3V3; motor V+ is external 5V.
// Oscillator estimated from channel3 feedback on 15 October 2026.
constexpr uint32_t OSCILLATOR_HZ = 26920000;
constexpr uint8_t SERVO_PRESCALE = 130; // Rounded divider for 50 Hz.
constexpr uint8_t ADDRESS = 0x40;
// Normal wiring: head=0, left arm=1, right arm=2.
constexpr uint8_t HEAD_CHANNEL = 0;
constexpr uint8_t FEEDBACK_PIN = 10;
constexpr uint8_t DIRECT_PIN = 16;
Servo directServo;
bool directActive = false;
bool centreHold = false;
Adafruit_PWMServoDriver driver(ADDRESS, Wire);
Stream* console = &Serial0; // Reply through whichever USB interface receives commands.
bool ready = false;
int active = -1;
uint32_t started = 0, lastWrite = 0;
uint32_t lastReport = 0;

uint16_t pulseTicks(uint16_t us) {
  const uint64_t divisor = uint64_t(SERVO_PRESCALE + 1) * 1000000ULL;
  return (uint64_t(us) * OSCILLATOR_HZ + divisor / 2) / divisor;
}
bool writeReg(uint8_t reg, uint8_t value) {
  Wire.beginTransmission(ADDRESS); Wire.write(reg); Wire.write(value);
  return Wire.endTransmission() == 0;
}
int readReg(uint8_t reg) {
  Wire.beginTransmission(ADDRESS); Wire.write(reg);
  if (Wire.endTransmission(false) != 0) return -1;
  if (Wire.requestFrom(ADDRESS, uint8_t(1)) != 1) return -1;
  return Wire.read();
}
bool setChannel(uint8_t channel, uint16_t off) {
  if (driver.setPWM(channel, 0, off) != 0) return false;
  const uint8_t base = 0x06 + channel * 4;
  return readReg(base) == 0 && readReg(base + 1) == 0 &&
         readReg(base + 2) == (off & 255) && readReg(base + 3) == (off >> 8);
}
bool stopAll() {
  if (directServo.attached()) directServo.detach();
  pinMode(DIRECT_PIN, OUTPUT); digitalWrite(DIRECT_PIN, LOW);
  directActive = false;
  centreHold = false;
  active = -1;
  bool ok = true;
  for (int i = 0; i < 16; ++i) if (!setChannel(i, 4096)) ok = false;
  for (int i = 0; i < 16; ++i) {
    int value = readReg(0x09 + i * 4);
    if (value < 0 || !(value & 0x10)) ok = false;
  }
  return ok;
}
// Run only after connecting the HEAD_CHANNEL PWM to GPIO10, with the servo
// unplugged and external motor power off. PCA logic remains at 3.3V.
// This measures the physical output, not merely its configuration registers.
void measureOutput() {
  if (!stopAll()) {
    ready = false;
    console->println("ERROR: cannot verify idle; no measurement started.");
    return;
  }
  pinMode(FEEDBACK_PIN, INPUT_PULLDOWN);
  bool outputOk = setChannel(HEAD_CHANNEL, pulseTicks(1500));
  uint32_t samples = 0, missing = 0;
  uint64_t highTotal = 0, lowTotal = 0;
  uint32_t highMin = UINT32_MAX, highMax = 0;
  uint32_t began = millis();
  console->printf("MEASURE: channel%d -> GPIO10, nominal 1500us/50Hz, maximum 5 seconds; X cancels.\n", HEAD_CHANNEL);
  while (outputOk && millis() - began < 5000) {
    if (console->available() && toupper(console->read()) == 'X') break;
    // Separate high/low measurements estimate the period of this fixed waveform.
    uint32_t hi = pulseIn(FEEDBACK_PIN, HIGH, 60000);
    uint32_t lo = pulseIn(FEEDBACK_PIN, LOW, 60000);
    if (hi && lo) {
      ++samples; highTotal += hi; lowTotal += lo;
      if (hi < highMin) highMin = hi;
      if (hi > highMax) highMax = hi;
    } else ++missing;
    delay(1);
  }
  bool stopped = stopAll();
  if (!outputOk || !stopped) ready = false;
  if (!outputOk) console->println("ERROR: output register write/readback failed.");
  if (samples) {
    double hi = double(highTotal) / samples;
    double lo = double(lowTotal) / samples;
    console->printf("PHYSICAL INPUT: samples=%lu missing=%lu high_us=%.1f low_us=%.1f estimated_Hz=%.2f high_min=%lu high_max=%lu\n",
                  (unsigned long)samples, (unsigned long)missing, hi, lo,
                  1000000.0 / (hi + lo), (unsigned long)highMin, (unsigned long)highMax);
  } else console->println("PHYSICAL INPUT: no complete pulses detected at GPIO10. Check feedback path before attributing this to the driver.");
  console->println(stopped ? "DONE: all outputs full-off verified." : "ERROR: stop not verified; disconnect power.");
}
void setup() {
  Serial.begin(115200);
  Serial0.begin(115200);
  for (int pin : {16, 17, 18}) { pinMode(pin, OUTPUT); digitalWrite(pin, LOW); }
  Wire.begin(8, 9); Wire.setClock(100000); Wire.setTimeOut(50);
  // Standard library reset, oscillator wake, and restart sequence.
  bool ok = driver.begin();
  if (ok) {
    driver.setOscillatorFrequency(OSCILLATOR_HZ);
    driver.setPWMFreq(50);
    driver.setOutputMode(true);
    ok = stopAll();
  }
  if (ok) ok = readReg(0xFE) == SERVO_PRESCALE && (readReg(0x00) & 0x70) == 0x20 && readReg(0x01) == 4;
  ready = ok;
  delay(800);
  console->println(ready ? "PCA READY: address 0x40, SDA8 SCL9, all outputs off." : "PCA ERROR: controller not verified. No motion enabled.");
  console->println("H=head0 L=left1 R=right2; each 15 seconds. X=stop ?=status.");
  console->println("M=physical pulse measurement on GPIO10; requires feedback jumper, servo unplugged, motor power off.");
  console->println("D=direct head signal on GPIO16, 15 seconds; servo signal must be disconnected from PCA PWM.");
  console->println("C=direct GPIO16 centre hold: constant 1500us for 8 seconds, then detach.");
}
void loop() {
  if (Serial.available()) console = &Serial;
  else if (Serial0.available()) console = &Serial0;
  if (console->available()) {
    char cmd = toupper(console->read());
    if (cmd == 'X') {
      bool ok = stopAll();
      if (!ok) ready = false;
      console->println(ok ? "STOPPED: all 16 full-off registers verified." : "ERROR: stop not verified; disconnect servo power.");
    } else if (cmd == '?') {
      console->printf("PCA STATUS ready=%d active=%d prescale=%d\n", ready, active, readReg(0xFE));
      console->printf("DIRECT_STATUS pin=%d active=%d attached=%d\n", DIRECT_PIN, directActive, directServo.attached());
      const uint8_t base = 0x06 + HEAD_CHANNEL * 4;
      console->printf("REGISTERS MODE1=%02X MODE2=%02X HEAD_CHANNEL=%d ON=%02X:%02X OFF=%02X:%02X\n", readReg(0), readReg(1), HEAD_CHANNEL, readReg(base+1), readReg(base), readReg(base+3), readReg(base+2));
    } else if (ready && active == -1) {
      if (cmd == 'M') { measureOutput(); return; }
      if (cmd == 'D' || cmd == 'C') {
        if (!stopAll()) { ready = false; console->println("ERROR: cannot verify idle; no direct start."); return; }
        directServo.setPeriodHertz(50);
        directServo.attach(DIRECT_PIN, 1000, 2000);
        if (!directServo.attached()) { stopAll(); console->println("ERROR: direct servo attach failed."); return; }
        directServo.writeMicroseconds(1500);
        directActive = true;
        centreHold = cmd == 'C';
        active = DIRECT_PIN; // Sentinel outside the PCA's 0..15 channel range.
        started = millis(); lastWrite = started - 20; lastReport = started - 5000;
        console->println(centreHold ? "START: CENTRE GPIO16, 8 seconds, constant 1500us, 50Hz; PCA outputs remain off." : "START: DIRECT GPIO16, 15 seconds, 1300-1700us, 50Hz; PCA outputs remain off.");
        return;
      }
      int channel = cmd == 'H' ? HEAD_CHANNEL : cmd == 'L' ? 1 : cmd == 'R' ? 2 : -1;
      if (channel >= 0) {
        if (!stopAll()) { ready = false; console->println("ERROR: cannot verify idle; no start."); }
        else {
          active = channel; started = millis(); lastWrite = started - 20; lastReport = started - 5000;
          console->printf("START: PCA channel %d, 15 seconds, 1300-1700 us.\n", active);
        }
      }
    }
  }
  if (active >= 0) {
    uint32_t elapsed = millis() - started;
    if (elapsed >= (centreHold ? 8000U : 15000U)) {
      bool ok = stopAll();
      if (!ok) ready = false;
      console->println(ok ? "DONE: all outputs full-off verified." : "ERROR: stop not verified; disconnect servo power.");
    } else if (millis() - lastWrite >= 20) {
      lastWrite = millis();
      uint32_t t = elapsed % 15000;
      int us = 1500;
      if (t >= 1000 && t < 3000) us = 1500 + (t - 1000) / 10;
      else if (t >= 3000 && t < 5000) us = 1700;
      else if (t >= 5000 && t < 9000) us = 1700 - (t - 5000) / 10;
      else if (t >= 9000 && t < 11000) us = 1300;
      else if (t >= 11000 && t < 13000) us = 1300 + (t - 11000) / 10;
      uint16_t ticks = pulseTicks(us);
      if (directActive) {
        if (centreHold) us = 1500;
        // Centre command was written once at start; leave the hardware PWM steady.
        else directServo.writeMicroseconds(us);
        if (millis() - lastReport >= 5000) {
          lastReport = millis();
          console->printf("DIRECT COMMAND: GPIO16 pulse_us=%d attached=%d. Physical motion must be observed.\n", us, directServo.attached());
        }
        return;
      }
      if (!setChannel(active, ticks)) {
        ready = false; stopAll();
        console->println("ERROR: I2C write failed; disconnect servo power if moving.");
      } else if (millis() - lastReport >= 5000) {
        lastReport = millis();
        console->printf("VERIFIED: channel=%d pulse_us=%d ticks=%u full_off=0; MODE1=%02X MODE2=%02X. Register readback only.\n", active, us, ticks, readReg(0), readReg(1));
      }
    }
  }
  delay(1);
}


