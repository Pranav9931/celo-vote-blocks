/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    defaultNetwork: 'alfajores',
    networks: {
      hardhat: {},
      alfajores: {
        url: "https://alfajores-forno.celo-testnet.org",
        accounts: [`0x${process.env.PRIVATE_KEY}`],
        chainId: 44787
      }
    },
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
