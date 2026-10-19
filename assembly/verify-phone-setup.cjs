// Browser integration tests with an explicitly mocked ESP32; never talks to hardware.
const {chromium}=require('C:/Users/dhruv/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
const fs=require('node:fs/promises'),http=require('node:http'),assert=require('node:assert/strict');
(async()=>{
 const html=await fs.readFile('public/phone-setup.html','utf8');
 const local=http.createServer((req,res)=>{res.setHeader('Content-Type','text/html');res.end(html)});
 await new Promise(r=>local.listen(0,'127.0.0.1',r));
 const browser=await chromium.launch({channel:'chrome',headless:true});
 try{
  const page=await browser.newPage({viewport:{width:390,height:844}}),errors=[],calls=[];
  page.on('pageerror',e=>errors.push(e.message));
  const base='http://127.0.0.1:'+local.address().port;
  await page.route('**/api/**',async route=>{
   const req=route.request(),path=new URL(req.url()).pathname;
   calls.push({path,method:req.method(),body:req.postData()});
   assert.equal(req.headers().authorization,'Basic '+Buffer.from('baymax:test-only-key').toString('base64'));
   if(req.method()==='POST')assert.equal(req.headers()['x-baymax-session'],'test-session');
   let result={message:'Test command accepted'};
   if(path==='/api/status')result={session:'test-session',connected:true,ssid:'Test Wi-Fi',ip:'192.168.1.44',setupNetwork:'Baymax-Setup-TEST',server:'http://192.168.1.20:8788',joining:false,listening:false,storage:true,message:'Mock device — browser test only'};
   if(path==='/api/server')return route.fulfill({status:400,contentType:'application/json',body:JSON.stringify({error:'Use the private laptop address.'})});
   await route.fulfill({status:200,contentType:'application/json',body:JSON.stringify(result)});
  });
  await page.goto(base);await page.locator('#key').fill('test-only-key');await page.getByRole('button',{name:'Unlock Baymax'}).click();
  await page.waitForFunction(()=>!document.getElementById('app').hidden);
  assert.equal(await page.locator('#key').inputValue(),'');
  await page.locator('#ssid').fill('New Wi-Fi');await page.locator('#password').fill('bad');await page.getByRole('button',{name:'Connect & save'}).click();
  assert.match(await page.locator('#notice').textContent(),/8–63/);assert.equal(calls.filter(c=>c.path==='/api/wifi').length,0);
  await page.locator('#password').fill('test-wifi-password');await page.getByRole('button',{name:'Connect & save'}).click();
  await page.waitForFunction(()=>document.getElementById('notice').textContent.includes('Test command'));
  assert.equal(await page.locator('#password').inputValue(),'');
  assert.equal(new URLSearchParams(calls.find(c=>c.path==='/api/wifi').body).get('password'),'test-wifi-password');
  await page.getByRole('button',{name:'Save laptop address'}).click();await page.waitForFunction(()=>document.getElementById('notice').textContent.includes('private laptop'));
  await page.getByRole('button',{name:'Pause Baymax',exact:true}).click();await page.waitForFunction(()=>document.getElementById('notice').textContent.includes('Test command'));
  assert.ok(calls.some(c=>c.path==='/api/control'&&c.body==='action=pause'));
  await page.locator('summary').click();await page.locator('#firmware').setInputFiles({name:'wrong.txt',mimeType:'text/plain',buffer:Buffer.alloc(32)});await page.locator('#confirmUpdate').check();await page.getByRole('button',{name:'Install update'}).click();
  assert.match(await page.locator('#notice').textContent(),/application .bin/);assert.equal(calls.filter(c=>c.path==='/api/update').length,0);
  await page.locator('#firmware').setInputFiles({name:'test.bin',mimeType:'application/octet-stream',buffer:Buffer.alloc(64)});await page.getByRole('button',{name:'Install update'}).click();
  await page.waitForFunction(()=>document.getElementById('uploadStatus').textContent.includes('Waiting for Baymax'));
  assert.ok(calls.some(c=>c.path==='/api/update'));
  assert.deepEqual(await page.evaluate(()=>[localStorage.length,sessionStorage.length]),[0,0]);
  await page.getByRole('button',{name:'Lock setup page'}).click();assert.equal(await page.locator('#app').isVisible(),false);
  await page.goto(base+'/?preview=1');
  await fs.mkdir('assembly/verification',{recursive:true});
  assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
  await page.screenshot({path:'assembly/verification/phone-setup-mobile.png',fullPage:true});
  await page.setViewportSize({width:1280,height:900});await page.screenshot({path:'assembly/verification/phone-setup-desktop.png',fullPage:true});
  assert.equal(errors.length,0,errors.join('\n'));
  await fs.writeFile('assembly/verification/phone-setup-browser.json',JSON.stringify({passed:true,mode:'mock ESP32, no hardware',checks:['unlock','invalid Wi-Fi password','Wi-Fi submit and clear password','server error','pause','invalid firmware rejected','authenticated upload','no persistent browser secrets','lock','390px no overflow','desktop/mobile screenshots','no JS errors']},null,2));
  console.log('PASS: phone setup browser flow, error paths, authenticated upload and responsive layout (mock device).');
 }finally{await browser.close();await new Promise(r=>local.close(r))}
})().catch(e=>{console.error(e);process.exitCode=1});
