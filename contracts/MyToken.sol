// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    uint public constant INITIAL_SUPPLY = 1000 * (10 ** 18);

    constructor (string memory name, string memory symbol) ERC20(name, symbol) public {
        _mint(msg.sender, INITIAL_SUPPLY);
    }   
}
