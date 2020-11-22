var MyFirstContract = artifacts.require("FirstContract");
require('chai')
    .should();

const { expect, assert } = require('chai');

contract('FirstContract', () => {
    before(async () => {
        myfirstcontract = await MyFirstContract.new(); // Deploy new MyFirstContract contract before testing.
    })

    it('Should deploy a smart contract properly', async () => {
        // console.log(myfirstcontract.address);
        assert(myfirstcontract.address != ''); // The deployed contract's address should not be null.
    })

    it('Should return hello world', async () => {
        const result = await myfirstcontract.getStr();
        // console.log(result);
        assert(result === 'Hello World'); // The return string of getStr() should be "Hello World".

    })
})


