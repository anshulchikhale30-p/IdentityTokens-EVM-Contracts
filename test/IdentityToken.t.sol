// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test} from "forge-std/Test.sol";
import {IdentityToken} from "../src/IdentityToken.sol";

contract CoreTest is Test {
    IdentityToken token;
    address user = address(1);

    function setUp() public {
        token = new IdentityToken();
    }

    function testMint() public {
        vm.prank(user);
        uint256 id = token.mint();
        assertEq(token.ownerOf(id), user);
    }
}