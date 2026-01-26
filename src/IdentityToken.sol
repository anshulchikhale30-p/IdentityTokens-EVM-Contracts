// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IIdentityToken} from "./interfaces/IIdentityToken.sol";
import {DataTypes} from "./libraries/DataTypes.sol";
import {Errors} from "./libraries/Errors.sol";
import {Events} from "./libraries/Events.sol";

contract IdentityToken is ERC721, Ownable, IIdentityToken {
    uint256 private _nextTokenId;
    uint256 public constant BACKUP_TIMELOCK = 14 days;

    mapping(uint256 => DataTypes.IdentityState) private _states;
    mapping(uint256 => mapping(bytes32 => bytes)) private _attributes;
    mapping(uint256 => DataTypes.Endorsement[]) private _endorsements;

    constructor() ERC721("IdentityToken", "ADIT") Ownable(msg.sender) {}

    modifier onlyTokenOwner(uint256 tokenId) {
        if (ownerOf(tokenId) != msg.sender) revert Errors.NotTokenOwner();
        _;
    }

    function mint() external override returns (uint256) {
        uint256 tokenId = ++_nextTokenId;
        _safeMint(msg.sender, tokenId);
        return tokenId;
    }

    // --- Attributes ---

    function setAttribute(uint256 tokenId, bytes32 keyHash, bytes calldata value) external override onlyTokenOwner(tokenId) {
        if (_states[tokenId].isCompromised) revert Errors.IdentityCompromised();
        _attributes[tokenId][keyHash] = value;
        emit Events.AttributeSet(tokenId, keyHash, value);
    }

    function getAttribute(uint256 tokenId, bytes32 keyHash) external view override returns (bytes memory) {
        return _attributes[tokenId][keyHash];
    }

    // --- Trust Graph ---

    function endorse(uint256 fromId, uint256 toId, string calldata connType, uint256 ttl) external override onlyTokenOwner(fromId) {
        if (_ownerOf(toId) == address(0)) revert Errors.TargetInvalid();
        if (fromId == toId) revert Errors.SelfEndorsement();
        if (_states[fromId].isCompromised) revert Errors.EndorserCompromised();

        bytes32 typeHash = keccak256(abi.encodePacked(connType));
        uint256 expiry = ttl == 0 ? 0 : block.timestamp + ttl;

        _endorsements[toId].push(DataTypes.Endorsement({
            endorserTokenId: fromId,
            connectionType: typeHash,
            timestamp: block.timestamp,
            validUntil: expiry,
            revokedAt: 0
        }));

        emit Events.EndorsementGiven(fromId, toId, typeHash, expiry);
    }

    function revokeEndorsement(uint256 fromId, uint256 toId, uint256 index) external override onlyTokenOwner(fromId) {
        if (index >= _endorsements[toId].length) revert Errors.IndexOutOfBounds();
        
        DataTypes.Endorsement storage endo = _endorsements[toId][index];
        if (endo.endorserTokenId != fromId) revert Errors.NotEndorser();
        if (endo.revokedAt != 0) revert Errors.AlreadyRevoked();

        endo.revokedAt = block.timestamp;
        emit Events.EndorsementRevoked(fromId, toId, index);
    }

    function getEndorsements(uint256 tokenId) external view override returns (DataTypes.Endorsement[] memory) {
        return _endorsements[tokenId];
    }

    // --- Social Recovery ---

    function reportCompromised(uint256 tokenId) external override onlyTokenOwner(tokenId) {
        _states[tokenId].isCompromised = true;
        emit Events.IdentityCompromised(tokenId);
    }

    function initiateBackupUpdate(uint256 tokenId, address newBackup) external override onlyTokenOwner(tokenId) {
        _states[tokenId].pendingBackupWallet = newBackup;
        _states[tokenId].backupUnlockTime = block.timestamp + BACKUP_TIMELOCK;
        emit Events.BackupUpdateInitiated(tokenId, newBackup, _states[tokenId].backupUnlockTime);
    }

    function finalizeBackupUpdate(uint256 tokenId) external override onlyTokenOwner(tokenId) {
        if (_states[tokenId].pendingBackupWallet == address(0)) revert Errors.NoPendingUpdate();
        if (block.timestamp < _states[tokenId].backupUnlockTime) revert Errors.TimelockActive();

        _states[tokenId].backupWallet = _states[tokenId].pendingBackupWallet;
        delete _states[tokenId].pendingBackupWallet;
        delete _states[tokenId].backupUnlockTime;
        
        emit Events.BackupUpdated(tokenId, _states[tokenId].backupWallet);
    }

    function recoverIdentity(uint256 tokenId) external override {
        if (msg.sender != _states[tokenId].backupWallet) revert Errors.NotBackupWallet();
        _transfer(ownerOf(tokenId), msg.sender, tokenId);
        emit Events.IdentityRecovered(tokenId, msg.sender);
    }
}
