import os, time, json
from pathlib import Path
root = Path(__file__).resolve().parent.parent
os.environ['HF_HOME'] = str(root / '.models' / 'hf')
os.environ['HF_HUB_OFFLINE'] = '1'
import torch
from sopro import SoproTTS
default = torch.get_num_threads()
torch.set_num_threads(4)
tts = SoproTTS.from_pretrained(device='cpu')
ref = tts.prepare_reference(ref_audio_path=root / '.reference' / 'baymax-reference-advice.wav')
results = []
for threads in dict.fromkeys([default, 2, 4]):
    torch.set_num_threads(threads)
    torch.manual_seed(42)
    start = time.perf_counter()
    wav = tts.synthesize('Hello. I am here to help you.', ref=ref).cpu()
    result = dict(threads=threads, elapsed=round(time.perf_counter()-start,3),
                  audioSeconds=round(wav.shape[-1]/tts.sample_rate,3))
    results.append(result)
    print(json.dumps(result), flush=True)
(root/'assembly/verification/voice-thread-benchmark.json').write_text(json.dumps(results, indent=2))
