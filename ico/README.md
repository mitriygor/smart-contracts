## Token & ICO

### Overview
This project consists of two Solidity smart contracts. The first contract, Mirtha, is an implementation of the ERC-20 Token Standard, and the second, MirthaICO, is for managing an Initial Coin Offering (ICO) for the Mirtha Token.

### Mirtha Token Contract
The Mirtha contract implements the ERC-20 standard, providing functionalities for token management, including transfers, balance inquiries, and allowances for third-party transfers.

### Key Features
- Token Information: The token is named "Mirtha" with the symbol "MRT" and does not support decimal values.
- Total Supply: Initially, 1,000,000 tokens are minted and assigned to the founder.
- Standard ERC-20 Functions: Includes transfer, balanceOf, approve, allowance, and transferFrom.

### Functions
- balanceOf: Returns the token balance of a specific address.
- transfer: Enables a token holder to transfer tokens to another address.
- allowance: Returns the remaining number of tokens that a spender is allowed to spend on behalf of the token owner.
- approve: Sets the amount a spender is allowed to withdraw from the owner's account.
- transferFrom: Allows a spender to transfer tokens from the owner’s account to another account.

### Mirtha ICO Contract
The MirthaICO contract is designed to manage the token sale process, including investment, token distribution, and emergency halting functionality.

### Key Features
- ICO Parameters: Customizable parameters like token price, hard cap, sale duration, and investment limits.
- State Management: Manages different states of the ICO (before start, running, after end, halted).
- Investment Function: Allows investors to send Ether to the contract in exchange for tokens.

### Functions
- invest: Handles the investment process, transferring tokens to investors based on the amount of Ether sent.
  halt and resume: Allow the admin to halt or resume the ICO in case of emergencies.
- changeDepositAddress: Enables changing the address where collected funds are deposited.
- getCurrentState: Returns the current state of the ICO.
- burn: Allows burning of unsold tokens after the ICO ends.
- transfer and transferFrom (Overridden): Restrict token transfers until the end of the token trade period.

### Interacting with the Contract
- Deployment: Deploy the MirthaICO contract with a specified deposit address.
- Investing in the ICO: Send Ether to the contract address within the investment limits during the sale period.
- Token Transfer: Token holders can transfer their tokens after the token trade start time.
- Refund and Unsold Tokens: Investors can claim refunds under certain conditions, and unsold tokens can be burned after the ICO.

### Disclaimer
This contract is provided "as is", without warranty of any kind. Users should conduct thorough testing and code audits before deploying on the Ethereum mainnet. The creators are not responsible for any issues or losses arising from its use.
