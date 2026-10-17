#pragma once
#include <cstdint>
#include <cstdlib>
#include <algorithm>
using std::min;
using std::max;
inline uint32_t testClock = 0;
inline uint32_t millis() { return testClock; }
inline void delay(uint32_t n) { testClock += n; }
template<class T> T constrain(T value, T low, T high) { return min(high, max(low, value)); }
