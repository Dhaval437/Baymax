import http from 'node:http';
import {readFile} from 'node:fs/promises';
// Design only. No device endpoints, Wi-Fi changes or hardware activation.
http.createServer(async(req,res)=>{
 if(req.url!=='/?preview=1'){res.writeHead(302,{Location:'/?preview=1'});res.end();return;}
 res.writeHead(200,{'Content-Type':'text/html; charset=utf-8','Cache-Control':'no-store'});
 res.end(await readFile(new URL('../public/phone-setup.html',import.meta.url)));
}).listen(8794,'127.0.0.1',()=>console.log('Phone setup design preview: http://127.0.0.1:8794/?preview=1'));
