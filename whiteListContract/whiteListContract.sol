// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract WhiteList{
    uint8 public constant maxWhiteListedAddresses = 10;
    mapping(address=>bool) public whiteListedAddresses;

    uint8 public numWhiteListedAddresses = 0;

    // constructor(uint8 _maxWhiteListedAddresses){
    //     maxWhiteListedAddresses = _maxWhiteListedAddresses;
    // } 

    function addAddressToWhiteList() public {
        require(numWhiteListedAddresses < maxWhiteListedAddresses,"Maximum limit reached");

        whiteListedAddresses[msg.sender] = true;

        numWhiteListedAddresses++;
    }

}