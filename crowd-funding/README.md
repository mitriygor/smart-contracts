## Crowd Funding

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
