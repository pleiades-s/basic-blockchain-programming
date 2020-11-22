const {BN} = require('@openzeppelin/test-helpers');

const MyToken = artifacts.require('MyToken');

require('chai')
    .should();

const { expect, assert } = require('chai');

contract('MyToken', () => {

    const _name = 'My Token';
    const _symbol = 'MTK';
    const _decimals = new BN(18);

    beforeEach(async function () {
        this.token = await MyToken.new(_name, _symbol); // Deploy new MyToken contract before testing.
    });

    describe('token attributes', function() {
        it('has the correct name', async function() {
            const name = await this.token.name();
            // console.log(name);
            name.should.equal(_name); // assertion; The token name should be "My Token".
        });

        it('has the correct symbol', async function() {
            const symbol = await this.token.symbol();
            // console.log(symbol);
            symbol.should.equal(_symbol); // assertion; Its symbol should be "MTK".
        });

        it('has the correct decimals', async function() {
            const decimals = await this.token.decimals();
            // console.log(decimals);
            expect(decimals).to.be.bignumber.equal(_decimals); // assertion; Its decimals should be 18.
        });
    });
});