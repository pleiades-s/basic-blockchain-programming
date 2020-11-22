// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract MyFirstContract {
    constructor() public {}
    function printHelloWorld() public pure returns(string memory){
        return "Hello World!";
    }
}


