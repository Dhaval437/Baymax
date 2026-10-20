// Fixed, bounded gestures only; model text can never supply raw servo positions.
export function conversationGesture(heard, answer, end = false) {
  if (end) return 'farewell';
  const text = `${heard} ${answer}`.toLowerCase();
  if (/\b(pain|hurt|ouch|sad|worried|burn|bleeding|emergency)\b/.test(text)) return 'gentle';
  if (/\b(hello|hi|welcome|joke|laugh)\b/.test(text)) return 'greeting';
  if (/\b(yes|okay|understand|thank)\b/.test(text) && answer.length < 140) return 'acknowledge';
  return 'explain';
}
