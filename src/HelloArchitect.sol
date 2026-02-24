// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title HelloArchitect
 * @dev A simple contract to manage a greeting with ownership access control.
 */
contract HelloArchitect {
    string private greeting;
    address public owner; // Variable to store the address of the owner

    // Event emitted when the greeting is updated
    event GreetingChanged(address indexed changedBy, string newGreeting);

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    /**
     * @dev Set the initial greeting and the deployer as the owner.
     */
    constructor() {
        owner = msg.sender; // The account that deploys the contract becomes the owner
        greeting = "Hello Architect!";
    }

    /**
     * @dev Update the greeting message. Only accessible by the owner.
     * @param newGreeting The new string to be stored as a greeting.
     */
    function setGreeting(string memory newGreeting) public onlyOwner {
        greeting = newGreeting;
        emit GreetingChanged(msg.sender, newGreeting);
    }

    /**
     * @dev Returns the current greeting message.
     */
    function getGreeting() public view returns (string memory) {
        return greeting;
    }

    /**
     * @dev Transfers ownership of the contract to a new account.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        owner = newOwner;
    }
}