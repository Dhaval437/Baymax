"""Resident local speech models. JSON-lines over private parent/child pipes."""
import contextlib
import json
import os
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
os.environ['HF_HOME'] = str(ROOT / '.models' / 'hf')
os.environ['HF_HUB_OFFLINE'] = '1'
protocol = sys.stdout
tts = reference = recognizer = None

def emit(value):
    protocol.write(json.dumps(value) + '\n')
    protocol.flush()

def load_voice():
    global tts, reference
    if tts is None:
        from sopro import SoproTTS
        tts = SoproTTS.from_pretrained(device='cpu')
        reference = tts.prepare_reference(ref_audio_path=ROOT / '.reference' / 'baymax-reference-advice.wav')

def load_recognizer():
    global recognizer
    if recognizer is None:
        from speech_recognition import load_recognizer as create_recognizer
        recognizer = create_recognizer()

for line in sys.stdin:
    request = {}
    started = time.perf_counter()
    try:
        request = json.loads(line)
        with contextlib.redirect_stdout(sys.stderr):
            operation = request.get('op')
            if operation == 'warm':
                load_voice()
                load_recognizer()
                result = {'ready': True, 'recognitionModel': 'tiny.en'}
            elif operation == 'speak':
                load_voice()
                if not isinstance(request.get('text'), str) or not 0 < len(request['text']) <= 2000:
                    raise ValueError('Invalid text length')
                if 'seed' in request:
                    import torch
                    torch.manual_seed(int(request['seed']))
                wav = tts.synthesize(request['text'], ref=reference).cpu()
                tts.save_wav(request['output'], wav)
                result = {'audioSeconds': wav.shape[-1] / tts.sample_rate}
            elif operation == 'transcribe':
                load_recognizer()
                from speech_recognition import transcribe
                result = {'text': transcribe(recognizer, request['input'], request.get('hints', ''))}
            else:
                raise ValueError('Unknown operation')
        emit({'id': request.get('id'), 'ok': True, 'result': result, 'elapsedMs': round((time.perf_counter() - started) * 1000)})
    except Exception as error:
        # Do not echo request text, credentials or file contents into the log.
        print('Local speech worker failed: ' + type(error).__name__, file=sys.stderr, flush=True)
        emit({'id': request.get('id'), 'ok': False, 'error': 'Local speech operation failed: ' + type(error).__name__})
