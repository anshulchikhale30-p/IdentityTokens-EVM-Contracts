// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ISocialRecovery {
    function reportCompromised(uint256 tokenId) external;
    function initiateBackupUpdate(uint256 tokenId, address newBackup) external;
    function finalizeBackupUpdate(uint256 tokenId) external;
    function recoverIdentity(uint256 tokenId) external;
}