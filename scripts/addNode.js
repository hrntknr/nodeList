/* global artifacts */
// ::ffff:10.0.0.1
const nodeAddr = '0x000000000000000000000000ffff0a000001';
const nodePort = 8080;

const NodeList = artifacts.require('./NodeList.sol');

module.exports = function(callback) {
  (async ()=>{
    const nodeList = await NodeList.deployed();
    await nodeList.registerNode(nodeAddr, nodePort);
    callback();
  })().catch(console.error);
};
