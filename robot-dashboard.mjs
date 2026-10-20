import http from 'node:http';
import { readFile } from 'node:fs/promises';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';

export function createTelemetry(now = Date.now) {
  const data = { connected: false, verified: false, port: 'COM14', error: '', lastSeen: 0, state: 'unknown', samples: [], events: [], playbackFinishedAt: null };
  return {
    accept(message) {
      if ('connected' in message) { data.connected = message.connected; data.error = message.error || ''; data.port = message.port; if (!message.connected) data.verified = false; }
      if (!message.line) return;
      const line = message.line, t = now();
      if (/^BAYMAX v2 boot:/.test(line)) {
        data.events = [];
        data.playbackFinishedAt = null;
        data.lastSeen = t;
        return;
      }
      const state = line.match(/BAYMAX v2 state=(\S+) listening=(\d) conversation=(\d) wifi=(\d) pca=(\d) motion_enabled=(\d) moving=(\d)/);
      if (state) {
        Object.assign(data, { verified: true, lastSeen: t, state: state[1], listening: +state[2], conversation: +state[3], wifi: +state[4], pca: +state[5], motion: +state[6], moving: +state[7] });
        return;
      }
      const level = line.match(/LEVEL rms=([\d.]+) trigger=([\d.]+) mode=(\w+)/);
      if (level && data.verified) {
        data.lastSeen = t; data.samples.push({ t, rms: +level[1], trigger: +level[2], mode: level[3] });
        data.samples = data.samples.filter(s => t - s.t < 120000).slice(-120); return;
      }
      if (!data.verified) return;
      if (/Reply played|Conversation ended/.test(line)) data.playbackFinishedAt = t;
      if (/Processing speech|Reply played|Conversation ended|No recognized|failed|HTTP|unreachable|Reconnecting|Stopped:|Automatic listening/.test(line)) {
        data.events.push({ t, text: line }); data.events = data.events.slice(-12);
      }
    },
    snapshot() { return { ...structuredClone(data), fresh: data.connected && data.verified && now() - data.lastSeen < 7000 }; }
  };
}

export function createRobotDashboard(device, { port = 8793, serialPort = 'COM14', startSerial = true } = {}) {
  const telemetry = createTelemetry();
  let child;
  if (startSerial) {
    child = spawn(fileURLToPath(new URL('./.venv/Scripts/python.exe', import.meta.url)), ['-u', fileURLToPath(new URL('./assembly/conversation-serial.py', import.meta.url)), serialPort], { windowsHide: true, stdio: ['ignore', 'pipe', 'pipe'] });
    let buffer = '';
    child.stdout.on('data', chunk => {
      buffer += chunk.toString();
      let at;
      while ((at = buffer.indexOf('\n')) >= 0) {
        const line = buffer.slice(0, at); buffer = buffer.slice(at + 1);
        try { telemetry.accept(JSON.parse(line)); } catch {}
      }
      if (buffer.length > 10000) buffer = '';
    });
    const disconnected = () => telemetry.accept({ connected: false, port: serialPort, error: 'USB monitor stopped. Restart Baymax to reconnect.' });
    child.on('error', disconnected); child.on('exit', disconnected);
    child.stderr.on('data', () => {});
  }
  const server = http.createServer(async (req, res) => {
    res.setHeader('Cache-Control', 'no-store'); res.setHeader('X-Content-Type-Options', 'nosniff');
    res.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; frame-ancestors 'none'");
    if (req.headers.host !== `127.0.0.1:${server.address()?.port}` || (req.headers.origin && req.headers.origin !== `http://127.0.0.1:${server.address()?.port}`)) { res.writeHead(403); return res.end(); }
    if (req.method !== 'GET') { res.writeHead(405); return res.end(); }
    if (req.url === '/state') {
      res.setHeader('Content-Type', 'application/json');
      return res.end(JSON.stringify({ now: Date.now(), robot: telemetry.snapshot(), speech: device.dashboardSnapshot() }));
    }
    if (req.url === '/') {
      try { const page = await readFile(new URL('./public/robot-dashboard.html', import.meta.url)); res.setHeader('Content-Type', 'text/html; charset=utf-8'); return res.end(page); }
      catch { res.writeHead(500); return res.end('Dashboard file unavailable'); }
    }
    res.writeHead(404); res.end();
  });
  server.on('close', () => child?.kill());
  server.on('error', () => child?.kill());
  return server;
}
