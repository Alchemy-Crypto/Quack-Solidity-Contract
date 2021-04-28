require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');
const mnemonic = process.env.MNEUMONIC;

module.exports = {
    networks: {
        ropsten: {
        provider: () => new HDWalletProvider(mnemonic, 'https://ropsten.infura.io/v3/535c9ab607634dc9bacdb767e3075aee'),
        network_id: 3,       // Ropsten's id
        gas: 5500000,        // Ropsten has a lower block limit than mainnet
        },
    },
    mocha: {
      // timeout: 100000
    },
    compilers: {
        solc: {
        // version: "0.5.1",    // Fetch exact version from solc-bin (default: truffle's version)
        // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
        // settings: {          // See the solidity docs for advice about optimization and evmVersion
        //  optimizer: {
        //    enabled: false,
        //    runs: 200
        //  },
        //  evmVersion: "byzantium"
        // }
        }
    },
    db: {
        enabled: false
    }
};