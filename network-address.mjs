import { isIP } from 'node:net';
export function privateIPv4(value) {
  if(isIP(value)!==4)return false;
  const [a,b]=value.split('.').map(Number);
  return a===10||(a===172&&b>=16&&b<=31)||(a===192&&b===168);
}
export function chooseRobotAddress(interfaces,{override='',previous=''}={}) {
  const candidates=Object.entries(interfaces).flatMap(([name,entries])=>(entries||[])
    .filter(e=>!e.internal&&e.family==='IPv4'&&privateIPv4(e.address)).map(e=>({name,address:e.address})));
  if(override){if(!candidates.some(e=>e.address===override))throw Error('BAYMAX_BIND_ADDRESS must be a current private IPv4 address on this laptop.');return override;}
  const previousMatch=candidates.find(e=>e.address===previous);
  if(previousMatch)return previousMatch.address;
  const physical=candidates.filter(e=>!/(virtual|vethernet|vmware|vpn|wsl|docker|loopback|tailscale|zerotier)/i.test(e.name));
  const wifi=physical.find(e=>/(wi.?fi|wireless|wlan)/i.test(e.name));
  if(wifi)return wifi.address;
  if(physical.length===1)return physical[0].address;
  if(!physical.length&&candidates.length===1)return candidates[0].address;
  throw Error('Choose the laptop Wi-Fi address with BAYMAX_BIND_ADDRESS; multiple or no usable private networks were found.');
}
