// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title HelloArchitect_v3
 * @dev A contract that keeps a history of all greetings set by users.
 */
contract HelloArchitect {
    // Structure to store message details
    struct Message {
        address sender;    // Who sent the greeting
        string text;       // The greeting content
        uint256 timestamp; // When it was sent
    }

    string private currentGreeting;
    address public owner;
    
    // An array to store all previous messages
    Message[] public history;

    event GreetingChanged(address indexed changedBy, string newGreeting);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        currentGreeting = "Hello Architect!";
        
        // Save the initial greeting to history
        history.push(Message(msg.sender, currentGreeting, block.timestamp));
    }

    /**
     * @dev Update greeting and save it to the history list.
     * Note: In this version, anyone can set a greeting to build a guestbook!
     * (Removed onlyOwner to allow everyone to participate)
     */
    function setGreeting(string memory newGreeting) public {
        currentGreeting = newGreeting;
        
        // Add the new record to the history array
        history.push(Message(msg.sender, newGreeting, block.timestamp));
        
        emit GreetingChanged(msg.sender, newGreeting);
    }

    function getGreeting() public view returns (string memory) {
        return currentGreeting;
    }

    /**
     * @dev Returns the total number of greetings in history.
     */
    function getHistoryCount() public view returns (uint256) {
        return history.length;
    }

    /**
     * @dev Get a specific message from history by index.
     */
    function getMessageAt(uint256 index) public view returns (address, string memory, uint256) {
        require(index < history.length, "Index out of bounds");
        Message memory m = history[index];
        return (m.sender, m.text, m.timestamp);
    }
}