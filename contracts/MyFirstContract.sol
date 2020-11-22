// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract MyFirstContract {

    string str;

    constructor() public {
        str = "Hello World";
    }

    function getStr() public view returns(string memory){

        return str;
    }

    function setStr(string memory _str) public{

        str = _str;
    }

}


