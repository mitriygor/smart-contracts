# Messenger Contract

## Overview

The MessengerContract is a simple Ethereum smart contract written in Solidity. It allows the contract owner to update a message stored on the blockchain. The contract is designed for educational purposes, demonstrating basic contract structure, state management, and access control in Solidity.

## Features

- **Ownership Control**: Only the owner of the contract (the account that deployed it) can update the message.
- **Message Storage**: A message string is stored on the blockchain and can be updated by the owner.
- **Change Counter**: The contract keeps track of how many times the message has been changed.

## Requirements

- Solidity version 0.8.15
- An Ethereum wallet with some ETH for deployment and transactions.
