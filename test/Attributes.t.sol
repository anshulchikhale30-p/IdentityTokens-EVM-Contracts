// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test} from "forge-std/Test.sol";
import {IdentityToken} from "../src/IdentityToken.sol";

contract AttributeTest is Test {
    IdentityToken token;
    address user = address(1);

    function setUp() public { token = new IdentityToken(); }

    function testPrivacyHash() public {
        vm.startPrank(user);
        uint256 id = token.mint();
        bytes32 key = keccak256("email");
        bytes memory val = abi.encodePacked(keccak256("user@example.com"));
        
        token.setAttribute(id, key, val);
        assertEq(token.getAttribute(id, key), val);
    }
}