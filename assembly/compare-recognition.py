"""Compare recognizers on reproducible generated speech, not human recordings."""
import json
import sys
import time
import wave
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from faster_whisper import WhisperModel
from speech_recognition import transcribe
folder = ROOT / "assembly/verification/speech-fixtures"
phrases = json.loads((folder / "phrases.json").read_text())
with wave.open(str(folder / "silence.wav"), "wb") as silence:
    silence.setnchannels(1)
    silence.setsampwidth(2)
    silence.setframerate(16000)
    silence.writeframes(b"\0" * 16000 * 2 * 2)
results = []
for name in ["tiny.en", "base.en"]:
    model = WhisperModel(name, device="cpu", compute_type="int8", cpu_threads=4,
                         download_root=ROOT / ".models", local_files_only=True)
    for i, expected in enumerate(phrases):
        start = time.perf_counter()
        heard = transcribe(model, folder / f"{i}.wav")
        results.append(dict(model=name, expected=expected, heard=heard,
                            elapsedMs=round((time.perf_counter()-start)*1000)))
    heard = transcribe(model, folder / "silence.wav")
    results.append(dict(model=name, expected="", heard=heard, case="silence"))
report = dict(kind="Synthetic loopback; not physical microphone validation", results=results)
(ROOT / "assembly/verification/recognition-comparison.json").write_text(json.dumps(report, indent=2))
print(json.dumps(report, indent=2))
