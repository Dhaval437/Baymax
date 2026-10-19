#pragma once
#include <string>
#include <cstdio>
#include <cstdint>
namespace SetupPolicy {
inline bool wifi(const std::string &ssid, const std::string &password) {
  if (ssid.empty() || ssid.size() > 32 || ssid.find('\0') != std::string::npos || password.find('\0') != std::string::npos) return false;
  if (password.empty()) return true; // Open networks without a captive login.
  if (password.size() >= 8 && password.size() <= 63) return true;
  if (password.size() != 64) return false;
  return password.find_first_not_of("0123456789abcdefABCDEF") == std::string::npos;
}
// Keep the shared device token on a directly connected private IPv4 network.
// No credentials, paths, query strings, DNS rebinding or public destinations.
inline bool server(const std::string &url) {
  unsigned a,b,c,d,port; int used=0;
  if (std::sscanf(url.c_str(), "http://%u.%u.%u.%u:%u%n", &a,&b,&c,&d,&port,&used) != 5 || used != int(url.size())) return false;
  if (a>255 || b>255 || c>255 || d>255 || !port || port>65535) return false;
  char canonical[64]; std::snprintf(canonical,sizeof(canonical),"http://%u.%u.%u.%u:%u",a,b,c,d,port);
  if (url != canonical) return false;
  return a==10 || (a==172 && b>=16 && b<=31) || (a==192 && b==168);
}
inline bool imageHeader(const uint8_t *data, size_t size) {
  return size >= 24 && data[0] == 0xE9 && data[12] == 9 && data[13] == 0;
}
}
