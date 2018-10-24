/* global artifacts */
const NodeList = artifacts.require('./NodeList.sol');

module.exports = function(callback) {
  (async ()=>{
    const nodeList = await NodeList.deployed();
    const length = Number(await nodeList.getNodeLength());
    for (let i = 0; i < length; i++) {
      const nodeInfo = await nodeList.getNodeByIndex(i);
      console.log(i, Number(nodeInfo[0]), nodeInfo[1], Number(nodeInfo[2]));
    }
    callback();
  })().catch(console.error);
};
