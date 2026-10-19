import { networkInterfaces } from 'node:os';
import { readFile, access } from 'node:fs/promises';
import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { createDeviceServer } from './device-server.mjs';
import { createServer } from './server.mjs';
import { createRobotDashboard } from './robot-dashboard.mjs';
import { warmLocalSpeech, closeLocalSpeech } from './local-speech-worker.mjs';
import { chooseRobotAddress } from './network-address.mjs';

const run = promisify(execFile), root = new URL('./', import.meta.url), failures = [];
const check = (ok, label) => { console.log(`${ok ? 'OK' : 'CHECK'}: ${label}`); if (!ok) failures.push(label); };
let config = '';
try { config = await readFile(new URL('firmware/MiniBaymax/config.h', root), 'utf8'); } catch {}
const define = name => config.match(new RegExp('^\\s*#define\\s+' + name + '\\s+"([^"\\r\\n]*)"', 'm'))?.[1];
const token = process.env.BAYMAX_DEVICE_TOKEN;
check(token?.length >= 32 && token === define('DEVICE_TOKEN'), 'Laptop and firmware device tokens match');
check(!!define('WIFI_SSID') && !define('WIFI_SSID').startsWith('YOUR_'), 'Firmware Wi-Fi is configured');
let deviceUrl;
try { deviceUrl = new URL(define('DEVICE_URL')); } catch {}
const addresses = Object.values(networkInterfaces()).flat().filter(n => n && n.family === 'IPv4' && !n.internal).map(n => n.address);
let bindAddress;
try { bindAddress=chooseRobotAddress(networkInterfaces(),{override:process.env.BAYMAX_BIND_ADDRESS,previous:deviceUrl?.hostname}); }
catch(error) { console.log(error.message); console.log('Current laptop IPv4 addresses: '+addresses.join(', ')); }
check(!!bindAddress,'Laptop has a private network address for Baymax');
if(bindAddress) console.log(`Phone setup server address: http://${bindAddress}:${Number(process.env.BAYMAX_DEVICE_PORT || deviceUrl?.port || 8788)}`);
for (const path of ['.venv/Scripts/python.exe', '.venv/Scripts/soprotts.exe', '.reference/baymax-reference-advice.wav']) {
  try { await access(new URL(path, root)); check(true, path); } catch { check(false, path); }
}
try { await run(process.env.FFMPEG_PATH || 'ffmpeg', ['-version'], { timeout: 5000, windowsHide: true }); check(true, 'FFmpeg audio conversion'); }
catch { check(false, 'FFmpeg audio conversion'); }
try {
  const response = await fetch('http://127.0.0.1:11434/api/tags', { signal: AbortSignal.timeout(4000) });
  const data = await response.json();
  check(data.models?.some(model => model.name === (process.env.LOCAL_MODEL || 'qwen3:1.7b')), 'Ollama and selected local model');
} catch { check(false, 'Ollama and selected local model'); }
if (failures.length) {
  console.error('Fix the CHECK items before starting Baymax. No hardware was changed.'); process.exitCode = 1;
} else if (process.argv.includes('--check')) {
  console.log('Software prerequisites passed. Physical wiring and sound quality are not checked here.');
} else {
  console.log('Warming local speech models once for faster replies...');
  try { await warmLocalSpeech(); console.log('Local speech models loaded and ready.'); }
  catch { console.error('Local speech warm-up failed; requests will retry.'); }
  // Phone setup can change the robot's endpoint after the laptop changes networks.
  // Bind only the selected private interface, not every interface.
  const device = createDeviceServer(), ui = createServer({ env: { ...process.env, AI_PROVIDER: 'local' } });
  const dashboard = createRobotDashboard(device, { serialPort: process.env.BAYMAX_SERIAL_PORT || 'COM14' });
  dashboard.on('error', error => console.error('Robot dashboard could not start (' + error.code + ').'));
  const devicePort = Number(process.env.BAYMAX_DEVICE_PORT || deviceUrl?.port || 8788), uiPort = Number(process.env.PORT || 8787);
  device.on('error', error => { console.error('Device server could not start (' + error.code + '). Close an old device server first.'); ui.close(); process.exitCode = 1; });
  device.listen(devicePort, bindAddress, () => {
    console.log(`Robot server ready on ${bindAddress}:${devicePort}. Keep this window open.`);
    console.log('Robot listens when powered. Motion follows RobotSettings.h. Ctrl+C stops laptop services.');
    ui.listen(uiPort, '127.0.0.1', () => console.log(`Optional browser app: http://127.0.0.1:${uiPort}`));
    dashboard.listen(8793, '127.0.0.1', () => console.log('Live robot dashboard: http://127.0.0.1:8793'));
  });
  ui.on('error', error => console.log('Optional browser app not started (' + error.code + '); robot service is independent.'));
  for (const event of ['SIGINT', 'SIGTERM']) process.once(event, () => {
    device.close(); ui.close(); dashboard.close(); closeLocalSpeech(); device.closeAllConnections(); ui.closeAllConnections(); dashboard.closeAllConnections(); process.exit(0);
  });
}
