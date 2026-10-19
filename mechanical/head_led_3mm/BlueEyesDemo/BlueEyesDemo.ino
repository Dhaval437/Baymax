// Standalone LED test only. Uploading replaces Baymax conversation firmware.
// GPIO10 -> 220 ohms -> left LED anode; GPIO11 -> 220 ohms -> right anode.
// Both cathodes -> GND. Ordinary two-lead 3mm blue LEDs, NOT addressable LEDs.
#include <Arduino.h>
constexpr uint8_t LEFT_EYE = 10, RIGHT_EYE = 11;
uint32_t cycleStarted;
void setup() {
  digitalWrite(LEFT_EYE, LOW); digitalWrite(RIGHT_EYE, LOW);
  pinMode(LEFT_EYE, OUTPUT); pinMode(RIGHT_EYE, OUTPUT);
  cycleStarted = millis();
}
void loop() {
  uint32_t elapsed = millis() - cycleStarted;
  if (elapsed >= 8000) { cycleStarted += (elapsed / 8000) * 8000; elapsed %= 8000; }
  const bool blink = elapsed >= 4000 && elapsed < 4150;
  const bool leftWink = elapsed >= 5500 && elapsed < 5750;
  const bool rightWink = elapsed >= 6500 && elapsed < 6750;
  digitalWrite(LEFT_EYE, !(blink || leftWink));
  digitalWrite(RIGHT_EYE, !(blink || rightWink));
  delay(5);
}
