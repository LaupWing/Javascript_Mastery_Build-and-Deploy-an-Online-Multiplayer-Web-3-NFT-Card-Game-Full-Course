import { ethers } from "hardhat"

const _metaDataUri =
   "https://gateway.pinata.cloud/ipfs/https://gateway.pinata.cloud/ipfs/QmX2ubhtBPtYw75Wrpv6HLb1fhbJqxrnbhDo1RViW3oVoi"

async function deploy(name: string, ...params: [string]) {
   const contractFactory = await ethers.getContractFactory(name)
   return await contractFactory.deploy(...params).then((f) => f.deployed())
}

async function main() {
   const [admin] = await ethers.getSigners()

   console.log(`Deploying to smart contract...`)

   const AVAXGods = (await deploy("AVAXGods", _metaDataUri)).connect(admin)

   console.log({
      AVAXGods: AVAXGods.address
   })
}

main()
   .then(() => process.exit(0))
   .catch((err) => {
      console.error(err)
      process.exit(1)
   })
