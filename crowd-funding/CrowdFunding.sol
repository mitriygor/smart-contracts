// SPDX-License-Identifier: GPL-3.0

// This contract is licensed under the GNU General Public License v3.0.
pragma solidity 0.8.5;

// The contract is written for Solidity version 0.8.5.
// The contract implements a crowdfunding system.
contract CrowdFunding {
    // Maps each contributor's address to their contribution amount.
    mapping(address => uint) public contributors;

    // The address of the contract's admin.
    address public admin;

    // The number of contributors.
    uint public noOfContributors;

    // The minimum amount required to contribute.
    uint public minimumContribution;

    // The deadline for the crowdfunding in Unix timestamp.
    uint public deadline;

    // The fundraising goal.
    uint public goal;

    // The total amount raised.
    uint public raisedAmount;

    // Struct to represent a spending request.
    struct Request {
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address => bool) voters;
    }

    // Mapping of spending requests, indexed by request number.
    mapping(uint => Request) public requests;
    uint public numRequests;

    // Events to signal various actions.
    event ContributeEvent(address _sender, uint _value);
    event CreateRequestEvent(string _description, address _recipient, uint _value);
    event MakePaymentEvent(address _recipient, uint _value);

    // The constructor sets the goal, deadline and admin of the crowdfunding.
    constructor(uint _goal, uint _deadline) {
        goal = _goal;
        deadline = block.timestamp + _deadline; // Set deadline based on the current block timestamp.
        admin = msg.sender; // Admin is the address deploying the contract.
        minimumContribution = 100 wei; // Set the minimum contribution amount.
    }

    // Modifier to restrict function access to only the admin.
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can execute this");
        _;
    }

    // Function to allow contributions to the crowdfunding.
    function contribute() public payable {
        require(block.timestamp < deadline, "The Deadline has passed!");
        require(msg.value >= minimumContribution, "The Minimum Contribution not met!");

        if(contributors[msg.sender] == 0) {
            noOfContributors++;
        }

        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;

        emit ContributeEvent(msg.sender, msg.value);
    }

    // Returns the balance of funds in the contract.
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Allows contributors to get a refund if the goal is not met by the deadline.
    function getRefund() public {
        require(block.timestamp > deadline, "Deadline has not passed.");
        require(raisedAmount < goal, "The goal was met");
        require(contributors[msg.sender] > 0);

        address payable recipient = payable(msg.sender);
        uint value = contributors[msg.sender];

        contributors[msg.sender] = 0;
        recipient.transfer(value);
    }

    // Allows the admin to create a new spending request.
    function createRequest(string calldata _description, address payable _recipient, uint _value) public onlyAdmin {
        Request storage newRequest = requests[numRequests];
        numRequests++;

        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;

        emit CreateRequestEvent(_description, _recipient, _value);
    }

    // Allows contributors to vote on a spending request.
    function voteRequest(uint _requestNo) public {
        require(contributors[msg.sender] > 0, "You must be a contributor to vote!");

        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender] == false, "You have already voted!");

        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters++;
    }

    // Allows the admin to make payment on a spending request after it's approved.
    function makePayment(uint _requestNo) public onlyAdmin {
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed == false, "The request has been already completed!");

        require(thisRequest.noOfVoters > noOfContributors / 2, "The request needs more than 50% of the contributors.");

        thisRequest.completed = true;
        thisRequest.recipient.transfer(thisRequest.value);

        emit MakePaymentEvent(thisRequest.recipient, thisRequest.value);
    }
}
