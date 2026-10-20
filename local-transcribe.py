import sys
from pathlib import Path
from speech_recognition import load_recognizer, transcribe

audio = Path(sys.argv[1])
print(transcribe(load_recognizer(), audio), end="")
