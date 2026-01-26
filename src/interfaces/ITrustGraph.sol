// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {DataTypes} from "../libraries/DataTypes.sol";

interface ITrustGraph {
    function endorse(uint256 fromId, uint256 toId, string calldata connType, uint256 ttl) external;
    function revokeEndorsement(uint256 fromId, uint256 toId, uint256 index) external;
    function getEndorsements(uint256 tokenId) external view returns (DataTypes.Endorsement[] memory);
}