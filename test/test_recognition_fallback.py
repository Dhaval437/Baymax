import importlib.util
from pathlib import Path
import sys
import types
import unittest

sys.modules.setdefault("faster_whisper", types.SimpleNamespace(WhisperModel=object))
spec = importlib.util.spec_from_file_location(
    "recognition_under_test", Path(__file__).resolve().parents[1] / "speech_recognition.py")
recognition = importlib.util.module_from_spec(spec)
spec.loader.exec_module(recognition)


class Model:
    def __init__(self, texts, kept=0, duration=3.5):
        self.texts, self.calls = iter(texts), []
        self.info = types.SimpleNamespace(duration_after_vad=kept, duration=duration)

    def transcribe(self, audio, **options):
        self.calls.append(options)
        text = next(self.texts)
        return iter([types.SimpleNamespace(text=text)] if text else []), self.info


class FallbackTests(unittest.TestCase):
    def test_vad_rejected_speech_gets_one_fallback(self):
        model = Model(["", "Baymax hello"])
        self.assertEqual(recognition.transcribe(model, "test.wav"), "Baymax hello")
        self.assertEqual([c["vad_filter"] for c in model.calls], [True, False])
        self.assertEqual(model.calls[1]["no_speech_threshold"], 0.6)

    def test_no_repeated_fallback_or_forced_transcript(self):
        model = Model(["", ""])
        self.assertEqual(recognition.transcribe(model, "test.wav"), "")
        self.assertEqual(len(model.calls), 2)

    def test_success_and_recognizer_silence_do_not_retry(self):
        for text in ["hello", ""]:
            model = Model([text], kept=2)
            self.assertEqual(recognition.transcribe(model, "test.wav"), text)
            self.assertEqual(len(model.calls), 1)

    def test_duration_bound(self):
        for duration in [0.1, 61]:
            model = Model([""], duration=duration)
            self.assertEqual(recognition.transcribe(model, "test.wav"), "")
            self.assertEqual(len(model.calls), 1)

    def test_impossible_rate_and_repeated_noise_hallucinations(self):
        for texts, kept, duration in [
            (["", "okay " * 80], 0, 0.45),
            (["okay " * 30], 2, 10),
            (["one two three four five six seven eight nine ten eleven twelve thirteen"], 1, 0.3),
        ]:
            self.assertEqual(recognition.transcribe(Model(texts, kept, duration), "test.wav"), "")

    def test_normal_short_replies_and_ordinary_sentences_survive(self):
        for text in ["okay", "okay okay", "Baymax hello",
                     "I have a problem with my arm and I want to explain it"]:
            self.assertEqual(recognition.transcribe(Model([text], kept=3, duration=4), "test.wav"), text)


if __name__ == "__main__":
    unittest.main()
