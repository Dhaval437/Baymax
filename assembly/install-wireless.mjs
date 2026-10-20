// Explicit local deployment helper. Credentials never go to stdout or reports.
import {readFile, writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {privateIPv4} from '../network-address.mjs';
const root=new URL('../',import.meta.url);
const ip=process.argv[2];
if(!privateIPv4(ip)) throw Error('Supply the verified private IPv4 address of Baymax.');
const secret=await readFile(new URL('firmware/MiniBaymax/SetupPrivate.h',root),'utf8');
const key=secret.match(/^#define BAYMAX_SETUP_KEY "([a-f0-9]{24})"/m)?.[1];
if(!key) throw Error('Private setup key unavailable.');
const binary=await readFile(new URL('output/phone-setup/Baymax-ESP32S3-application.bin',root));
if(binary.length<24 || binary.length>3145728 || binary[0]!==0xe9 || binary[12]!==9 || binary[13]!==0 || !binary.includes(Buffer.from('BAYMAX_PHONE_SETUP_V1'))) throw Error('Invalid Baymax application image.');
const sha256=createHash('sha256').update(binary).digest('hex').toUpperCase();
const md5=createHash('md5').update(binary).digest('hex');
const buildPath=new URL('assembly/verification/integrated-build.json',root);
const build=JSON.parse((await readFile(buildPath,'utf8')).replace(/^\uFEFF/,''));
if(build.sha256!==sha256) throw Error('Image differs from the recorded build. Rebuild first.');
const auth='Basic '+Buffer.from('baymax:'+key).toString('base64');
const base='http://'+ip;
async function request(path, options={}) {
  const response=await fetch(base+path,{...options,headers:{Authorization:auth,...options.headers},redirect:'error',signal:AbortSignal.timeout(90000)});
  const data=await response.json();
  if(!response.ok) throw Error('Robot rejected '+path+' (HTTP '+response.status+'). Inspect the phone setup page.');
  return data;
}
const before=await request('/api/status');
if(!before.connected || !before.session || before.joining) throw Error('Robot must be connected and not changing Wi-Fi.');
const headers={'X-Baymax-Session':before.session};
await request('/api/control',{method:'POST',headers,body:new URLSearchParams({action:'pause'})});
console.log('Robot paused for wireless installation.');
await new Promise(resolve=>setTimeout(resolve,3500));
const body=new FormData();body.append('firmware',new Blob([binary],{type:'application/octet-stream'}),'Baymax-ESP32S3-application.bin');
try {
  await request('/api/update',{method:'POST',headers,body});
  console.log('Wireless image accepted. Waiting for reboot and automatic listening.');
} catch {
  // A reboot can close the upload response. Never equate that with success:
  // require the running firmware's fingerprint to match the local image.
  console.log('Upload response unavailable. Checking the running image fingerprint.');
}
let after;
for(let attempt=0;attempt<25;attempt++) {
  await new Promise(resolve=>setTimeout(resolve,2000));
  try {
    const response=await fetch(base+'/api/status',{headers:{Authorization:auth},redirect:'error',signal:AbortSignal.timeout(3000)});
    if(!response.ok)continue;
    const state=await response.json();
    if(state.session!==before.session && state.sketchMd5===md5 && state.connected && state.listening) {after=state;break;}
  } catch {}
}
if(!after) throw Error('Installed image fingerprint/reboot/listening not confirmed. Check the phone page before retrying.');
Object.assign(build,{uploaded:true,uploadMethod:'authenticated Wi-Fi OTA',uploadedAt:new Date().toISOString(),robotIp:ip});
await writeFile(buildPath,JSON.stringify(build,null,2)+'\n');
const report={checkedAt:build.uploadedAt,sha256,md5,bytes:binary.length,uploadMethod:build.uploadMethod,runningImageMatches:true,firmwareRevision:after.firmwareRevision,voicePeak:after.voicePeak,gestureMs:after.gestureMs,rebootConfirmed:true,wifiConnected:after.connected,listening:after.listening,physicalMotionObserved:false,audioQualityVerified:false};
await writeFile(new URL('assembly/verification/smooth-motion-release.json',root),JSON.stringify(report,null,2)+'\n');
console.log('PASS: Wi-Fi update, reboot and automatic listening confirmed. SHA256 '+sha256);
