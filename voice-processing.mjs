// Keep the voice's pitch intact. Reduce upper-mid harshness and sibilance,
// then control loud syllables without raising quiet synthesis noise.
export const SMOOTH_VOICE_FILTER = [
  'highpass=f=65',
  'equalizer=f=2800:t=q:w=0.8:g=-3.5',
  'highshelf=f=3800:g=-5',
  'deesser=i=0.25:m=0.35:f=0.5',
  'lowpass=f=5400',
  'acompressor=threshold=0.125:ratio=1.6:attack=15:release=180:makeup=1:knee=4',
  'loudnorm=I=-23:TP=-5:LRA=7',
  'afade=t=in:st=0:d=0.025',
].join(',');
