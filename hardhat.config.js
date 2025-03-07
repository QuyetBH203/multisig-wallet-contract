require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { BSC_RPC_URL, PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.4",
  defaultNetwork: "hardhat",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    tBSC: {
      url: BSC_RPC_URL || "",
      accounts: [`0x${PRIVATE_KEY}`] || [],
      chainId: 97,
    },
    bsc_mainnet: {
      url: "https://bsc-dataseed.binance.org/",
      chainId: 56,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
  }
};
