// Bounded, source-backed general guidance. Never ask the small model to invent treatment.
// Reviewed against the linked public guidance on 2026-10-19; not clinical triage.
export const CARE_GUIDES = [
  {id:'cut', match:/\b(paper ?cuts?|(?:skin|finger|small|minor) cuts?|(?:have|got) (?:a )?cut|cut my (?:finger|hand|skin)|grazes?|scrapes?|wounds?)\b/i,
    source:'https://www.nhs.uk/conditions/cuts-and-grazes/',
    answer:'For a small skin cut, wash your hands. If it is bleeding, apply pressure with a clean cloth. Once bleeding stops, rinse the wound with clean water and cover it with a sterile dressing or plaster. Get medical help for a deep or dirty wound, an animal bite, increasing redness, swelling or pus. Get urgent help if bleeding will not stop or something is stuck in the wound.'},
  {id:'burn', match:/\b(burns?|burned|burnt|scalds?|scalded)\b/i,
    source:'https://www.nhs.uk/conditions/burns-and-scalds/',
    answer:'For a small heat burn, cool it under cool running water for 20 minutes. Remove nearby jewellery or clothing only if it is not stuck. Once cooled, lay cling film loosely over it, without wrapping it around the area. Do not apply butter, oils or creams, or burst blisters. Large, deep, facial, chemical or electrical burns need urgent medical care. If unsure, seek medical advice.'},
  {id:'cold', match:/\b(common cold|have a cold|got a cold|runny nose|blocked nose|sneezing)\b/i,
    source:'https://www.nhs.uk/conditions/common-cold/',
    answer:'For a common cold, rest, drink fluids and eat as you feel able. Wash your hands and use tissues to reduce spreading it. Antibiotics do not treat cold viruses. Ask a pharmacist before choosing cold medicines, especially for a child or someone taking other medicines. Seek medical advice if symptoms worsen, do not improve after ten days, or include chest pain or shortness of breath.'},
  {id:'headache', match:/\b(headaches?|head (?:hurts|aches))\b/i,
    source:'https://www.nhs.uk/symptoms/headaches/',
    answer:'For an ordinary mild headache, drink water, avoid skipping meals, relax and take a break from prolonged screen use. Seek medical advice if headaches keep returning, worsen or do not improve. A sudden extremely painful headache, or one with weakness, confusion, vision loss, a stiff neck or a recent head injury, needs urgent medical assessment.'},
  {id:'hydration', match:/\b(dehydrat\w*|hydration|thirsty|drink water)\b/i,
    source:'https://www.nhs.uk/conditions/dehydration/',
    answer:'Dehydration means losing more fluid than you take in. Drink fluids regularly; if you feel sick, try small sips. A pharmacist can advise on oral rehydration solution for fluid lost through vomiting or diarrhoea. Persistent dizziness, much less urine or unusual drowsiness need urgent medical advice. Babies and older people need extra care. Confusion or difficulty breathing needs emergency help.'}
];
const medicalTerms=/\b(medical|health|symptoms?|diagnos\w*|illness|disease|sick|unwell|fever|pain|hurts?|aches?|bleed\w*|vomit\w*|diarrh\w*|rash|allerg\w*|asthma|diabet\w*|cancer|infection|infected|pregnan\w*|blood pressure|blood sugar|heart|stroke|seizure|medicine|medication|prescription|tablets?|pills?|dose|dosage|insulin|antibiotic\w*|paracetamol|ibuprofen|metformin|treatment|remed\w*)\b/i;
const medication=/\b(medicine|medication|prescription|tablets?|pills?|dosage|dose|insulin|antibiotic\w*|paracetamol|ibuprofen|metformin)\b/i;
const emergency=/\b(chest pain|(?:cannot|can't|cant|struggling to|trouble|difficulty) breath\w*|shortness of breath|unconscious|unresponsive|seizure|overdose|poison\w*|(?:cannot|can't|won't|will not) stop (?:the )?bleeding|bleeding (?:will not|won't) stop|(?:sudden|worst|extremely painful).{0,25}headache)\b/i;
const jokeRequest=/\b(tell|give|make|say|share)\b.{0,45}\bjokes?\b|\bmake me laugh\b|\bsomething funny\b/i;
const laughRequest=/\b(laugh|chuckle)\b/i;
const jokes=[
  'Why did the robot go on holiday? It needed to recharge its batteries.',
  'Why was the robot good at gardening? It had a green circuit board.',
  'What is a robot’s favourite snack? Computer chips.'
];
export function companionReply(text, history=[], random=Math.random) {
  const current=String(text).trim();
  // Recognized urgent phrases take precedence over a request for a joke.
  // Conditional wording avoids treating a quoted or negated phrase as a diagnosis.
  if(emergency.test(current)) return 'If those symptoms are happening now, get emergency medical help immediately. Call your local emergency service or ask someone nearby to help. I cannot assess an emergency, and you should not wait for this toy to decide whether it is serious.';
  if(jokeRequest.test(current)) return jokes[Math.min(jokes.length-1, Math.floor(random()*jokes.length))];
  if(laughRequest.test(current)) return 'Ha ha. My happiness circuits are having a good day.';
  const previous=history.findLast(m=>m.role==='user')?.content || '';
  const followup=/^(it\b|that\b|this\b|yes\b|no\b|what about\b|how long\b|can i\b|should i\b|is it\b|and\b|also\b|\d)/i.test(current);
  const context=followup && (medicalTerms.test(previous)||CARE_GUIDES.some(g=>g.match.test(previous))) ? previous+'\n'+current : current;
  if(medication.test(current)) return 'For a medicine choice, dose or change to prescribed treatment, please check with your prescriber or pharmacist. The right advice depends on the person and the exact medicine. I can help with basic care information, but I will not guess a dose.';
  // Do not label a complex or worsening presentation as a minor condition.
  if((medicalTerms.test(context)||CARE_GUIDES.some(g=>g.match.test(context))) && /\b(wors\w*|severe|deep|chemical|electrical|baby|infant|newborn|pregnan\w*|confused|vision loss|stiff neck|numbness|weakness|head injury)\b/i.test(context))
    return 'That needs advice from a healthcare professional rather than a guess from me. Please seek prompt medical assessment. If symptoms are severe, sudden or rapidly worsening, get urgent help now. How long has this been happening?';
  const guides=CARE_GUIDES.filter(g=>g.match.test(context));
  if(guides.length===1) return guides[0].answer;
  if(medicalTerms.test(context)||guides.length>1) return 'I can share basic guidance about small cuts, minor heat burns, colds, mild headaches and hydration. For this particular concern, a healthcare professional can give advice suited to you. What symptoms are you noticing, and how long have they been present?';
  return null;
}
