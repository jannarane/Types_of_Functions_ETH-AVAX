// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
    Functionality
     Only contract owner should be able to mint tokens
     Any user can transfer tokens
     Any user can burn tokens

     Owner: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
     Other: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JanaToken is ERC20, Ownable {
    string private constant tokenName = "JannaToken";
    string private constant tokenAbbr = "JRN";

    constructor() ERC20(tokenName, tokenAbbr) Ownable(msg.sender) {}

     //mints tokens to the address and can only be called by the contract owner.
    function mint(address to, uint256 amount) public onlyOwner {
        require(amount > 0, "Balance Insufficient");
        _mint(to, amount);
    }

    //burns tokens from the caller's account.
     
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    /**
     transfers tokens from the caller's account to account and requires the caller to have a sufficient balance.
     */
    function transfer(address account, uint256 amount) public override returns (bool) {
        require(balanceOf(_msgSender()) >= amount, "Balance Insufficient");
        return super.transfer(account, amount);
    }
}
