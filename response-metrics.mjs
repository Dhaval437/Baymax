export class ResponseMetrics {
  constructor() { this.recent = []; }
  record(timings) {
    const row = {};
    for (const name of ['receiving', 'transcribing', 'thinking', 'synthesizing'])
      row[name] = Math.max(0, Number(timings[name]) || 0);
    this.recent.push(row); this.recent = this.recent.slice(-20);
  }
  snapshot() {
    const averages = {};
    for (const name of ['receiving', 'transcribing', 'thinking', 'synthesizing'])
      averages[name] = this.recent.length ? Math.round(this.recent.reduce((n, x) => n + x[name], 0) / this.recent.length) : 0;
    const slowest = Object.keys(averages).sort((a, b) => averages[b] - averages[a])[0];
    const suggestions = {
      receiving: 'Audio upload is the largest delay. Improve the Wi-Fi signal before changing recognition.',
      transcribing: 'Recognition is the largest delay. Compare models using corrected test phrases.',
      thinking: 'Answer generation is the largest delay. Benchmark a faster language model.',
      synthesizing: 'Voice generation is the largest delay. Say “use fast voice” to try the faster standard voice.'
    };
    return { samples: this.recent.length, averages, recommendation: this.recent.length >= 3 ?
      suggestions[slowest] : 'Collecting three completed replies before recommending a change.',
      scope: 'Upload through audio-ready; excludes capture, download and playback.' };
  }
}
