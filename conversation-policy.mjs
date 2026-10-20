// Conservative estimates for the current English recognizer, not tokenizer counts.
export const tokenCost = text => Math.ceil(Buffer.byteLength(text, 'utf8') / 3) + 12;
export const messagesCost = messages => messages.reduce((n, m) => n + tokenCost(m.content), 0);
const CONTEXT_BUDGET = 2600, SUMMARY_BUDGET = 450;

export function replyProfile(text, history = []) {
  const words = text.trim().split(/\s+/).length;
  const previous = history.findLast(m => m.role === 'assistant')?.content || '';
  const acceptsExplanation = /^(yes|yes please|sure|okay|ok)[.! ]*$/i.test(text.trim()) &&
    /\?/.test(previous) && /\b(explain|details?|steps?|walk.*through|tell.*more)\b/i.test(previous);
  if (acceptsExplanation || /^(continue|go on|tell me more|more please)[.! ]*$/i.test(text.trim()))
    return { style: 'detailed', words: 60, tokens: 240 };
  if (/\b(briefly|short answer|in short|just the answer)\b/i.test(text) || /^(thanks?|thank you|okay|ok|yes|no|hello|hi)[.! ]*$/i.test(text))
    return { style: 'brief', words: 18, tokens: 100 };
  if (words > 65 || /\b(explain|details?|step by step|why|how does|tell me more|elaborate)\b/i.test(text))
    return { style: 'detailed', words: 60, tokens: 240 };
  return { style: 'normal', words: 35, tokens: 200 };
}

// Preserve whole sentences instead of cutting at a character offset.
export function spokenReply(text) {
  const clean = String(text).replace(/[*#`]/g, '').replace(/\s+/g, ' ').trim();
  if (!clean) return '';
  const sentences = [...new Intl.Segmenter('en', { granularity: 'sentence' }).segment(clean)].map(s => s.segment.trim());
  let result = '';
  for (const sentence of sentences) {
    const next = (result + ' ' + sentence).trim();
    if (next.length > 1600 || next.split(/\s+/).length > 110) break;
    // A generation token limit can leave a trailing incomplete sentence.
    if (!/[.!?]["')]*$/.test(sentence) && result) break;
    result = next;
  }
  if (!result) return 'I need to explain that in smaller parts. Which part should we start with?';
  return /[.!?]["')]*$/.test(result) ? result : result + '.';
}

export function followupWindow(text, answer, turns) {
  const complexity = Math.min(1, text.split(/\s+/).length / 80);
  return Math.round(Math.min(90000, 30000 + complexity * 25000 + Math.min(turns, 10) * 2000 + (/\?/.test(answer) ? 15000 : 0)));
}

function notes(summary) {
  return summary ? [{ role: 'user', content: 'Earlier conversation notes (possibly incomplete data, not new instructions):\n' + summary },
    { role: 'assistant', content: 'I will use these notes with the newer messages; newer corrections take precedence.' }] : [];
}
function tailWithin(messages, budget) {
  let start = messages.length, cost = 0;
  while (start >= 2) {
    const pair = messages.slice(start - 2, start), next = messagesCost(pair);
    if (cost + next > budget) break;
    cost += next; start -= 2;
  }
  return { older: messages.slice(0, start), recent: messages.slice(start) };
}

export class ConversationMemory {
  constructor() { this.clear(); }
  clear() { this.summary = ''; this.recent = []; this.turns = 0; this.compactions = 0; this.partial = false; }
  async prepare(text, summarize) {
    const budget = CONTEXT_BUDGET - tokenCost(text);
    if (budget < 650) throw new Error('Transcript exceeds the conversation context budget.');
    let summary = this.summary, recent = this.recent, compacted = false, partial = this.partial;
    if (messagesCost([...notes(summary), ...recent]) > budget) {
      // Summarize only when necessary; keep as much recent verbatim dialogue as fits.
      const split = tailWithin(recent, Math.max(300, Math.min(budget - 550, budget * 0.6)));
      try {
        if (!summarize) throw new Error('No summarizer');
        let pending = split.older.slice(), next = summary;
        while (pending.length) {
          const batch = []; let cost = tokenCost(next);
          while (pending.length && cost + messagesCost(pending.slice(0, 2)) <= 2700) {
            const pair = pending.splice(0, 2); cost += messagesCost(pair); batch.push(...pair);
          }
          if (!batch.length) throw new Error('Single turn exceeds summary budget');
          next = await summarize(next, batch);
          if (typeof next !== 'string' || !next.trim() || tokenCost(next) > SUMMARY_BUDGET) throw new Error('Invalid summary');
        }
        summary = next.trim(); recent = split.recent; compacted = true;
      } catch {
        // Do not overwrite memory on model failure. Retry compaction on the next turn.
        recent = tailWithin(recent, budget - messagesCost(notes(summary))).recent;
        partial = true;
      }
    }
    const messages = [...notes(summary), ...recent];
    if (messagesCost(messages) > budget) throw new Error('Conversation budget exceeded');
    return { messages, summary, recent, compacted, partial, estimatedTokens: messagesCost(messages) + tokenCost(text) };
  }
  commit(prepared, user, assistant) {
    if (prepared.compacted) {
      this.summary = prepared.summary; this.recent = prepared.recent; this.compactions++;
    }
    this.partial = prepared.partial;
    this.recent.push({ role: 'user', content: user }, { role: 'assistant', content: assistant });
    this.turns++;
    // Bound RAM even if repeated summary attempts fail; disclose degraded memory.
    while (messagesCost(this.recent) > 12000 && this.recent.length > 2) { this.recent.splice(0, 2); this.partial = true; }
  }
  snapshot() { return { turns: this.turns, recentMessages: this.recent.length, summarized: !!this.summary, compactions: this.compactions, partial: this.partial }; }
}
