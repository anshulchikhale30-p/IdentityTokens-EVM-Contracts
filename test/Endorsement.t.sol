// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test} from "forge-std/Test.sol";
import {IdentityToken} from "../src/IdentityToken.sol";
import {DataTypes} from "../src/libraries/DataTypes.sol";

contract EndorsementTest is Test {
    IdentityToken token;
    address u1 = address(1); 
    address u2 = address(2);

    function setUp() public { token = new IdentityToken(); }

    function testRevocation() public {
        vm.prank(u1); uint256 id1 = token.mint();
        vm.prank(u2); uint256 id2 = token.mint();

        vm.prank(u1);
        token.endorse(id1, id2, "friend", 0);

        vm.prank(u1);
        token.revokeEndorsement(id1, id2, 0);

        DataTypes.Endorsement[] memory list = token.getEndorsements(id2);
        assertGt(list[0].revokedAt, 0);
    }
}