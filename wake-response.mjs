export const WAKE_REPLY = 'Hello. I am Baymax, your personal healthcare companion. I heard you. Are you okay?';
export const CARE_END_REPLY = 'I am glad I could help. I will be here when you need me. Say Baymax to wake me again.';
export function normalizeRobotTranscript(text) {
  let normalized = String(text).trim()
    .replace(/\bb[\s.-]*a[\s.-]*y[\s.-]*m[\s.-]*a[\s.-]*x\b/gi, 'Baymax')
    .replace(/\bb[\s.-]*e[\s.-]*m[\s.-]*a[\s.-]*x\b/gi, 'Baymax')
    .replace(/\b(?:bay|be|b[\s.-]+e)[\s.-]+max\b/gi, 'Baymax')
    .replace(/\b(?:bemax|baymaks)\b/gi, 'Baymax');
  // Accept the reported shortened wake name only as a direct address.
  if (/^(?:(?:hey|hello|hi)[ ,]+)?max[.!?\s]*$/i.test(normalized))
    normalized = normalized.replace(/\bmax\b/i, 'Baymax');
  // Reported name confusion, only at the start of a direct address.
  normalized = normalized.replace(/^(?:(hey|hello|hi)[ ,]+)?p[\s.-]*max\b/i,
    (_, greeting) => `${greeting ? greeting + ' ' : ''}Baymax`);
  return normalized;
}
export function isStatusRequest(text) {
  return /^(?:(?:hey|please)[ ,.!?]*)?(?:baymax[ ,.!?]*)?(?:please[ ,.!?]*)?(?:checks?|tell me|what is|what's|give me)(?: the| your| robot)? status(?: please)?[.!?\s]*$/i.test(text.trim()) ||
    /^(?:baymax[ ,.!?]*)?status[.!?\s]*$/i.test(text.trim());
}
export function isDistressCue(text) {
  return /^(?:(?:baymax|hey)[ ,.!?]*)?(?:ouch|ow+|ah+|a{3,})[.!?\s]*$/i.test(String(text).trim());
}

export function isCareComplete(text) {
  const words = String(text).toLowerCase().replace(/[\u2018\u2019]/g, "'").replace(/[.,!?]/g, ' ').replace(/\s+/g, ' ').trim();
  return /^(?:(?:okay|ok|yes) )?(?:baymax )?(?:i am|i'm|im) satisfied with (?:my|your|the) care(?: (?:baymax|thank you|thanks)){0,2}$/.test(words);
}

// Whole words only: "couch" and "about" must not wake the robot.
// Ah/ow are ambiguous, so only accept them in very short utterances.
export function isWakePhrase(text) {
  const words = String(text).toLowerCase().match(/[a-z]+/g) || [];
  return words.includes('ouch') || words.includes('baymax') ||
    (words.length <= 3 && words.some(word => /^(?:o+w+|a+h+|a{3,})$/.test(word)));
}

export function isGoodbye(text) {
  return isCareComplete(text) || /^(?:goodbye|bye(?: bye)?|stop|go to sleep|that(?:'s| is) all|thank you baymax)[.!?\s]*$/i.test(String(text).trim());
}
