import { HardhatUserConfig } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"
import dotenv from "dotenv"

dotenv.config()

const config: HardhatUserConfig = {
   solidity: {
      version: "0.8.17",
      settings:{
         viaIR: true,
         optimizer:{
            enabled: true,
            runs: 100
         }
      }
   },
   networks:{
      fuji:{
         url: "https://api.avax-test.network/ext/bc/C/rpc",
         gasPrice: 225000000000,
         chainId: 431113,
         accounts: [process.env.PRIVATE_KEY!]
      }
   }
}

export default config
