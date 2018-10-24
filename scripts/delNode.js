/* global artifacts */
// ::ffff:10.0.0.1
const delNodeID = 1;

const NodeList = artifacts.require('./NodeList.sol');

module.exports = function(callback) {
  (async ()=>{
    const nodeList = await NodeList.deployed();
    await nodeList.unregisterNode(delNodeID);
    callback();
  })().catch(console.error);
};
