#include <cassert>
#include <cstdio>
#include "../firmware/MiniBaymax/SpeechOnset.h"
#include "../firmware/MiniBaymax/ListeningPolicy.h"
int main() {
  SpeechOnset onset;
  for (int i = 0; i < 10000; ++i) {
    assert(!onset.observe(true, 16));
    assert(!onset.observe(false, 16));
  }
  assert(!onset.observe(true, 16));
  assert(!onset.observe(true, 16));
  assert(onset.observe(true, 16));
  onset.reset();
  assert(!onset.observe(true, 16));
  assert(!onset.observe(false, 16));
  assert(!onset.observe(true, 32));
  assert(onset.observe(true, 16));
  onset.reset();
  ListeningPolicy endpoint;
  endpoint.begin(true);
  for (int i = 0; i < 40; ++i) endpoint.observe(onset.observe(true, 16), 16);
  int elapsed = 0;
  while (!endpoint.finished() && elapsed < 3000) {
    endpoint.observe(onset.observe(elapsed % 400 < 16, 16), 16);
    elapsed += 16;
  }
  assert(endpoint.finished() && elapsed < 2000); // repeated clicks cannot hold capture open
  puts("PASS: isolated spikes rejected; sustained speech accepted at48ms; reset clears onset");
}
