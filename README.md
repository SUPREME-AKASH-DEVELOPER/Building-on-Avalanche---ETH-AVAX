# Building-on-Avalanche---ETH-AVAX

```markdown
# Talent Show Token

The Talent Show Token is an ERC-20 token contract built on the Avalanche network. It is designed for use in a talent show application where players can earn, transfer, redeem, and burn tokens. The contract includes functionalities for managing player balances of various talent items.

## Features

- **Minting Tokens**: Only the contract owner can mint new tokens.
- **Transferring Tokens**: Users can transfer tokens to other addresses.
- **Redeeming Items**: Users can redeem tokens for various talent items.
- **Burning Tokens**: Users can burn their own tokens to reduce the total supply.
- **Checking Balance**: Users can check their token balance.

## Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract TalentShowToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Talent Show", "MST") Ownable(msg.sender) {}

    // Enum for talent items
    enum Talentitems { yoyo, bottle, balls, Puppet }

    // Struct to store player's Talent Show items balance
    struct PlayerItems {
        uint256 yoyo;
        uint256 bottle;
        uint256 balls;
        uint256 Puppet;
    }

    // Mapping from player address to their talent items balance
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
```

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Hardhat](https://hardhat.org/)
- [Avalanche Fuji Testnet](https://docs.avax.network/build/tutorials/platform/create-a-fuji-testnet-faucet/)

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/talent-show-token.git
    cd talent-show-token
    ```

2. Install dependencies:
    ```sh
    npm install
    ```

3. Create a `.env` file and add your Avalanche Fuji Testnet API key and wallet private key:
    ```env
    AVALANCHE_API_URL=https://api.avax-test.network/ext/bc/C/rpc
    PRIVATE_KEY=your_private_key
    ```

### Deployment

Deploy the contract to the Avalanche Fuji Testnet:
```sh
npx hardhat run scripts/deploy.js --network fuji
```

### Verification

Verify the contract on [Snowtrace](https://testnet.snowtrace.io/):
```sh
npx hardhat verify --network fuji DEPLOYED_CONTRACT_ADDRESS
```

## Usage

### Minting Tokens

Only the owner can mint new tokens:
```sh
await contract.mintTokens("recipient_address", amount);
```

### Transferring Tokens

Transfer tokens to another address:
```sh
await contract.transferTokens("recipient_address", amount);
```

### Redeeming Items

Redeem tokens for a talent item:
```sh
await contract.redeemItem(Talentitems.yoyo);
```

### Burning Tokens

Burn your own tokens:
```sh
await contract.burnTokens(amount);
```

### Checking Balance

Check the token balance of an address:
```sh
const balance = await contract.checkBalance("account_address");
```

## Contributing

Contributions are welcome! Please fork the repository and create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```
