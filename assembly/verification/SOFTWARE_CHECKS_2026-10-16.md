# Integrated Baymax software checks

- Node regression and device integration tests: **24 passed, 0 failed**.
- Real C++ ServoController tested on a simulated I2C bus: passed disabled startup, channels 0/1/2, pulse limits, ramp, centering, stop, exclusion of concurrent gestures, I2C failure latch.
- ESP32-S3 N16R8 / OPI PSRAM build: **989,539 bytes flash, 56,364 bytes static RAM**, successful. Binary hash and board options: `integrated-build.json`.
- Real local speech pipeline: transcription → Ollama reply → Sopro synthesis → PCM download, passed in **37.639 seconds**; returned **6.475 seconds** of audio. See `integrated-smoke.json`.
- Launcher prerequisites: passed. Updated the private firmware's laptop address locally, preserving credentials. The address is intentionally omitted from the repository.
- Launcher runtime: the authenticated private LAN endpoint reported protocol 2, and the local browser app returned HTTP 200. Device-specific addresses are intentionally omitted. Test services stopped afterwards.
- No serial port opened, no firmware uploaded, no sound played and no motors moved during these checks.

Pending physical validation after assembly: joint centres/travel, room microphone threshold, complete wake/conversation cycle on the ESP32, and the separately deferred speaker loudness/distortion work.
