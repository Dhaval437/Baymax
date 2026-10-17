"""Local ESP32 microphone level monitor. No audio recording or network upload."""
import json
import re
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / '.tools' / 'microphone-monitor-deps'))
import serial

PORT = 8792
ADDRESS = f'http://127.0.0.1:{PORT}'
PATTERN = re.compile(r'MIC t=([\d.]+)s samples=(\d+) rms_ac=([\d.]+) mean=([-\d.]+) min=(-?\d+) max=(-?\d+) zeros=([\d.]+)% clips=(\d+) read_errors=(\d+)')
lock = threading.Lock()
cancel = threading.Event()
state = dict(status='idle', samples=[], started=None, error='', source='Previous test', port='COM14')

def sample_from(line):
    m = PATTERN.search(line)
    if not m:
        return None
    t, n, rms, mean, lo, hi, zeros, clips, errors = m.groups()
    return dict(t=float(t), n=int(n), rms=float(rms), mean=float(mean), minimum=int(lo), maximum=int(hi), zeros=float(zeros), clips=int(clips), errors=int(errors))

history = ROOT / 'assembly' / 'MIC_LEVEL_TEST_2026-10-15.txt'
if history.exists():
    last = history.read_text(encoding='utf-8-sig').split('User-requested repeat:')[-1]
    state['samples'] = [s for line in last.splitlines() if (s := sample_from(line))]

def run_test():
    connection = None
    lines = []
    try:
        connection = serial.Serial()
        connection.port = 'COM14'
        connection.baudrate = 115200
        connection.timeout = .15
        connection.write_timeout = 1
        connection.dtr = False
        connection.rts = False
        connection.open()
        time.sleep(.6)
        connection.reset_input_buffer()
        connection.write(b'X?')
        response = ''
        deadline = time.monotonic() + 3
        while time.monotonic() < deadline and 'MIC STATUS motors_off=1 testing=0 SCK=4 WS=5 SD=6' not in response:
            response += connection.readline().decode('ascii', errors='replace')
        if 'MIC STATUS motors_off=1 testing=0 SCK=4 WS=5 SD=6' not in response:
            raise RuntimeError('ESP32 did not confirm microphone test mode with motors off. Check USB; do not change the wiring.')
        if cancel.is_set():
            with lock: state['status'] = 'stopped'
            return
        connection.write(b'M')
        deadline = time.monotonic() + 25
        completed = False
        while time.monotonic() < deadline:
            if cancel.is_set():
                with lock: state['status'] = 'stopped'
                break
            line = connection.readline().decode('ascii', errors='replace').strip()
            if not line:
                continue
            lines.append(line)
            if line.startswith('MIC START:'):
                with lock:
                    state.update(status='running', started=time.time(), source='Live ESP32 microphone')
            if (s := sample_from(line)):
                with lock: state['samples'].append(s)
            if line.startswith('ERROR:'):
                raise RuntimeError(line)
            if line.startswith('MIC DONE:'):
                completed = True
                break
        if not completed and not cancel.is_set():
            raise RuntimeError('Test timed out. The microphone stop command has been sent.')
        connection.write(b'X?')
        response = ''
        deadline = time.monotonic() + 2
        while time.monotonic() < deadline and 'MIC STATUS motors_off=1 testing=0' not in response:
            response += connection.readline().decode('ascii', errors='replace')
        if 'MIC STATUS motors_off=1 testing=0' not in response:
            raise RuntimeError('Could not confirm the microphone stopped. Unplug USB before changing connections.')
        with lock: state['status'] = 'complete' if completed else 'stopped'
    except Exception as exc:
        with lock: state.update(status='error', error=str(exc))
    finally:
        if connection and connection.is_open:
            try: connection.write(b'X')
            except serial.SerialException: pass
            connection.close()
        if lines:
            with (ROOT / 'assembly' / 'MIC_LIVE_GRAPH_LOG.txt').open('a', encoding='utf-8') as f:
                f.write('\nTest ' + time.strftime('%Y-%m-%d %H:%M:%S') + '\n' + '\n'.join(lines) + '\n')

class Handler(BaseHTTPRequestHandler):
    def log_message(self, *_): pass
    def reply(self, value, code=200):
        payload = json.dumps(value).encode()
        self.send_response(code)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Cache-Control', 'no-store')
        self.end_headers()
        self.wfile.write(payload)
    def do_GET(self):
        if self.path == '/state':
            with lock: snapshot = dict(state, samples=list(state['samples']))
            snapshot['elapsed'] = min(20, max(0, time.time() - snapshot['started'])) if snapshot['started'] else 0
            self.reply(snapshot)
        elif self.path in ('/', '/index.html'):
            self.send_response(200)
            self.send_header('Content-Type', 'text/html; charset=utf-8')
            self.send_header('Cache-Control', 'no-store')
            self.end_headers()
            self.wfile.write(Path(__file__).with_name('index.html').read_bytes())
        else: self.reply({'error': 'Not found'}, 404)
    def do_POST(self):
        if self.headers.get('Origin') != ADDRESS or self.headers.get('Host') != f'127.0.0.1:{PORT}' or self.headers.get('Content-Type') != 'application/json':
            self.reply({'error': 'Use the local monitor page.'}, 403)
            return
        if self.path == '/start':
            with lock:
                if state['status'] in ('connecting', 'running'):
                    self.reply({'error': 'Test already running'}, 409)
                    return
                cancel.clear()
                state.update(status='connecting', samples=[], started=None, error='', source='Live ESP32 microphone')
            threading.Thread(target=run_test, daemon=True).start()
            self.reply({'ok': True})
        elif self.path == '/stop':
            cancel.set()
            self.reply({'ok': True})
        else: self.reply({'error': 'Not found'}, 404)

if __name__ == '__main__':
    print(f'Microphone monitor: {ADDRESS}', flush=True)
    ThreadingHTTPServer(('127.0.0.1', PORT), Handler).serve_forever()
