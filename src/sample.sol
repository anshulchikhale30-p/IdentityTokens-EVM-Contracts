// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; 

// The contract name must match what the test expects ("Sample")
contract Sample {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
