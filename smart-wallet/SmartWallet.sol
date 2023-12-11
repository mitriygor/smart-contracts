// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract SmartWallet {
    address payable owner;
    address payable nextOwner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    mapping(address => bool) public guardians;

    mapping(address => mapping(address => bool)) nextOwnerGuardianVotedBool;

    mapping(address => uint) public lastSent;

    uint guardiansResetCount;
    uint public constant GUARDIANS_RESET_LIMIT = 3;


    constructor() {
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender == owner, "You aren't owner");
        guardians[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "You aren't guardian");
        require(!nextOwnerGuardianVotedBool[_newOwner][msg.sender], "You already voted");
        if (_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardiansResetCount = 0;
        }
        guardiansResetCount++;

        if (guardiansResetCount >= GUARDIANS_RESET_LIMIT) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }

    }

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You aren't the owner");
        allowance[msg.sender] = _amount;

        if (_amount > 0) {
            isAllowedToSend[_for] = true;
        } else {
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns (bytes memory) {
        // require(msg.sender == owner, "You are not the owner, abortin");

        if (msg.sender != owner) {
            require(allowance[msg.sender] >= amount, "No enough funds");
            require(isAllowedToSend[msg.sender], "Not allowed to send");

            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success, "Call wasn't successful");
        return returnData;
    }

    receive() external payable {

    }
}