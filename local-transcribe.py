import sys
from pathlib import Path
from faster_whisper import WhisperModel

audio = Path(sys.argv[1])
model = WhisperModel("tiny.en", device="cpu", compute_type="int8", download_root=Path(__file__).parent / ".models")
segments, _ = model.transcribe(str(audio), beam_size=2, language="en", vad_filter=True)
print(" ".join(segment.text.strip() for segment in segments).strip(), end="")
