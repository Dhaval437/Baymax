#include <cassert>
#include <cstdio>
#include "../firmware/MiniBaymax/ListeningPolicy.h"
int main() {
  ListeningPolicy shortTurn, longTurn;
  shortTurn.begin(true); shortTurn.observe(true, 500);
  longTurn.begin(true); longTurn.observe(true, 15000);
  assert(longTurn.pauseMs() > shortTurn.pauseMs());
  shortTurn.observe(false, 900); assert(!shortTurn.finished());
  shortTurn.observe(false, 200); assert(shortTurn.finished());
  longTurn.observe(false, 1400); assert(!longTurn.finished());
  longTurn.observe(true, 200); // hesitation is inside this utterance
  assert(longTurn.pauseMs() >= 1800);
  longTurn.observe(false, 1700); assert(!longTurn.finished());
  longTurn.observe(false, 400); assert(longTurn.finished());
  longTurn.begin(false); assert(!longTurn.finished()); assert(longTurn.pauseMs() == 500);
  longTurn.observe(true, 60000); assert(longTurn.pauseMs() == 2000);
  puts("PASS: adaptive speech pauses, hesitation, upper bound and reset");
}
