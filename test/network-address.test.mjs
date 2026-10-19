import test from 'node:test';
import assert from 'node:assert/strict';
import {chooseRobotAddress,privateIPv4} from '../network-address.mjs';
const nic=address=>[{address,family:'IPv4',internal:false}];
test('phone provisioning server selects the current Wi-Fi after moving networks',()=>{
 assert.equal(chooseRobotAddress({'Wi-Fi':nic('192.168.2.4'),'vEthernet':nic('172.20.1.1')},{previous:'192.168.31.126'}),'192.168.2.4');
 assert.equal(chooseRobotAddress({'Wi-Fi':nic('192.168.2.4'),Ethernet:nic('10.0.0.2')},{override:'10.0.0.2'}),'10.0.0.2');
 assert.throws(()=>chooseRobotAddress({'Wi-Fi':nic('192.168.2.4')},{override:'0.0.0.0'}));
 assert.throws(()=>chooseRobotAddress({Ethernet:nic('10.0.0.2'),Other:nic('192.168.0.2')}));
});
test('server cannot bind public, loopback, malformed or IPv6 addresses by default',()=>{
 for(const ip of ['127.0.0.1','8.8.8.8','::1','192.168.1.999','172.32.0.1','0.0.0.0'])assert.equal(privateIPv4(ip),false);
 for(const ip of ['10.1.2.3','172.16.0.1','172.31.255.254','192.168.0.2'])assert.equal(privateIPv4(ip),true);
});
