"""Shared local recognition settings for the worker and standalone tool."""
from pathlib import Path
from faster_whisper import WhisperModel

ROOT = Path(__file__).resolve().parent


def load_recognizer():
    return WhisperModel("tiny.en", device="cpu", compute_type="int8",
                        cpu_threads=4, download_root=ROOT / ".models",
                        local_files_only=True)


def transcribe(model, audio, hints=""):
    segments, _ = model.transcribe(
        str(audio), beam_size=3, language="en", temperature=0,
        condition_on_previous_text=False,
        # Bias only the robot's name; never guess the user's symptoms.
        hotwords="Baymax, ouch, ow, check status" + (", " + str(hints)[:600] if hints else ""),
        vad_filter=True,
        vad_parameters={"threshold": 0.35, "speech_pad_ms": 500,
                        "min_speech_duration_ms": 0})
    return " ".join(segment.text.strip() for segment in segments).strip()
