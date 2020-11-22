const MerkleTree = artifacts.require('MerkleTree');

require('chai')
    .should();

const { expect, assert } = require('chai');

contract('MerkleTree', () => {
    beforeEach(async function () {
        this.merkletree = await MerkleTree.new(); // Deploy new MerkleTree contract before testing.
    });
    describe('Should be verified', function() {
        it(' ', async function() {
            const result = await this.merkletree.doVerify();
            // console.log(result);
            assert(result == true); // The merkle proof should be verified.
        });
    });
});