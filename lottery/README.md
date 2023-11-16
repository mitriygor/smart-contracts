## Loterry
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