const { chromium } = require('C:/Users/dhruv/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/playwright');
(async()=>{
  const browser=await chromium.launch({channel:'chrome',headless:true});
  try {
    const page=await browser.newPage({viewport:{width:1280,height:1000}}), errors=[];
    page.on('pageerror',error=>errors.push(error.message));
    await page.goto('http://127.0.0.1:8793/');
    await page.waitForFunction(()=>document.getElementById('usb').textContent.includes('ESP32 connected'));
    await page.waitForFunction(()=>document.getElementById('signal').getAttribute('d').includes('L'));
    await page.screenshot({path:'assembly/verification/dashboard-desktop.png',fullPage:true});
    console.log(JSON.stringify(await page.evaluate(()=>({title:document.title,status:document.getElementById('usb').textContent,phase:document.getElementById('phase').textContent,graphPresent:!!document.getElementById('signal').getAttribute('d'),overflow:document.documentElement.scrollWidth>innerWidth}))))
    await page.setViewportSize({width:390,height:844});
    await page.screenshot({path:'assembly/verification/dashboard-mobile.png',fullPage:true});
    if(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth))throw Error('Mobile overflow');
    if(errors.length)throw Error(errors.join('\n'));
    console.log('PASS: actual live graph, desktop/mobile layout, no JavaScript errors.');
  } finally {await browser.close()}
})().catch(error=>{console.error(error.message);process.exitCode=1});
