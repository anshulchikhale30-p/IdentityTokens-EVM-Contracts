// Tests validate protocol behavior, not trust assumptions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MiniDIT.sol";

contract MiniDITTest is Test {
    MiniDIT dit;
    address alice = address(0x1);
    address bob   = address(0x2);

    function setUp() public {
        dit = new MiniDIT();
    }

    function testMintIdentity() public {
        vm.prank(alice);
        dit.mintIdentity(
            "Alice",
            "github.com/alice",
            "linkedin.com/alice",
            "18+"
        );

        assertEq(dit.ownerOf(0), alice);
    }

    function testEndorsementFlow() public {
        vm.startPrank(alice);
        dit.mintIdentity("Alice", "", "", "18+");
        vm.stopPrank();

        vm.startPrank(bob);
        dit.mintIdentity("Bob", "", "", "18+");
        vm.stopPrank();

        vm.prank(alice);
        dit.endorse(0, 1);

        assertTrue(dit.endorsements(0, 1));
    }

    function testRevokeEndorsement() public {
        vm.prank(alice);
        dit.mintIdentity("Alice", "", "", "18+");

        vm.prank(bob);
        dit.mintIdentity("Bob", "", "", "18+");

        vm.prank(alice);
        dit.endorse(0, 1);

        vm.prank(alice);
        dit.revokeEndorsement(0, 1);

        assertFalse(dit.endorsements(0, 1));
    }

    function testMarkCompromised() public {
        vm.prank(alice);
        dit.mintIdentity("Alice", "", "", "18+");

        vm.prank(alice);
        dit.markCompromised(0);

        (, , , , bool compromised) = dit.identities(0);
        assertTrue(compromised);
    }
}
