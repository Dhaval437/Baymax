// Bounded RAM-only audio reuse. Never cache answers by question: context may change.
export function cachedSpeech(synthesize, maxBytes = 12 * 1024 * 1024) {
  const entries = new Map();
  let bytes = 0;
  const cached = async text => {
    if (entries.has(text)) {
      const audio = entries.get(text);
      entries.delete(text); entries.set(text, audio);
      return audio;
    }
    const audio = await synthesize(text);
    if (audio.length <= maxBytes) {
      while (bytes + audio.length > maxBytes && entries.size) {
        const oldest = entries.keys().next().value;
        bytes -= entries.get(oldest).length; entries.delete(oldest);
      }
      entries.set(text, audio); bytes += audio.length;
    }
    return audio;
  };
  cached.clear = () => { entries.clear(); bytes = 0; };
  return cached;
}
