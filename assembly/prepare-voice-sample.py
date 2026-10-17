"""Embed the existing local voice sample at a conservative peak level."""
import array
import math
import wave
from pathlib import Path

root = Path(__file__).resolve().parents[1]
source = root / 'voice-sample-smooth-v2.wav'
with wave.open(str(source), 'rb') as wav:
    assert wav.getnchannels() == 1 and wav.getsampwidth() == 2
    rate = wav.getframerate()
    samples = array.array('h', wav.readframes(wav.getnframes()))
peak = max(abs(x) for x in samples)
assert peak > 0 and len(samples) / rate < 15
gain = min(1.0, 4000 / peak)
fade_samples = rate * 0.03
output = []
for i, value in enumerate(samples):
    edge = min(1.0, i / fade_samples, (len(samples) - 1 - i) / fade_samples)
    output.append(round(value * gain * (0.5 - 0.5 * math.cos(math.pi * edge))))
target = root / 'firmware/MicrophoneDiagnostic/VoiceSample.h'
with target.open('w', encoding='utf-8') as f:
    f.write('// Generated from voice-sample-smooth-v2.wav; do not hand-edit.\n#pragma once\n#include <Arduino.h>\n')
    f.write(f'constexpr uint32_t VOICE_RATE = {rate};\nconstexpr uint32_t VOICE_LENGTH = {len(output)};\n')
    f.write('const int16_t VOICE_PCM[] PROGMEM = {\n')
    for start in range(0, len(output), 24):
        f.write(','.join(map(str, output[start:start+24])) + ',\n')
    f.write('};\n')
print(f'Prepared {len(output)/rate:.3f}s, peak {max(abs(x) for x in output)}, source unchanged.')
