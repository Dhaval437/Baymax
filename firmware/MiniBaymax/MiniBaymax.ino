#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <ESP_I2S.h>
#include <math.h>
#include <miniz.h>
#include "config.h"
#include "RobotSettings.h"
#include "ServoController.h"
#include "PhoneSetup.h"
#include "ListeningPolicy.h"

class PromptClient : public WiFiClient {
 public:
  using WiFiClient::connect;
  int connect(const char *host, uint16_t port, int32_t timeout) override {
    int ok = WiFiClient::connect(host, port, timeout);
    if (ok) setNoDelay(true);
    return ok;
  }
  int connect(IPAddress ip, uint16_t port, int32_t timeout) override {
    int ok = WiFiClient::connect(ip, port, timeout);
    if (ok) setNoDelay(true);
    return ok;
  }
};
// Baymax integrated firmware v2. No button required. Laptop runs Start-Baymax.cmd.
constexpr uint32_t MIC_RATE = 16000, SPEAKER_RATE = 24000;
constexpr size_t MAX_SAMPLES = MIC_RATE * 60, PRE_SAMPLES = MIC_RATE * 3 / 4;
constexpr size_t MAX_REPLY_BYTES = SPEAKER_RATE * 2 * 60;
ListeningPolicy endpoint;
I2SClass audio;
ServoController servos;
PhoneSetup phone;
Stream *console = &Serial0;
uint8_t *recording = nullptr, *replyAudio = nullptr;
int16_t preAudio[PRE_SAMPLES];
size_t preIndex = 0, preCount = 0, captured = 0, quiet = 0, voiced = 0;
bool listening = BAYMAX_AUTO_LISTEN, rx = false, capturing = false, inConversation = false;
bool busyIO = false, wasWake = false;
uint32_t resumeAt = 0, conversationUntil = 0, rxStarted = 0, lastLevel = 0;
uint32_t jobStarted = 0, pollAt = 0, wifiAttempt = 0;
uint16_t replyPart = 0;
float noiseFloor = 80;
size_t noiseCalibrationSamples = 0;
float calibrationMinimum = 32768;
String jobId, baseUrl;
const char *phase = "boot";

void put16(uint8_t *p, uint16_t n) { p[0] = n; p[1] = n >> 8; }
void put32(uint8_t *p, uint32_t n) { p[0] = n; p[1] = n >> 8; p[2] = n >> 16; p[3] = n >> 24; }
void header(size_t samples) {
  memcpy(recording, "RIFF", 4); put32(recording + 4, 36 + samples * 2);
  memcpy(recording + 8, "WAVEfmt ", 8); put32(recording + 16, 16);
  put16(recording + 20, 1); put16(recording + 22, 1);
  put32(recording + 24, MIC_RATE); put32(recording + 28, MIC_RATE * 2);
  put16(recording + 32, 2); put16(recording + 34, 16);
  memcpy(recording + 36, "data", 4); put32(recording + 40, samples * 2);
}
void stopMic() {
  if (rx) audio.end();
  rx = capturing = false;
  preIndex = preCount = captured = quiet = voiced = 0;
}
void status() {
  console->printf("BAYMAX v2 state=%s listening=%d conversation=%d wifi=%d pca=%d motion_enabled=%d moving=%d\n",
    phase, listening, inConversation, WiFi.status() == WL_CONNECTED, servos.available(), servos.permitted(), servos.moving());
}
void controls() {
  // Keep phone pause/status responsive during buffered audio playback/downloads.
  // Network changes and OTA are rejected while a transfer is active.
  if (busyIO) phone.tick();
  for (Stream *input : {static_cast<Stream*>(&Serial), static_cast<Stream*>(&Serial0)}) {
    while (input->available()) {
      console = input;
      char c = toupper(input->read());
      if (c == '?') status();
      else if (c == 'X' || c == 'W') {
        // X always stops. W can resume only after an active transfer has returned.
        bool enable = c == 'W' && !listening && !busyIO;
        listening = enable; inConversation = false; jobId = "";
        if (!busyIO) stopMic();
        servos.stop(); phase = enable ? "waiting" : "stopped";
        resumeAt = millis() + 1000;
        console->println(enable ? "Automatic listening ON." : "Stopped: listening and motor output OFF. W resumes.");
      } else if ((c == 'H' || c == 'L' || c == 'R') && !busyIO && !jobId.length()) {
        stopMic(); resumeAt = millis() + 4000;
        bool ok = servos.gesture(c == 'H' ? 0 : c == 'L' ? 1 : 2);
        console->println(ok ? "Smooth six-second gesture started." : "Motion disabled or controller unavailable.");
      }
    }
  }
}
bool openHttp(HTTPClient &http, WiFiClient &client, const String &path) {
  if (WiFi.status() != WL_CONNECTED) return false;
  http.setConnectTimeout(5000); http.setTimeout(5000);
  if (!http.begin(client, baseUrl + path)) return false;
  http.addHeader("Authorization", String("Bearer ") + DEVICE_TOKEN);
  http.addHeader("X-Baymax-Motion", servos.permitted() ? "1" : "0");
  http.addHeader("X-Baymax-Pca", servos.available() ? "1" : "0");
  http.addHeader("X-Baymax-Conversation", inConversation ? "1" : "0");
  const char *keys[] = {"X-Audio-Format", "X-Conversation", "X-Conversation-Window-Ms", "X-Gesture", "X-Reply-More"};
  http.collectHeaders(keys, 5);
  return true;
}
void retryLater(const char *message, uint32_t pause = 5000) {
  console->println(message); jobId = ""; phase = "waiting";
  resumeAt = millis() + pause; servos.stop();
}
void submit(size_t samples, bool wake) {
  header(samples); servos.stop();
  const size_t originalBytes = 44 + samples * 2;
  // Reuse the idle playback buffer; compression preserves every microphone sample.
  const size_t packedBytes = tdefl_compress_mem_to_mem(replyAudio, MAX_REPLY_BYTES,
    recording, originalBytes, TDEFL_WRITE_ZLIB_HEADER | 16);
  const bool compressed = packedBytes > 0 && packedBytes < originalBytes;
  uint8_t *body = compressed ? replyAudio : recording;
  const size_t bodyBytes = compressed ? packedBytes : originalBytes;
  PromptClient client; HTTPClient http;
  if (!openHttp(http, client, wake ? "/wake?async=1" : "/turn?async=1")) {
    retryLater("Wi-Fi unavailable; reconnecting."); return;
  }
  phase = "sending"; busyIO = true;
  http.addHeader("Content-Type", "audio/wav");
  if (compressed) http.addHeader("Content-Encoding", "deflate");
  uint32_t sentAt = millis();
  int code = http.POST(body, bodyBytes);
  console->printf("Upload bytes=%u elapsed_ms=%u RSSI=%d HTTP=%d\n",
    unsigned(bodyBytes), unsigned(millis() - sentAt), WiFi.RSSI(), code);
  // Retry only failed TCP connections: no request reached the server, so this
  // cannot create duplicate speech jobs. Keep the captured utterance intact.
  constexpr uint8_t MAX_CONNECT_ATTEMPTS = 6;
  for (uint8_t attempt = 1; code == HTTPC_ERROR_CONNECTION_REFUSED && attempt < MAX_CONNECT_ATTEMPTS; ++attempt) {
    http.end();
    console->printf("Laptop connection retry %u/%u (Wi-Fi RSSI %d dBm).\n", attempt, MAX_CONNECT_ATTEMPTS - 1, WiFi.RSSI());
    uint32_t retryAt = millis() + 400 * attempt;
    while (int32_t(millis() - retryAt) < 0 && listening) { controls(); delay(10); }
    if (!listening) { busyIO = false; return; }
    if (!openHttp(http, client, wake ? "/wake?async=1" : "/turn?async=1")) break;
    http.addHeader("Content-Type", "audio/wav");
    if (compressed) http.addHeader("Content-Encoding", "deflate");
    code = http.POST(body, bodyBytes);
  }
  String id = code == 202 && http.getSize() == 24 ? http.getString() : "";
  http.end(); controls(); busyIO = false;
  if (!listening) return;
  bool valid = id.length() == 24;
  for (size_t i = 0; i < id.length(); ++i) if (!isxdigit(id[i])) valid = false;
  if (code == 202 && valid) {
    jobId = id; replyPart = 0; jobStarted = millis(); pollAt = millis() + 100; wasWake = wake;
    phase = "thinking"; console->println("Processing speech on laptop...");
  } else if (code == 204) retryLater("No wake phrase, silence, or cooldown.", 1000);
  else {
    console->printf("Laptop request unavailable after automatic retries (HTTP %d).\n", code);
    retryLater("Laptop temporarily unreachable. Listening continues automatically.");
  }
}
bool downloadReply(HTTPClient &http, size_t &size) {
  int total = http.getSize();
  if (http.header("X-Audio-Format") != "s16le; rate=24000; channels=1" || total <= 0 ||
      size_t(total) > MAX_REPLY_BYTES || total % 2) return false;
  NetworkClient *stream = http.getStreamPtr();
  if (!stream) return false;
  size = 0; uint32_t started = millis(), progress = started;
  // Fully buffer PCM in PSRAM before enabling I2S: Wi-Fi stalls cannot make audio gaps.
  while (size < size_t(total) && listening) {
    controls();
    int available = stream->available();
    if (available > 0) {
      int count = stream->read(replyAudio + size, min(size_t(available), size_t(total) - size));
      if (count <= 0) return false;
      size += count; progress = millis();
    } else if (!http.connected()) return false;
    if (millis() - progress > 4000 || millis() - started > 20000) return false;
    delay(1);
  }
  return listening && size == size_t(total);
}
bool playReply(size_t bytes, const String &gesture) {
  phase = "speaking";
  int peak = 1;
  for (size_t i = 0; i < bytes; i += 2) {
    int16_t value = int16_t(uint16_t(replyAudio[i]) | uint16_t(replyAudio[i + 1]) << 8);
    peak = max(peak, abs(int(value)));
  }
  // Bound quiet-recording amplification and retain digital headroom at the configured peak.
  float gain = fminf(5.0f, float(BAYMAX_VOICE_PEAK) / peak);
  audio.setPins(4, 5, 7, -1);
  if (!audio.begin(I2S_MODE_STD, SPEAKER_RATE, I2S_DATA_BIT_WIDTH_32BIT, I2S_SLOT_MODE_STEREO)) {
    audio.end(); pinMode(7, OUTPUT); digitalWrite(7, LOW); return false;
  }
  uint8_t speechArm = (replyPart % 2) ? 2 : 1;
  if (gesture == "greeting" || gesture == "farewell") servos.gesture(2, true, 100, true);
  else if (gesture == "explain") servos.gesture(replyPart % 2 ? 2 : 1, true, 100, true);
  else servos.gesture(0, false, gesture == "gentle" ? 35 : 60);
  const size_t samples = bytes / 2, total = samples + SPEAKER_RATE / 20;
  uint32_t started = millis(); bool ok = true;
  for (size_t base = 0; base < total && listening; base += 128) {
    controls(); servos.tick();
    // Repeat only while speech remains, alternating arms with an accompanying head turn.
    // Each cycle retains calibrated limits, easing and the controller's watchdog.
    if (!servos.moving() && base + SPEAKER_RATE * 2 < samples) {
      speechArm = speechArm == 1 ? 2 : 1;
      servos.gesture(speechArm, true, gesture == "gentle" ? 40 : 100, gesture != "gentle");
    }
    if (!listening || millis() - started > 63000) { ok = false; break; }
    int32_t stereo[256];
    for (size_t j = 0; j < 128; ++j) {
      size_t n = base + j; int32_t value = 0;
      if (n < samples) {
        int16_t pcm = int16_t(uint16_t(replyAudio[n * 2]) | uint16_t(replyAudio[n * 2 + 1]) << 8);
        float edge = fminf(1.0f, fminf(float(n) / 720, float(samples - 1 - n) / 720));
        float fade = 0.5f - 0.5f * cosf(PI * edge);
        value = int32_t(pcm * gain * fade) * 65536;
      }
      stereo[j * 2] = stereo[j * 2 + 1] = value;
    }
    size_t written = 0;
    if (i2s_channel_write(audio.txChan(), stereo, sizeof(stereo), &written, 100) != ESP_OK || written != sizeof(stereo)) {
      ok = false; break;
    }
  }
  audio.end(); pinMode(7, OUTPUT); digitalWrite(7, LOW);
  // Let a successful short reply's gesture return gently to centre in loop().
  // Microphone capture resumes while the bounded gesture finishes.
  if (!ok || !listening) servos.stop();
  return ok && listening;
}
void pollReply() {
  if (millis() - jobStarted > 420000) { retryLater("Laptop processing timed out.", 10000); return; }
  if (int32_t(millis() - pollAt) < 0) return;
  pollAt = millis() + 100;
  PromptClient client; HTTPClient http;
  if (!openHttp(http, client, "/result/" + jobId + "?part=" + String(replyPart))) return;
  busyIO = true; int code = http.GET(); controls();
  if (!listening) { http.end(); busyIO = false; return; }
  if (code == 202 || code < 0) { http.end(); busyIO = false; return; }
  bool end = http.header("X-Conversation") == "end";
  String gesture = http.header("X-Gesture");
  bool more = http.header("X-Reply-More") == "1";
  long windowMs = http.header("X-Conversation-Window-Ms").toInt();
  if (windowMs < 30000 || windowMs > 90000) windowMs = CONVERSATION_WINDOW_MS;
  size_t bytes = 0;
  bool downloaded = code == 200 && downloadReply(http, bytes);
  http.end();
  if (!listening) { busyIO = false; return; }
  bool played = downloaded && playReply(bytes, gesture);
  busyIO = false;
  if (!listening) return;
  if (played && more) {
    ++replyPart; pollAt = millis(); phase = "thinking";
    return;
  }
  jobId = "";
  if (played) {
    inConversation = !end; conversationUntil = millis() + uint32_t(windowMs);
    resumeAt = millis(); phase = "waiting";
    // Restart capture here, before phone HTTP maintenance can stall the next loop.
    monitor();
    console->println(end ? "Conversation ended. Waiting for Baymax / ouch." : "Reply played. Speak your answer after a short pause.");
  } else if (code == 204) retryLater("No recognized speech or wake phrase.", 100);
  else retryLater("Reply failed. Listening will retry; use ? for status.");
}
void monitor() {
  if (int32_t(millis() - resumeAt) < 0) return;
  if (inConversation && int32_t(millis() - conversationUntil) >= 0 && !capturing) inConversation = false;
  if (!rx) {
    audio.setPins(4, 5, -1, 6);
    rx = audio.begin(I2S_MODE_STD, MIC_RATE, I2S_DATA_BIT_WIDTH_32BIT, I2S_SLOT_MODE_MONO, I2S_STD_SLOT_LEFT);
    if (!rx) { audio.end(); retryLater("Microphone I2S failed."); return; }
    rxStarted = millis(); phase = "listening";
  }
  int32_t raw[256]; size_t bytes = 0;
  esp_err_t err = i2s_channel_read(audio.rxChan(), raw, sizeof(raw), &bytes, 50);
  size_t count = bytes / 4;
  if (err != ESP_OK || !count) { stopMic(); retryLater("Microphone read failed."); return; }
  double sum = 0, squares = 0;
  for (size_t i = 0; i < count; ++i) { double s = int16_t(raw[i] >> 16); sum += s; squares += s * s; }
  float level = sqrt(fmax(0.0, squares / count - (sum / count) * (sum / count)));
  bool calibrating = noiseCalibrationSamples < MIC_RATE;
  if (calibrating && millis() - rxStarted >= 32) {
    calibrationMinimum = fminf(calibrationMinimum, level);
    noiseCalibrationSamples += count;
    if (noiseCalibrationSamples >= MIC_RATE) {
      noiseFloor = fmaxf(30.0f, fminf(800.0f, calibrationMinimum));
      console->printf("Room noise calibrated: rms=%.0f\n", noiseFloor);
    }
  }
  float threshold = fmaxf(BAYMAX_MIC_THRESHOLD, noiseFloor * (inConversation ? 2.5f : 3.0f));
  bool loud = level >= threshold;
  if (!capturing && !loud && !servos.moving()) noiseFloor = 0.99f * noiseFloor + 0.01f * level;
  if (millis() - lastLevel >= 1000) {
    lastLevel = millis(); console->printf("LEVEL rms=%.0f trigger=%.0f mode=%s\n", level, threshold, inConversation ? "conversation" : "wake");
  }
  if (millis() - rxStarted < 32) return; // discard only the first two startup frames
  if (!capturing && loud && !calibrating) {
    capturing = true; captured = preCount; quiet = voiced = 0;
    endpoint.begin(inConversation);
    size_t start = (preIndex + PRE_SAMPLES - preCount) % PRE_SAMPLES;
    for (size_t i = 0; i < preCount; ++i) put16(recording + 44 + i * 2, uint16_t(preAudio[(start + i) % PRE_SAMPLES]));
    phase = "recording";
  }
  for (size_t i = 0; i < count; ++i) {
    int16_t pcm = int16_t(raw[i] >> 16);
    if (capturing && captured < MAX_SAMPLES) put16(recording + 44 + captured++ * 2, uint16_t(pcm));
    preAudio[preIndex] = pcm; preIndex = (preIndex + 1) % PRE_SAMPLES;
    preCount = min(preCount + 1, PRE_SAMPLES);
  }
  if (capturing) {
    if (loud) { quiet = 0; voiced += count; } else quiet += count;
    endpoint.observe(loud, uint32_t(count * 1000 / MIC_RATE));
    if (captured >= MAX_SAMPLES || endpoint.finished()) {
      console->printf("Capture finished: seconds=%.1f pause_ms=%u limit=%d\n", float(captured)/MIC_RATE, endpoint.pauseMs(), captured >= MAX_SAMPLES);
      // Keep 250ms of trailing silence for word endings; do not upload the full endpoint wait.
      const size_t tail = MIC_RATE / 4;
      size_t samples = captured - (quiet > tail ? min(quiet - tail, captured) : 0), speech = voiced;
      bool wake = !inConversation;
      stopMic();
      if (speech >= MIC_RATE * 8 / 100) submit(samples, wake);
      else { phase = "waiting"; resumeAt = millis() + 500; }
    }
  }
}
void setup() {
  Serial.begin(115200); Serial0.begin(115200);
  pinMode(7, OUTPUT); digitalWrite(7, LOW);
  bool pca = servos.begin(BAYMAX_MOTION_ENABLED);
  delay(500);
  console->printf("BAYMAX v2 boot: PCA=%d motion=%d; X stop, W resume, ? status, H/L/R small calibrated gestures.\n", pca, servos.permitted());
  if (!psramFound()) { phase = "error_psram"; listening = false; console->println("PSRAM unavailable. Select OPI PSRAM / N16R8 board settings."); return; }
  recording = static_cast<uint8_t*>(ps_malloc(44 + MAX_SAMPLES * 2));
  replyAudio = static_cast<uint8_t*>(ps_malloc(MAX_REPLY_BYTES));
  if (!recording || !replyAudio) { phase = "error_memory"; listening = false; return; }
  baseUrl = DEVICE_URL;
  if (!baseUrl.startsWith("http://") || !baseUrl.endsWith("/device/turn") || strlen(DEVICE_TOKEN) < 32) {
    phase = "error_config"; listening = false; console->println("Check DEVICE_URL and DEVICE_TOKEN in config.h."); return;
  }
  baseUrl.remove(baseUrl.length() - 5);
  phone.begin([](){
    listening=false; inConversation=false; jobId="";
    stopMic(); servos.stop(); phase="stopped";
  },[](){
    if (!recording || !replyAudio) return;
    listening=true; inConversation=false; resumeAt=millis()+1000; phase="waiting";
  },[](){return listening;},[](){return busyIO;});
  baseUrl=phone.serverBase();
  wifiAttempt = millis(); resumeAt = millis() + 2000; phase = "waiting";
}
void loop() {
  phone.tick(); baseUrl=phone.serverBase();
  controls(); servos.tick();
  if (!recording || !replyAudio || !baseUrl.endsWith("/device")) { delay(20); return; }
  if (!listening) { if (rx) stopMic(); delay(10); return; }
  if (WiFi.status() != WL_CONNECTED) {
    stopMic();
    delay(10); return;
  }
  if (jobId.length()) pollReply(); else monitor();
  delay(1);
}
