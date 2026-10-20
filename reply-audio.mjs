export function replySegments(text) {
  const sentences = [...new Intl.Segmenter('en', { granularity: 'sentence' }).segment(text)]
    .map(s => s.segment.trim()).filter(Boolean);
  return sentences.length ? sentences : [text];
}

// Remove only quiet edges, never pauses inside a sentence. Keep 80ms padding.
export function trimAudioEdges(pcm, rate = 24000) {
  const frame = Math.round(rate / 100);
  let first = -1, last = -1;
  for (let offset = 0; offset < pcm.length / 2; offset += frame) {
    const count = Math.min(frame, pcm.length / 2 - offset);
    let squares = 0;
    for (let n = 0; n < count; n++) squares += pcm.readInt16LE((offset + n) * 2) ** 2;
    if (Math.sqrt(squares / count) >= 45) {
      if (first < 0) first = offset;
      last = offset + count;
    }
  }
  if (first < 0) return pcm;
  const padding = Math.round(rate * 0.08);
  return pcm.subarray(Math.max(0, first - padding) * 2, Math.min(pcm.length / 2, last + padding) * 2);
}
