import { readFile, mkdir, writeFile, rename } from 'node:fs/promises';
import { dirname } from 'node:path';
const defaultFile = new URL('./assembly/private/learning.json', import.meta.url);
export class LearningStore {
  constructor(file = defaultFile) { this.file = file; this.state = null; }
  async load() {
    if (this.state) return this.state;
    try {
      const data = JSON.parse(await readFile(this.file, 'utf8'));
      this.state = { corrections: Array.isArray(data.corrections) ? data.corrections.filter(x =>
        typeof x === 'string' && x.length <= 120).slice(-30) : [],
        voice: data.voice === 'fast' ? 'fast' : 'character' };
    } catch (e) {
      if (e.code !== 'ENOENT') throw e;
      this.state = { corrections: [], voice: 'character' };
    }
    return this.state;
  }
  async save(next) {
    const file = this.file instanceof URL ? this.file : String(this.file);
    const { fileURLToPath } = await import('node:url');
    const path = file instanceof URL ? fileURLToPath(file) : file;
    await mkdir(dirname(path), { recursive: true });
    await writeFile(path + '.tmp', JSON.stringify(next), 'utf8');
    await rename(path + '.tmp', path);
    this.state = next;
  }
  async remember(phrase) {
    const state = await this.load();
    await this.save({ ...state, corrections: [...state.corrections.filter(x => x !== phrase), phrase].slice(-30) });
  }
  async forget() { await this.save({ ...(await this.load()), corrections: [] }); }
  async voice(mode) { await this.save({ ...(await this.load()), voice: mode }); }
}
export const learningStore = new LearningStore();

// Commands are explicit; arbitrary statements never become persistent memory.
export function learningCommand(text) {
  const command = String(text).trim().replace(/^baymax[,\s]+/i, '').replace(/[.!?]+$/, '').trim();
  if (/^what did you hear$/i.test(command)) return { kind: 'heard' };
  if (/^(?:remember (?:this|that) correction|save (?:this|that) correction)$/i.test(command)) return { kind: 'save' };
  if (/^forget (?:my |all )?corrections$/i.test(command)) return { kind: 'forget' };
  if (/^(?:use |switch to )?fast voice$/i.test(command)) return { kind: 'voice', mode: 'fast' };
  if (/^(?:use |switch to )?(?:baymax|character) voice$/i.test(command)) return { kind: 'voice', mode: 'character' };
  const correction = command.match(/^(?:no[,\s]+)?I said[,\s]+(.{1,120}?)$/i);
  if (correction) return { kind: 'correct', phrase: correction[1].split(/,\s*not\s+/i)[0].trim() };
  return null;
}
