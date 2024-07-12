// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract TalentShowToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Talent Show", "MST") Ownable(msg.sender) {}

    // Enum for magical items
    enum Talentitems { yoyo, bottle, balls, Puppet }

    // Struct to store player's Talent Show items balance
    struct PlayerItems {
        uint256 yoyo;
        uint256 bottle;
        uint256 balls;
        uint256 Puppet;
    }

    // Mapping from player address to their magical items balance
    mapping(address => PlayerItems) public playerItems;

    // Function to mint new tokens, only callable by the owner
    function mintTokens(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Function to transfer tokens to another address
    function transferTokens(address to, uint256 amount) external {
        _transfer(_msgSender(), to, amount);
    }

    // Function to redeem tokens for Talent items
    function redeemItem(Talentitems item) external {
        uint256 cost;
        if (item == Talentitems.yoyo) {
            cost = 10;
            playerItems[msg.sender].yoyo += 1;
        } else if (item == Talentitems.bottle) {
            cost = 20;
            playerItems[msg.sender].bottle += 1;
        } else if (item == Talentitems.balls) {
            cost = 30;
            playerItems[msg.sender].balls += 1;
        } else if (item == Talentitems.Puppet) {
            cost = 40;
            playerItems[msg.sender].Puppet += 1;
        } else {
            revert("Invalid Talent items");
        }
        
        require(balanceOf(msg.sender) >= cost, "Insufficient balance");
        burn(cost);
    }

    // Function to burn tokens, callable by anyone for their own tokens
    function burnTokens(uint256 amount) external {
        burn(amount);
    }

    // Function to check token balance
    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }
}
