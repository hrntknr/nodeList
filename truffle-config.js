// https://iancoleman.io/bip39/
// https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn
const {MNEMONIC: mnemonic, TOKEN: token} = process.env;
const HDWalletProvider = require('truffle-hdwallet-provider');
module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*',
      gasPrice: 0,
      gas: 1000000,
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, `https://ropsten.infura.io/${token}`);
      },
      network_id: 3,
    },
  },
};
