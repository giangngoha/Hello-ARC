// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title HelloArchitect_v4
 * @dev Added Cooldown feature: Each user can only set a greeting once every 60 seconds.
 */
contract HelloArchitect {
    struct Message {
        address sender;
        string text;
        uint256 timestamp;
    }

    string private currentGreeting;
    address public owner;
    Message[] public history;

    // Mapping to store the last time a user updated the greeting
    mapping(address => uint256) public lastUpdateAt;
    
    // Cooldown duration: 60 seconds
    uint256 public constant COOLDOWN_TIME = 60;

    event GreetingChanged(address indexed changedBy, string newGreeting);

    constructor() {
        owner = msg.sender;
        currentGreeting = "Hello Architect!";
        history.push(Message(msg.sender, currentGreeting, block.timestamp));
    }

    /**
     * @dev Set greeting with a cooldown check.
     */
    function setGreeting(string memory newGreeting) public {
        // Check if the user is still in cooldown
        require(
            block.timestamp >= lastUpdateAt[msg.sender] + COOLDOWN_TIME,
            "Wait 1 minute before sending another greeting!"
        );

        currentGreeting = newGreeting;
        
        // Update the last message timestamp for this user
        lastUpdateAt[msg.sender] = block.timestamp;
        
        history.push(Message(msg.sender, newGreeting, block.timestamp));
        emit GreetingChanged(msg.sender, newGreeting);
    }

    function getGreeting() public view returns (string memory) {
        return currentGreeting;
    }

    function getHistoryCount() public view returns (uint256) {
        return history.length;
    }

    function getMessageAt(uint256 index) public view returns (address, string memory, uint256) {
        require(index < history.length, "Index out of bounds");
        Message memory m = history[index];
        return (m.sender, m.text, m.timestamp);
    }
}