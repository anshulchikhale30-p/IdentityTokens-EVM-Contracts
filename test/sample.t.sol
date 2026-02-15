// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/sample.sol";

contract SampleTest is Test {
    Sample public sample;

    function setUp() public {
        sample = new Sample("Initial Message");
    }

    function test_SetMessage() public {
        sample.setMessage("Hello Foundry");
        assertEq(sample.message(), "Hello Foundry");
    }

    function test_InitialMessage() public {
        assertEq(sample.message(), "Initial Message");
    }
}
