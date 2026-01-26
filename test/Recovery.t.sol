// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test} from "forge-std/Test.sol";
import {IdentityToken} from "../src/IdentityToken.sol";

contract RecoveryTest is Test {
    IdentityToken token;
    address u1 = address(1);
    address backup = address(2);

    function setUp() public { token = new IdentityToken(); }

    function testTimelockedRecovery() public {
        vm.startPrank(u1);
        uint256 id = token.mint();
        token.initiateBackupUpdate(id, backup);
        
        vm.warp(block.timestamp + 15 days);
        token.finalizeBackupUpdate(id);
        vm.stopPrank();

        vm.prank(backup);
        token.recoverIdentity(id);
        assertEq(token.ownerOf(id), backup);
    }
}