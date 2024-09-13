import { ethers } from 'hardhat'

async function main() {

  const [deployer] = await ethers.getSigners()

  console.log('Deploying contracts with the account: ', deployer.address)

  console.log('Account balance: ', (await deployer.provider.getBalance(deployer.address)).toString())

  const magawaFactory = await ethers.getContractFactory('MAGAWA_GAME')
  const magawa = await magawaFactory.deploy()

  console.log('magawa AIRDROP deployed to:', (await magawa.getAddress()))
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})