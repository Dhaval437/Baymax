#include <cassert>
#include <cstdio>
#include "../firmware/MiniBaymax/ListeningPolicy.h"
int main() {
  ListeningPolicy shortTurn, longTurn;
  shortTurn.begin(true); shortTurn.observe(true, 500);
  longTurn.begin(true); longTurn.observe(true, 15000);
  assert(longTurn.pauseMs() > shortTurn.pauseMs());
  assert(shortTurn.pauseMs() == 1241);
  shortTurn.observe(false, 600); assert(!shortTurn.finished());
  shortTurn.observe(false, 400); assert(!shortTurn.finished());
  shortTurn.observe(true, 300); // resumed after a natural one-second mid-sentence pause
  assert(shortTurn.pauseMs() >= 1600);
  shortTurn.observe(false, 1500); assert(!shortTurn.finished());
  shortTurn.observe(false, 200); assert(shortTurn.finished());
  longTurn.observe(false, 1300); assert(!longTurn.finished());
  longTurn.observe(true, 200); // hesitation is inside this utterance
  assert(longTurn.pauseMs() >= 1700);
  longTurn.observe(false, 1600); assert(!longTurn.finished());
  longTurn.observe(false, 1000); assert(longTurn.finished());
  longTurn.begin(false); assert(!longTurn.finished()); assert(longTurn.pauseMs() == 700);
  longTurn.observe(true, 60000); assert(longTurn.pauseMs() == 2600);
  puts("PASS: adaptive speech pauses, hesitation, upper bound and reset");
}
