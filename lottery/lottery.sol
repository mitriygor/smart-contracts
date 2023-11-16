// SPDX-License-Identifier: GPL-3.0

// The above line is a license identifier for the smart contract. GPL-3.0 is an open-source license.
// Specifies the compiler version for Solidity. This contract will work with versions from 0.5.0 to below 0.9.0.
pragma solidity >=0.5.0 <0.9.0;

// This is the main contract for the Lottery system.
contract Lottery {

    // An array to hold the addresses of the players in the lottery. They are 'payable' as they might receive Ether.
    address payable[] public players;

    // The address of the contract manager (the person who deploys and manages the contract).
    address public manager;

    constructor() {
        // The constructor sets the manager of the contract to the address that deploys it.
        manager = msg.sender;
    }

    receive () payable external {
        // A receive function that accepts payments. It requires exactly 0.1 Ether to be sent to participate.
        require(msg.value == 0.1 ether);

        // Adds the sender's address to the players array, allowing them to participate in the lottery.
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint) {
        // Only the manager can call this function. It checks the balance of the contract.
        require(msg.sender == manager);

        // Returns the contract's current balance in Wei.
        return address(this).balance;
    }

    // A function to generate a pseudo-random number based on block difficulty, current time, and number of players.
    function random() internal view returns(uint) {

        // Uses keccak256 for hashing and generates the pseudo-random number.
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    // This function allows the manager to pick a winner.
    function pickWinner() public {

        // Only the manager can call this function.
        require(msg.sender == manager);

        // Requires at least 3 players to pick a winner.
        require(players.length >= 3);

        // Generates a pseudo-random number.
        uint r = random();

        address payable winner;

        // Calculates an index in the players array using the random number.
        uint index = r % players.length;

        // Assigns the winner based on the random index.
        winner = players[index];

        // Transfers the entire balance of the contract to the winner.
        winner.transfer(getBalance());

        // Resets the players array for the next round of the lottery.
        players = new address payable[](0);
    }
}
