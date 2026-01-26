// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library DataTypes {
    struct Endorsement {
        uint256 endorserTokenId;
        bytes32 connectionType;
        uint256 timestamp;
        uint256 validUntil;
        uint256 revokedAt;
    }

    struct IdentityState {
        bool isCompromised;
        address backupWallet;
        address pendingBackupWallet;
        uint256 backupUnlockTime;
    }
}