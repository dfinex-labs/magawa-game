import { config as dotEnvConfig } from 'dotenv'
import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

dotEnvConfig()

const config: HardhatUserConfig = {
  defaultNetwork: 'mainnet',
  networks: {

    localhost: {
      url: 'http://127.0.0.1:8545'
    },

    hardhat: {},

    testnet: {
      url: `https://base-mainnet.g.alchemy.com/v2/${ process.env.ALCHEMY_KEY as string }`,
      chainId: 97,
      gasPrice: 20000000000,
      accounts: [process.env.PRIVATE_KEY as string]
    },

    mainnet: {
      url: `https://base-testnet.g.alchemy.com/v2/${ process.env.ALCHEMY_KEY as string }`,
      chainId: 56,
      gasPrice: 20000000000,
      accounts: [process.env.PRIVATE_KEY as string]
    }

  },

  solidity: {
    version: '0.8.20',
    settings: {
      optimizer: {
        enabled: true
      }
    }
  },

  paths: {
    sources: './contracts',
    tests: './test',
    cache: './cache',
    artifacts: './artifacts'
  },
  
  mocha: {
    timeout: 20000
  }

}

export default config