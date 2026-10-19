#include "../firmware/MiniBaymax/SetupPolicy.h"
#include <cassert>
#include <iostream>
int main(){
 using namespace SetupPolicy;
 assert(wifi("Home","password123")); assert(wifi("Open",""));
 assert(wifi("Hidden",std::string(64,'a'))); assert(!wifi("Hidden",std::string(64,'x')));
 assert(!wifi("","password123")); assert(!wifi(std::string(33,'x'),"password123"));
 assert(!wifi("Home","short")); assert(!wifi("Home",std::string("abc\0defgh",9)));
 for(auto u:{"http://192.168.1.2:8788","http://10.0.0.2:80","http://172.31.0.2:8788"}) assert(server(u));
 for(auto u:{"http://8.8.8.8:80","http://127.0.0.1:8788","https://192.168.1.2:8788","http://192.168.1.2:0","http://192.168.1.2:65536","http://192.168.999.2:8788","http://192.168.1.2:8788/device","http://user@192.168.1.2:8788","http://192.168.1.2:8788?x=1","http://192.168.01.2:8788","http://host.local:8788"}) assert(!server(u));
 uint8_t h[24]={}; assert(!imageHeader(h,24));h[0]=0xe9;h[12]=9;assert(imageHeader(h,24));assert(!imageHeader(h,13));h[12]=0;assert(!imageHeader(h,24));
 std::cout<<"PASS: Wi-Fi, private endpoint and S3 image validation\n";
}
