export const WAKE_REPLY = 'Hello. I am Baymax, your personal healthcare companion. I heard you. Are you okay?';

// Whole words only: "couch" and "about" must not wake the robot.
// Ah/ow are ambiguous, so only accept them in very short utterances.
export function isWakePhrase(text) {
  const words = String(text).toLowerCase().match(/[a-z]+/g) || [];
  return words.includes('ouch') || words.includes('baymax') ||
    (words.length <= 3 && words.some(word => /^(?:o+w+|a+h+|a{3,})$/.test(word)));
}

export function isGoodbye(text) {
  return /^(?:goodbye|bye(?: bye)?|stop|go to sleep|that(?:'s| is) all|thank you baymax)[.!?\s]*$/i.test(String(text).trim());
}
