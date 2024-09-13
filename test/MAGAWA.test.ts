import { ethers } from 'hardhat'
import type { Signer } from 'ethers'
import chai from 'chai'
import chaiAsPromised from 'chai-as-promised'

import { Magawa } from './../typechain-types/Magawa'
import { Magawa__factory } from './../typechain-types/factories/Magawa__factory'

chai.use(chaiAsPromised)

const { expect } = chai

describe('Magawa', () => {
  let magawaFactory: Magawa__factory
  let magawa: Magawa

  describe('Deployment', () => {

    beforeEach(async () => {

      magawaFactory = new Magawa__factory()

      magawa = await magawaFactory.deploy()

      await magawa.deployed()
      
    })

    it('should have the correct address', async () => {
      expect(magawa.address)
    })
  })
})