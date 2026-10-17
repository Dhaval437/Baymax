#include <Arduino.h>
#include <Wire.h>
#include <ESP_I2S.h>
#include <math.h>
#include "VoiceSample.h"

// Microphone only: VDD=3V3, GND and L/R=GND, SCK=4, WS=5, SD=6.
// T plays three quiet test notes on MAX98357A BCLK=4, LRC=5, DIN=7.
// No Wi-Fi, audio upload, automatic playback, or servo movement.
I2SClass microphone;
Stream* console = &Serial0;
bool motorsOff = false, micReady = false, testing = false;
bool speakerActive = false;
uint32_t started = 0, windowStart = 0;
uint32_t count = 0, zeroCount = 0, clips = 0, readErrors = 0;
double sum = 0, squares = 0;
int32_t minimum = 32767, maximum = -32768;

int readPca(uint8_t reg) {
  Wire.beginTransmission(0x40); Wire.write(reg);
  if (Wire.endTransmission(false) || Wire.requestFrom(uint8_t(0x40), uint8_t(1)) != 1) return -1;
  return Wire.read();
}
bool disableMotors() {
  bool ok = true;
  for (uint8_t channel = 0; channel < 16; ++channel) {
    uint8_t reg = 0x09 + 4 * channel;
    Wire.beginTransmission(0x40); Wire.write(reg); Wire.write(0x10);
    if (Wire.endTransmission() || readPca(reg) != 0x10) ok = false;
  }
  return ok;
}
void resetWindow() {
  count = zeroCount = clips = readErrors = 0;
  sum = squares = 0;
  minimum = 32767; maximum = -32768;
  windowStart = millis();
}
void reportWindow() {
  if (!count) {
    console->printf("MIC samples=0 read_errors=%lu\n", (unsigned long)readErrors);
    return;
  }
  double mean = sum / count;
  double variance = squares / count - mean * mean;
  console->printf("MIC t=%.1fs samples=%lu rms_ac=%.2f mean=%.2f min=%ld max=%ld zeros=%.1f%% clips=%lu read_errors=%lu\n",
    (millis() - started) / 1000.0, (unsigned long)count, sqrt(variance > 0 ? variance : 0), mean,
    (long)minimum, (long)maximum, 100.0 * zeroCount / count, (unsigned long)clips, (unsigned long)readErrors);
}
void stopTest() {
  if (micReady) microphone.end();
  micReady = testing = false;
  console->println("MIC STOPPED: acquisition off; no audio file recorded.");
}
void speakerTest() {
  stopTest();
  motorsOff = disableMotors();
  if (!motorsOff) { console->println("ERROR: PCA outputs not verified off; no sound started."); return; }
  microphone.setPins(4, 5, 7, -1);
  // 32-bit stereo preserves normal microphone clock timing; both slots carry
  // identical audio so the amplifier channel selector cannot mute the test.
  if (!microphone.begin(I2S_MODE_STD, 16000, I2S_DATA_BIT_WIDTH_32BIT, I2S_SLOT_MODE_STEREO)) {
    console->println("ERROR: speaker I2S initialization failed.");
    microphone.end(); pinMode(7, OUTPUT); digitalWrite(7, LOW); return;
  }
  speakerActive = true;
  console->println("SPEAKER START: three soft notes, 3 seconds maximum; X stops.");
  uint32_t wallStart = millis();
  bool ok = true, cancelled = false;
  // 0.4 s note + 0.4 s silence, repeated three times. Last 0.4 s drains DMA.
  for (uint32_t base = 0; base < 38400 && ok && !cancelled; base += 128) {
    if (millis() - wallStart > 3000) { ok = false; break; }
    for (Stream* input : {static_cast<Stream*>(&Serial), static_cast<Stream*>(&Serial0)}) {
      while (input->available()) if (toupper(input->read()) == 'X') cancelled = true;
    }
    if (cancelled) break;
    int32_t samples[256];
    for (uint32_t j = 0; j < 128; ++j) {
      uint32_t n = base + j, phase = n % 12800;
      double value = 0;
      if (phase < 6400) {
        // Raised-cosine 50 ms edges reduce switching clicks without a sharp
        // slope change. Back off gain when the user reports audible breakup.
        double edge = fmin(1.0, fmin(phase / 800.0, (6399 - phase) / 800.0));
        double fade = 0.5 - 0.5 * cos(PI * edge);
        double frequency = 440.0 + 110.0 * (n / 12800);
        value = 4000.0 * fade * sin(2.0 * PI * frequency * phase / 16000.0);
      }
      int32_t pcm = int32_t(value) * 65536;
      samples[2*j] = samples[2*j+1] = pcm;
    }
    size_t written = 0;
    esp_err_t err = i2s_channel_write(microphone.txChan(), samples, sizeof(samples), &written, 100);
    if (err != ESP_OK || written != sizeof(samples)) ok = false;
  }
  microphone.end();
  speakerActive = false;
  pinMode(7, OUTPUT); digitalWrite(7, LOW);
  console->println(cancelled ? "SPEAKER STOPPED: cancelled; output off." :
    ok ? "SPEAKER DONE: three notes transmitted; output off." : "ERROR: speaker transfer or timeout; output off.");
}
void voiceTest(bool maximumVolume = false) {
  stopTest();
  motorsOff = disableMotors();
  if (!motorsOff) { console->println("ERROR: PCA outputs not verified off; no voice started."); return; }
  microphone.setPins(4, 5, 7, -1);
  if (!microphone.begin(I2S_MODE_STD, VOICE_RATE, I2S_DATA_BIT_WIDTH_32BIT, I2S_SLOT_MODE_STEREO)) {
    console->println("ERROR: voice I2S initialization failed.");
    microphone.end(); pinMode(7, OUTPUT); digitalWrite(7, LOW); return;
  }
  speakerActive = true;
  console->printf("VOICE START: saved smooth v2 sample, about six seconds; peak=%d; X stops.\n", maximumVolume ? 30000 : 8000);
  uint32_t wallStart = millis();
  bool ok = true, cancelled = false;
  // A half-second of digital silence drains queued audio before stopping I2S.
  const uint32_t total = VOICE_LENGTH + VOICE_RATE / 2;
  for (uint32_t base = 0; base < total && ok && !cancelled; base += 128) {
    if (millis() - wallStart > 8000) { ok = false; break; }
    for (Stream* input : {static_cast<Stream*>(&Serial), static_cast<Stream*>(&Serial0)}) {
      while (input->available()) if (toupper(input->read()) == 'X') cancelled = true;
    }
    if (cancelled) break;
    int32_t samples[256];
    for (uint32_t j = 0; j < 128; ++j) {
      uint32_t n = base + j;
      // V preserves the previously tested level. U requests near-full-scale
      // audio with a 30000 ceiling; analogue amplifier clipping is separate.
      int32_t value = n < VOICE_LENGTH ? int32_t(VOICE_PCM[n]) : 0;
      value = maximumVolume ? (value * 15) / 2 : value * 2;
      value = constrain(value, -30000, 30000);
      // Bring the louder sample up over its first 0.3 seconds.
      if (maximumVolume && n < VOICE_RATE * 3 / 10)
        value = int32_t(int64_t(value) * n / (VOICE_RATE * 3 / 10));
      int32_t pcm = value * 65536;
      samples[2*j] = samples[2*j+1] = pcm;
    }
    size_t written = 0;
    esp_err_t err = i2s_channel_write(microphone.txChan(), samples, sizeof(samples), &written, 100);
    if (err != ESP_OK || written != sizeof(samples)) ok = false;
  }
  microphone.end(); speakerActive = false;
  pinMode(7, OUTPUT); digitalWrite(7, LOW);
  console->println(cancelled ? "VOICE STOPPED: cancelled; output off." :
    ok ? "VOICE DONE: saved sample transmitted; output off." : "ERROR: voice transfer or timeout; output off.");
}
void setup() {
  Serial.begin(115200); Serial0.begin(115200);
  for (int pin : {16, 17, 18, 7}) { pinMode(pin, OUTPUT); digitalWrite(pin, LOW); }
  Wire.begin(8, 9); Wire.setClock(100000); Wire.setTimeOut(50);
  motorsOff = disableMotors();
  delay(800);
  console->println("AUDIO DIAGNOSTIC: M=mic levels, T=three quiet notes, V=saved voice, U=maximum voice, X=stop, ?=status; both USB sockets supported.");
}
void loop() {
  if (Serial.available()) console = &Serial;
  else if (Serial0.available()) console = &Serial0;
  if (console->available()) {
    char command = toupper(console->read());
    if (command == 'X') stopTest();
    else if (command == '?') {
      console->printf("MIC STATUS motors_off=%d testing=%d SCK=4 WS=5 SD=6 rate=16000 slot=LEFT speaker_active=%d speaker_test=T voice_test=V loud_voice_test=U\n", motorsOff, testing, speakerActive);
    } else if (command == 'V') {
      voiceTest();
    } else if (command == 'U') {
      voiceTest(true);
    } else if (command == 'T') {
      speakerTest();
    } else if (command == 'M' && !testing) {
      motorsOff = disableMotors();
      if (!motorsOff) { console->println("ERROR: PCA output disable not verified; microphone test not started."); return; }
      pinMode(6, INPUT_PULLDOWN);
      microphone.setPins(4, 5, -1, 6);
      micReady = microphone.begin(I2S_MODE_STD, 16000, I2S_DATA_BIT_WIDTH_32BIT, I2S_SLOT_MODE_MONO, I2S_STD_SLOT_LEFT);
      if (!micReady) { console->printf("ERROR: I2S initialization failed: %d\n", microphone.lastError()); return; }
      testing = true; started = millis(); resetWindow();
      console->println("MIC START: 20 seconds. Quiet first 5 seconds; speak for next 10; quiet final 5. Levels only, not speech recognition.");
    }
  }
  if (testing) {
    uint32_t elapsed = millis() - started;
    if (elapsed >= 20000) {
      if (count) reportWindow();
      stopTest();
      console->println("MIC DONE: 20-second level test complete.");
      return;
    }
    int32_t raw[256];
    size_t bytes = 0;
    esp_err_t err = i2s_channel_read(microphone.rxChan(), raw, sizeof(raw), &bytes, 50);
    if (err != ESP_OK) ++readErrors;
    for (size_t i = 0; i < bytes / sizeof(raw[0]); ++i) {
      int32_t sample = raw[i] >> 16;
      ++count;
      if (!sample) ++zeroCount;
      if (sample <= -32760 || sample >= 32760) ++clips;
      if (sample < minimum) minimum = sample;
      if (sample > maximum) maximum = sample;
      sum += sample; squares += double(sample) * sample;
    }
    if (millis() - windowStart >= 1000) { reportWindow(); resetWindow(); }
  } else delay(1);
}
