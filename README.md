# Collection of Smart Contracts


## 1. Token & ICO 

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

## 2. Crowd Funding

### Overview
This Solidity smart contract, written for Solidity version 0.8.5, implements a crowdfunding system on the Ethereum blockchain. It enables individuals to contribute to a project, vote on spending requests, and receive refunds if the project's financial goals are not met.

### Features
- Ethereum-based Crowdfunding: Leverages the security and transparency of the Ethereum blockchain.
- Contributor Tracking: Keeps track of all contributions using Ethereum addresses.
- Spending Request System: Allows the project admin to create requests for spending the raised funds.
- Voting Mechanism: Contributors can vote on spending requests.
- Refund Capability: Contributors can claim refunds if the project goal isn't reached within the deadline.
- Event Logging: Utilizes events to log significant actions like contributions, creation of requests, and payments.

### Contract Specifications
- Solidity Version: The contract is compatible with Solidity 0.8.5.
- License: Licensed under the GNU General Public License v3.0.

### Key Contract Components
- Admin Management: The contract deployer is set as the admin.
- Contribution Management: Tracks each contributor's amount and increments the total raised funds.
- Request Management: Allows creating and voting on spending requests.
- Fund Management: Handles fund disbursement and refunds.

### Main Functions
- constructor(uint _goal, uint _deadline): Sets up the crowdfunding goal, deadline, and minimum contribution.
- contribute(): Allows users to contribute to the crowdfunding project.
- getBalance(): Returns the total balance of funds in the contract.
- getRefund(): Enables contributors to receive a refund.
- createRequest(string calldata _description, address payable _recipient, uint _value): Admin function to create a new spending request.
- voteRequest(uint _requestNo): Allows contributors to vote on a specific spending request.
- makePayment(uint _requestNo): Admin function to release funds for a spending request that has passed the voting process.

### Interaction with the Contract
1. Contributing: Users can send ETH to the contract to contribute to the crowdfunding campaign.
2. Voting on Requests: Contributors can vote on how the raised funds should be spent.
3. Refunds: If the project's financial goal isn't met by the deadline, contributors can claim a refund.
4. Admin Responsibilities: The admin can create spending requests and disburse funds upon successful voting.

### Security Measures
- Deadline Enforcement: Contributions are only accepted within the set timeframe.
- Minimum Contribution Requirement: Ensures that contributions meet or exceed the minimum amount.
- Refund Conditions: Refunds are only allowed if the goal isn't reached by the deadline.

### Disclaimer
This contract is provided "as is", without warranty of any kind. Users should conduct their own due diligence and testing before deploying it on the Ethereum network. The creators are not responsible for any issues or losses arising from its use.


## 3. Auction

### Overview
This Solidity smart contract implements a blockchain-based auction system, designed to run on the Ethereum network. The contract allows participants to place bids during a predefined auction period, with the highest bidder at the end winning the auction.

### Features
- Ethereum-based Auction System: Runs on the Ethereum blockchain, ensuring transparency and security.
- Configurable Auction Period: The auction duration is defined by start and end block numbers.
- Bid Management: Tracks each participant's bids and updates the highest bid in real time.
- Owner Privileges: The owner (deployer of the contract) can cancel the auction and finalize it.
- IPFS Integration: Supports storing auction data off-chain using IPFS.

### Contract Specifications
- Solidity Version Compatibility: The contract is compatible with Solidity 0.5.0 to 0.9.0.
- License: Licensed under the GNU General Public License v3.0.

### Contract Functions
- constructor(): Sets up the auction with the contract deployer as the owner and initializes auction parameters.
- cancelAuction(): Allows the owner to cancel the auction before it ends.
- placeBid(): Enables participants to place bids. The function ensures that bids are placed only during the auction period and by non-owners.
- finalizeAuction(): Finalizes the auction, transferring funds to the highest bidder or returning bids if the auction is canceled.

### How to Interact with the Contract
- Deploy the Contract: Deploy the contract on the Ethereum network.
- Place Bids: Participants can send Ether to the contract to place their bids.
- Cancel or Finalize: The owner can cancel the auction or finalize it after the end block.

### Security Considerations
- Auction State Management: The contract enforces the auction state (running, ended, canceled) to ensure proper interaction at different stages.
- Bidder Verification: Checks to prevent the owner from placing bids and to validate bid amounts.
- Finalization Restrictions: Ensures that only the owner or bidders can finalize the auction, with special conditions for bid returns.

### Disclaimer
This contract is provided "as is", with no guarantees. Users should perform their own due diligence and testing before deploying it on the mainnet. The creators are not responsible for any issues or losses arising from its use.





## 4. Loterry
### Overview
This Solidity Smart Contract implements a simple lottery system on the Ethereum blockchain. Players can participate by sending a fixed amount of Ether, and the contract manager can pick a winner through a pseudo-random number generation process.

### Features
- Ethereum-based Lottery: Utilizes Ethereum blockchain for transparent and decentralized lottery management.
- Fixed Entry Fee: Requires exactly 0.1 Ether to enter the lottery.
- Random Winner Selection: Employs a pseudo-random number generator based on block difficulty, current timestamp, and the number of players.
- Manager Privileges: Only the contract manager (deployer) can pick winners and check the contract balance. 

### Contract Specifications 
- Solidity Version: Compatible with Solidity versions from 0.5.0 to below 0.9.0.
- License: GPL-3.0 open-source license.

### Contract Functions
- constructor(): Sets the contract deployer as the manager.
- receive() payable: Allows participation in the lottery by sending 0.1 Ether.
- getBalance(): View function to check the contract's balance, accessible only by the manager.
- random(): Internal function to generate a pseudo-random number for selecting the winner.
- pickWinner(): Selects a winner from the pool of players, transfers the contract's balance to the winner, and resets the player array.

### How to Use
1. Deploy the Contract: Deploy the contract on the Ethereum network.
2. Participate in Lottery: Send 0.1 Ether to the contract address to enter the lottery.
3. Winner Selection: The manager can call pickWinner after at least 3 players have entered.
4. Receiving Prize: The chosen winner receives the entire balance of the contract.

### Security and Considerations
- The random number generation method is not entirely tamper-proof and should not be used for high-stake lotteries.
- Ensure that the contract is thoroughly audited for security vulnerabilities before deployment.
- The contract manager has exclusive control over picking winners and accessing the contract balance.

### Disclaimer
This contract is provided "as is", with no warranty of any kind. The deployment and use of this contract are at the user's own risk. The creator of this contract is not liable for any damages or losses that may result from its use.