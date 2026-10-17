// One unloaded servo on D9. USB bench test only; no movement on boot.
// Send T for one bounded test. Pulses stop automatically after the sequence.
constexpr uint8_t SERVO_PIN = 9;

void pulse(int widthUs) {
  digitalWrite(SERVO_PIN, HIGH);
  delayMicroseconds(widthUs);
  digitalWrite(SERVO_PIN, LOW);
  // Split the remaining period to stay within AVR delayMicroseconds range.
  delayMicroseconds(10000);
  delayMicroseconds(10000 - widthUs);
}

void setup() {
  pinMode(SERVO_PIN, OUTPUT);
  digitalWrite(SERVO_PIN, LOW);
  Serial.begin(115200);
  Serial.println(F("UNO ready. Send T for one unloaded servo test."));
}

void loop() {
  if (!Serial.available()) return;
  const char command = Serial.read();
  if (command != 'T' && command != 't') return;
  Serial.println(F("Servo test starting."));
  for (int i = 0; i < 30; ++i) pulse(1500);
  for (int us = 1500; us <= 1600; us += 5) pulse(us);
  for (int us = 1600; us >= 1400; us -= 5) pulse(us);
  for (int us = 1400; us <= 1500; us += 5) pulse(us);
  for (int i = 0; i < 15; ++i) pulse(1500);
  digitalWrite(SERVO_PIN, LOW);
  Serial.println(F("Test ended; pulses off. Confirm shaft motion visually."));
}
