// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import '../whiteListContract/whiteListContract.sol';

contract CryptoDevs is ERC721Enumerable, Ownable{
    uint256 constant public _price = 0.01 ether;
    uint256 constant public maxTokenIds = 20;

    WhiteList whitelist;
    
    uint256 public immutable reservedTokens;
    uint256 public reservedTokensClaimed = 0;
    
    constructor (address whiteListContract) ERC721("Crypto Devs", "CD") Ownable(msg.sender){
        whitelist = WhiteList(whiteListContract);
        reservedTokens = whitelist.numWhiteListedAddresses();
    }

    function mint() public payable {
        require(totalSupply() + reservedTokens - reservedTokensClaimed < maxTokenIds, "Maximum Limit reached");
        
        if(whitelist.whiteListedAddresses(msg.sender) && msg.value < _price){
            require(balanceOf(msg.sender) == 0,"Already_OWNED");
            reservedTokensClaimed += 1;
        }else{
            require(msg.value >= _price,"Not enough ether");
        }
        uint256 tokenId = totalSupply();
        _safeMint(msg.sender, tokenId);
    }
    
    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;

        (bool sent, ) = _owner.call{value:amount}("");
        require(sent,"Failed to send ether");
    }
}