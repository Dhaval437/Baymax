#include <Arduino.h>
#include <ESP32Servo.h>

// Isolated test: no Wi-Fi, microphone, audio or application controller.
// No pulses on boot. One command runs one bounded test, never a repeat loop.
Servo motors[3];
constexpr int PINS[] = {16, 17, 18};
const char *NAMES[] = {"Head", "Left arm", "Right arm"};
int selected = -1;
uint32_t startedAt = 0;

void stopMotor() {
  for (auto &motor : motors) if (motor.attached()) motor.detach();
  for (int pin : PINS) { pinMode(pin, OUTPUT); digitalWrite(pin, LOW); }
  selected = -1;
}

void setup() {
  Serial.begin(115200);
  stopMotor();
  for (auto &motor : motors) motor.setPeriodHertz(50);
  delay(800);
  Serial.println("DIAGNOSTIC READY: ESP32Servo 3.2.1; 50 Hz; no automatic motion.");
  Serial.println("H=head16 L=left17 R=right18; A=all60seconds; X=stop; ?=status.");
}

void loop() {
  if (Serial.available()) {
    char command = Serial.read();
    if (command >= 'a' && command <= 'z') command -= 'a' - 'A';
    if (command == 'X') { stopMotor(); Serial.println("STOPPED: outputs LOW."); }
    else if (command == '?') {
      int attached = 0;
      for (auto &motor : motors) if (motor.attached()) ++attached;
      Serial.printf("DIAGNOSTIC status: selected=%d attached=%d. Readback is software state, not a waveform measurement.\n", selected, attached);
    } else {
      int index = command == 'H' ? 0 : command == 'L' ? 1 : command == 'R' ? 2 : command == 'A' ? 3 : -1;
      if (index >= 0) {
        if (selected >= 0) Serial.println("BUSY: X stops current test.");
        else {
          bool attachedOK = true;
          for (int i = 0; i < 3; ++i) {
            if (index != 3 && index != i) continue;
            motors[i].attach(PINS[i], 1000, 2000);
            if (!motors[i].attached()) attachedOK = false;
            else motors[i].writeMicroseconds(1500);
          }
          if (!attachedOK) { stopMotor(); Serial.println("ERROR: servo attach failed."); }
          else {
            selected = index;
            startedAt = millis();
            if (index == 3) Serial.println("ALL THREE: simultaneous 60-second test started; four gentle cycles; automatic stop.");
            else Serial.printf("%s: bounded 1500 -> 1700 -> 1300 -> 1500 us, 15-second test with holds started.\n", NAMES[index]);
          }
        }
      }
    }
  }
  if (selected >= 0) {
    const uint32_t totalElapsed = millis() - startedAt;
    const uint32_t elapsed = totalElapsed % 15000;
    if (totalElapsed >= (selected == 3 ? 60000U : 15000U)) {
      stopMotor();
      Serial.println("DONE: pulses stopped. Physical shaft movement must be observed.");
    } else {
      int width = 1500;
      if (elapsed >= 1000 && elapsed < 3000) width = 1500 + int((elapsed - 1000) / 20) * 2;
      else if (elapsed >= 3000 && elapsed < 5000) width = 1700;
      else if (elapsed >= 5000 && elapsed < 9000) width = 1700 - int((elapsed - 5000) / 20) * 2;
      else if (elapsed >= 9000 && elapsed < 11000) width = 1300;
      else if (elapsed >= 11000 && elapsed < 13000) width = 1300 + int((elapsed - 11000) / 20) * 2;
      for (auto &motor : motors) if (motor.attached()) motor.writeMicroseconds(width);
    }
  }
  delay(1);
}
