// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Sample {
    string public message;

    // Matches: sample = new Sample("Initial Message");
    constructor(string memory _message) {
        message = _message;
    }

    // Matches: sample.setMessage("Hello Foundry");
    function setMessage(string memory _newMessage) public {
        message = _newMessage;
    }
}
