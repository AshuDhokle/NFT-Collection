// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract WhiteList{
    uint8 public maxWhiteListedAddresses;
    mapping(address=>bool) public whiteListedAddresses;
    uint8 public numOfWhiteListedAddresses;

    constructor(uint8 _maxWhiteListedAddresses) {
        maxWhiteListedAddresses = _maxWhiteListedAddresses;
    }
    
    function addAddressToWhiteList() public {
        require(!whiteListedAddresses[msg.sender], "Address Already WhiteListed");
        require(numOfWhiteListedAddresses<maxWhiteListedAddresses,"Maximum limit reached");
        whiteListedAddresses[msg.sender] = true;
        numOfWhiteListedAddresses += 1;
    }

}