// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAttributeRegistry {
    function setAttribute(uint256 tokenId, bytes32 keyHash, bytes calldata value) external;
    function getAttribute(uint256 tokenId, bytes32 keyHash) external view returns (bytes memory);
}