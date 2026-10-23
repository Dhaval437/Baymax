#pragma once
#include <WiFi.h>
#include <WebServer.h>
#include <DNSServer.h>
#include <Preferences.h>
#include <ESPmDNS.h>
#include <Update.h>
#include <esp_ota_ops.h>
#include <functional>
#include "SetupPolicy.h"
#include "SetupPrivate.h"
#include "SetupPage.h"
#include "RobotSettings.h"

// Deliberately retained in app images for the phone updater's project check.
static const char BAYMAX_IMAGE_MARKER[] = "BAYMAX_PHONE_SETUP_V1";
class PhoneSetup {
  WebServer web{80}; DNSServer dns; Preferences prefs;
  std::function<void()> pauseRobot, resumeRobot;
  std::function<bool()> robotListening;
  std::function<bool()> robotBusy;
  String savedSsid, savedPass, pendingSsid, pendingPass, session, apName, message, origin;
  bool storage=false, ap=false, pending=false, joining=false, apply=false, maintenance=false;
  bool updating=false, uploadOK=false, uploadAuthorized=false, foundMarker=false;
  size_t markerPosition=0;
  uint32_t joinAt=0, offlineAt=0, retryAt=0, restartAt=0, apGraceUntil=0;
  size_t uploadBytes=0;
  static String quote(const String &s) {
    String out="\"";
    for (size_t i=0;i<s.length();++i) {
      unsigned char c=s[i];
      if (c=='"' || c=='\\') { out+='\\'; out+=char(c); }
      else if (c<32) { char escaped[7]; snprintf(escaped,sizeof(escaped),"\\u%04x",c); out+=escaped; }
      else out+=char(c);
    }
    return out+'"';
  }
  bool authenticated() { return web.authenticate("baymax", BAYMAX_SETUP_KEY); }
  void send(int code, const String &body) {
    web.sendHeader("Cache-Control","no-store");
    web.sendHeader("X-Content-Type-Options","nosniff");
    web.send(code,"application/json",body);
  }
  bool allowed(bool mutation=false) {
    if (!authenticated()) { send(401,"{\"error\":\"Enter your setup key.\"}"); return false; }
    if (mutation && web.header("X-Baymax-Session") != session) { send(403,"{\"error\":\"Unlock the page again.\"}"); return false; }
    return true;
  }
  void startAP() {
    if (ap) return;
    WiFi.mode(WIFI_AP_STA);
    if (WiFi.softAP(apName.c_str(),BAYMAX_SETUP_KEY,1,false,2)) {
      ap=true; dns.start(53,"*",WiFi.softAPIP());
    }
  }
  void join(const String &ssid,const String &pass) {
    WiFi.setAutoReconnect(false); WiFi.disconnect(false,false);
    WiFi.begin(ssid.c_str(),pass.c_str());
    // This mains-powered voice device needs prompt TCP/audio delivery.
    WiFi.setSleep(false);
    joinAt=retryAt=millis(); joining=true;
  }
  void pause() { maintenance=true; pauseRobot(); }
  void upload() {
    auto &part=web.upload();
    if (part.status==UPLOAD_FILE_START) {
      uploadAuthorized=authenticated() && web.header("X-Baymax-Session")==session;
      uploadOK=false; uploadBytes=0; foundMarker=false; markerPosition=0;
      if (!uploadAuthorized) return;
      if (joining || apply || robotBusy()) { message="Wait for the current reply or Wi-Fi change to finish before updating."; uploadAuthorized=false; return; }
      pause(); updating=true;
      // Delay begin until we validate the image header in the first data chunk.
      message="Receiving firmware. Keep power connected.";
    } else if (part.status==UPLOAD_FILE_WRITE && uploadAuthorized && updating) {
      const auto *partition=esp_ota_get_next_update_partition(nullptr);
      if (!partition || uploadBytes+part.currentSize > partition->size) {
        Update.abort(); updating=false; message="Firmware is larger than the update slot."; return;
      }
      if (!uploadBytes && (!SetupPolicy::imageHeader(part.buf,part.currentSize) || !Update.begin(UPDATE_SIZE_UNKNOWN,U_FLASH))) {
        updating=false; message="Use a Baymax ESP32-S3 application .bin file."; return;
      }
      // Search across chunk boundaries without retaining the firmware in RAM.
      for (size_t i=0;i<part.currentSize;++i) {
        if(part.buf[i]==BAYMAX_IMAGE_MARKER[markerPosition]) ++markerPosition;
        else markerPosition=part.buf[i]==BAYMAX_IMAGE_MARKER[0]?1:0;
        if(markerPosition==sizeof(BAYMAX_IMAGE_MARKER)-1) { foundMarker=true; markerPosition=0; }
      }
      if (Update.write(part.buf,part.currentSize)!=part.currentSize) {
        Update.abort(); updating=false; message="Firmware write failed. Existing firmware remains selected."; return;
      }
      uploadBytes+=part.currentSize;
    } else if (part.status==UPLOAD_FILE_END && uploadAuthorized && updating) {
      if (!foundMarker) { Update.abort(); message="This file is not a Baymax phone-setup firmware image."; }
      else if (Update.end(true)) { uploadOK=true; message="Firmware installed. Restarting Baymax."; restartAt=millis()+1500; }
      else { Update.abort(); message="Firmware validation failed. Existing firmware remains selected."; }
      updating=false;
    } else if (part.status==UPLOAD_FILE_ABORTED) {
      if (updating) Update.abort();
      updating=false; uploadOK=false; message="Upload interrupted. Retry or resume Baymax.";
    }
  }
 public:
  void begin(std::function<void()> stop,std::function<void()> resume,std::function<bool()> active,std::function<bool()> busy) {
    pauseRobot=stop; resumeRobot=resume; robotListening=active; robotBusy=busy;
    storage=prefs.begin("baymax-phone",false);
    // Credentials are stored as one blob; never partially commit an SSID/password pair.
    String credentials=storage?prefs.getString("wifi",""):"";
    int split=credentials.indexOf('\n');
    if (split>0) { savedSsid=credentials.substring(0,split); savedPass=credentials.substring(split+1); }
    else { savedSsid=WIFI_SSID; savedPass=WIFI_PASSWORD; }
    origin=storage?prefs.getString("server",""):"";
    if (!SetupPolicy::server(origin.c_str())) {
      origin=DEVICE_URL; int at=origin.indexOf("/device/"); if(at>0) origin.remove(at);
    }
    session=String(esp_random(),HEX)+String(esp_random(),HEX)+String(esp_random(),HEX)+String(esp_random(),HEX);
    uint64_t id=ESP.getEfuseMac(); char suffix[7]; snprintf(suffix,sizeof(suffix),"%06X",unsigned(id&0xffffff));
    apName=String("Baymax-Setup-")+suffix;
    WiFi.persistent(false); WiFi.setHostname("baymax"); WiFi.mode(WIFI_STA);
    apGraceUntil=millis()+180000; startAP();
    join(savedSsid,savedPass); offlineAt=millis();
    if (MDNS.begin("baymax")) MDNS.addService("http","tcp",80);
    const char *headers[]={"X-Baymax-Session"}; web.collectHeaders(headers,1);
    web.on("/",HTTP_GET,[this](){
      web.sendHeader("Cache-Control","no-store");
      web.sendHeader("Content-Security-Policy","default-src 'self'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; connect-src 'self'; img-src 'self' data:; frame-ancestors 'none'; form-action 'self'");
      web.send_P(200,"text/html",BAYMAX_SETUP_PAGE);
    });
    web.on("/api/status",HTTP_GET,[this](){
      if(!allowed()) return;
      String json="{\"session\":"+quote(session)+",\"connected\":"+(WiFi.status()==WL_CONNECTED?"true":"false")+
        ",\"ssid\":"+quote(WiFi.SSID())+",\"ip\":"+quote(WiFi.localIP().toString())+",\"setupNetwork\":"+quote(apName)+
        ",\"server\":"+quote(origin)+",\"joining\":"+(joining?"true":"false")+",\"listening\":"+(robotListening()?"true":"false")+
        ",\"message\":"+quote(message)+",\"storage\":"+(storage?"true":"false")+",\"version\":"+quote(BAYMAX_IMAGE_MARKER)+
        ",\"firmwareRevision\":\"2026-10-20-noise-v16\",\"rssi\":"+String(WiFi.RSSI())+",\"sketchMd5\":"+quote(ESP.getSketchMD5())+
        ",\"voicePeak\":"+String(BAYMAX_VOICE_PEAK)+",\"gestureMs\":"+String(GESTURE_DURATION_MS)+"}";
      send(200,json);
    });
    web.on("/api/wifi",HTTP_POST,[this](){
      if(!allowed(true)) return;
      if(!storage) { send(503,"{\"error\":\"Settings storage unavailable. Nothing changed.\"}"); return; }
      if(pending || apply || updating || robotBusy()) { send(409,"{\"error\":\"Wait for the current reply or setup change to finish, or pause Baymax first.\"}"); return; }
      String ssid=web.arg("ssid"), pass=web.arg("password");
      if(!SetupPolicy::wifi(ssid.c_str(),pass.c_str()) || ssid.indexOf('\n')>=0) { send(400,"{\"error\":\"Enter a 1–32 byte Wi-Fi name and valid password (8–63 characters, or blank for an open network).\"}"); return; }
      pendingSsid=ssid; pendingPass=pass; pending=true; apply=true;
      pause(); startAP(); message="Connecting. The phone may need to rejoin the Baymax setup network.";
      send(202,"{\"message\":\"Trying the new network. Keep this page open; reconnect to Baymax setup if needed.\"}");
    });
    web.on("/api/server",HTTP_POST,[this](){
      if(!allowed(true)) return;
      if(robotBusy()) { send(409,"{\"error\":\"Pause Baymax or wait for the current reply before changing its server.\"}"); return; }
      String value=web.arg("server"); value.trim();
      if(!SetupPolicy::server(value.c_str())) { send(400,"{\"error\":\"Use the private laptop address shown by Start-Baymax, for example http://192.168.1.20:8788\"}"); return; }
      if(!storage || prefs.putString("server",value)!=value.length()) { send(503,"{\"error\":\"Could not save the server address.\"}"); return; }
      pause(); origin=value; message="Laptop address saved. Start the laptop server, then tap Resume Baymax.";
      send(200,"{\"message\":\"Laptop address saved.\"}");
    });
    web.on("/api/control",HTTP_POST,[this](){
      if(!allowed(true)) return;
      if(web.arg("action")=="pause") { pause(); message="Baymax paused. Motor outputs and listening are off."; }
      else if(web.arg("action")=="resume" && !robotBusy() && !joining && !apply && !updating && !restartAt && WiFi.status()==WL_CONNECTED) {
        maintenance=false; resumeRobot(); message="Baymax resumed. Say Baymax or ouch when the laptop server is running.";
      } else { send(409,"{\"error\":\"Connect Wi-Fi and finish setup before resuming.\"}"); return; }
      send(200,"{\"message\":"+quote(message)+"}");
    });
    web.on("/api/update",HTTP_POST,[this](){
      if(!allowed(true)) return;
      send(uploadOK?200:400,"{\"message\":"+quote(message)+"}");
    },[this](){upload();});
    web.onNotFound([this](){web.sendHeader("Location","/"); web.send(302,"text/plain","");});
    web.begin();
  }
  String serverBase() const { return origin+"/device"; }
  void tick() {
    web.handleClient(); if(ap) dns.processNextRequest();
    if(restartAt && int32_t(millis()-restartAt)>=0) ESP.restart();
    if(apply) { apply=false; join(pendingSsid,pendingPass); }
    if(WiFi.status()==WL_CONNECTED) {
      offlineAt=0;
      if(joining && millis()-joinAt>=500 && (!pending || WiFi.SSID()==pendingSsid)) {
        joining=false;
        if(pending) {
          String record=pendingSsid+'\n'+pendingPass;
          if(prefs.putString("wifi",record)==record.length()) { savedSsid=pendingSsid; savedPass=pendingPass; message="Wi-Fi connected and saved. Check the laptop address, then Resume Baymax."; }
          else { message="Connected, but saving failed. Previous Wi-Fi is retained for reboot."; }
          pendingPass=""; pendingSsid=""; pending=false;
        }
      }
      // Close the setup hotspot once no phone is using it and the robot is resumed.
      if(ap && !maintenance && int32_t(millis()-apGraceUntil)>=0 && !WiFi.softAPgetStationNum()) { dns.stop(); WiFi.softAPdisconnect(true); WiFi.mode(WIFI_STA); ap=false; }
    } else {
      if(!offlineAt) offlineAt=millis();
      if(millis()-offlineAt>=20000) startAP();
      if(joining && millis()-joinAt>=25000) {
        joining=false;
        if(pending) {
          pending=false; pendingPass=""; pendingSsid="";
          message="Could not connect. Check the password and 2.4 GHz network. Previous settings are retained.";
          startAP(); join(savedSsid,savedPass);
        }
      }
      if(!joining && millis()-retryAt>=30000) join(savedSsid,savedPass);
    }
  }
};
