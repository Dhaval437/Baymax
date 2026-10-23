"""Shared local recognition settings for the worker and standalone tool."""
from pathlib import Path
import re
from faster_whisper import WhisperModel

ROOT = Path(__file__).resolve().parent


def load_recognizer():
    return WhisperModel("tiny.en", device="cpu", compute_type="int8",
                        cpu_threads=4, download_root=ROOT / ".models",
                        local_files_only=True)


def transcribe(model, audio, hints=""):
    options = dict(beam_size=3, language="en", temperature=0,
        condition_on_previous_text=False,
        # Hints bias recognition without substituting a guessed transcript.
        hotwords="Baymax, ouch, ow, check status" + (", " + str(hints)[:600] if hints else ""),
        no_speech_threshold=0.6, log_prob_threshold=-1.0,
        compression_ratio_threshold=2.4)
    segments, info = model.transcribe(str(audio), **options,
        vad_filter=True,
        vad_parameters={"threshold": 0.35, "speech_pad_ms": 500,
                        "min_speech_duration_ms": 0})
    text = " ".join(segment.text.strip() for segment in segments).strip()
    if not text and info.duration_after_vad == 0 and 0.15 <= info.duration <= 60:
        # The ESP already gated this recording. If Silero rejects every sample,
        # let Whisper assess it once, retaining its own silence/confidence checks.
        segments, _ = model.transcribe(str(audio), **options, vad_filter=False)
        text = " ".join(segment.text.strip() for segment in segments).strip()
    words = re.findall(r"\w+", text.lower())
    # Reject noise hallucinations, not replace them with a guessed utterance.
    if len(words) > info.duration * 8 + 8:
        return ""
    if len(words) >= 12 and len(set(words)) <= len(words) / 4:
        return ""
    return text
