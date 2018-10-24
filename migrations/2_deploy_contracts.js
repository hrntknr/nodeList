/* global artifacts */

const NodeList = artifacts.require('./NodeList.sol');

module.exports = function(deployer) {
  deployer.deploy(NodeList);
};
