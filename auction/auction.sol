// SPDX-License-Identifier: GPL-3.0

// The contract is licensed under the GNU General Public License v3.0.
pragma solidity >=0.5.0 <0.9.0;

// Specifies the compatible compiler versions for this contract.
// This contract implements an auction system.
contract Auction {

    // The owner's address. They are in charge of the auction and can cancel it.
    address payable public owner;

    // The block number at which the auction starts.
    uint public startBlock;

    // The block number at which the auction ends.
    uint public endBlock;

    // IPFS hash for storing auction-related data off-chain.
    string public ipfsHash;

    // Possible states of the auction.
    enum State { Started, Running, Ended, Canceled }

    // Current state of the auction.
    State public auctionState;

    // The highest binding bid amount.
    uint public highestBindingBid;

    // Address of the highest bidder.
    address payable public highestBidder;

    // Maps each bidder's address to their bid amount.
    mapping(address => uint) public bids;

    // The minimum increment for each bid.
    uint bidIncrement;

    // Ensures that the owner can only finalize the auction and receive the highest binding bid once.
    bool public ownerFinalized = false;

    // Initializes the contract settings.
    constructor() {
        owner = payable(msg.sender);
        auctionState = State.Running;
        startBlock = block.number;
        endBlock = startBlock + 3; // Auction duration in blocks.
        ipfsHash = "";
        bidIncrement = 1 ether; // Set the bid increment.
    }

    // Modifier to enforce that the caller is not the owner.
    modifier notOwner() {
        require(msg.sender != owner);
        _;
    }

    // Modifier to enforce that the caller is the owner.
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Modifier to enforce that the action takes place after the auction starts.
    modifier afterStart() {
        require(block.number >= startBlock);
        _;
    }

    // Modifier to enforce that the action occurs before the auction ends.
    modifier beforeEnd() {
        require(block.number <= endBlock);
        _;
    }

    // A helper function to find the minimum of two values.
    function min(uint a, uint b) pure internal returns (uint) {
        if (a <= b) {
            return a;
        } else {
            return b;
        }
    }

    // Allows the owner to cancel the auction before it ends.
    function cancelAuction() public beforeEnd onlyOwner {
        auctionState = State.Canceled;
    }

    // Function for placing a bid in the auction.
    function placeBid() public payable notOwner afterStart beforeEnd returns (bool) {
        require(auctionState == State.Running);

        uint currentBid = bids[msg.sender] + msg.value;
        require(currentBid > highestBindingBid);

        bids[msg.sender] = currentBid;

        if (currentBid <= bids[highestBidder]) {
            highestBindingBid = min(currentBid + bidIncrement, bids[highestBidder]);
        } else {
            highestBindingBid = min(currentBid, bids[highestBidder] + bidIncrement);
            highestBidder = payable(msg.sender);
        }
        return true;
    }

    // Finalizes the auction.
    function finalizeAuction() public {
        require(auctionState == State.Canceled || block.number > endBlock);
        require(msg.sender == owner || bids[msg.sender] > 0);

        address payable recipient;
        uint value;

        if (auctionState == State.Canceled) {
            recipient = payable(msg.sender);
            value = bids[msg.sender];
        } else {
            if (msg.sender == owner && !ownerFinalized) {
                recipient = owner;
                value = highestBindingBid;
                ownerFinalized = true;
            } else {
                if (msg.sender == highestBidder) {
                    recipient = highestBidder;
                    value = bids[highestBidder] - highestBindingBid;
                } else {
                    recipient = payable(msg.sender);
                    value = bids[msg.sender];
                }
            }
        }

        bids[recipient] = 0;
        recipient.transfer(value);
    }
}
