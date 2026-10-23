#include <cassert>
#include <cstdio>
#include "../firmware/MiniBaymax/NoiseFloor.h"
int main() {
  NoiseFloor noise;
  noise.reset(250);
  assert(noise.threshold(450) == 625); // same gate before and after conversation expires
  assert(700 > noise.threshold(450));
  noise.reset(400);
  // Quiet room interrupted by sub-threshold bursts: no upwards feedback.
  for (int n = 0; n < 125 * 300; ++n)
    noise.observe(n % 5 < 2 ? 150 : 1100, true);
  assert(noise.value() == 150);
  // The minimum trigger remains450; a quiet700RMS wake word remains detectable.
  assert(noise.threshold(450) == 450);
  assert(700 > noise.threshold(450));
  noise.reset(800);
  for (int n = 0; n < 125; ++n) noise.observe(150, true);
  assert(noise.value() == 150);
  // A stationary louder room adjusts slowly and stays bounded even over hours.
  noise.reset(400);
  for (int n = 0; n < 125; ++n) noise.observe(2000, true);
  assert(noise.value() == 420);
  for (int n = 0; n < 125 * 3600; ++n) noise.observe(2000, true);
  assert(noise.value() <= 800);
  const float before = noise.value();
  for (int n = 0; n < 1000; ++n) noise.observe(20, false);
  assert(noise.value() == before);
  // No incomplete window carried across speech or motor activity.
  for (int n = 0; n < 124; ++n) noise.observe(150, true);
  noise.observe(3000, false);
  noise.observe(150, true);
  assert(noise.value() == before);
  puts("PASS: long idle noise drift, quiet-room recovery, bounded rise, capture/motor exclusion");
}
