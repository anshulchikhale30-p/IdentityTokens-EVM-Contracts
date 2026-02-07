// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title MiniDITProtocol
/// @notice Protocol-level specification for Mini DIT (documentation-only contract)
abstract contract MiniDITProtocol {
    /*//////////////////////////////////////////////////////////////
                                STRUCTS
    //////////////////////////////////////////////////////////////*/

    struct Identity {
        address owner;
        bool compromised;
    }

    struct Endorsement {
        uint256 fromTokenId;
        uint256 toTokenId;
        uint256 timestamp;
    }

    struct RevocationSignal {
        uint256 fromTokenId;
        uint256 toTokenId;
        uint256 timestamp;
    }

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event IdentityCreated(uint256 indexed tokenId, address indexed owner);
    event Endorsed(uint256 indexed fromTokenId, uint256 indexed toTokenId);
    event Revoked(uint256 indexed fromTokenId, uint256 indexed toTokenId);
    event IdentityCompromised(uint256 indexed tokenId);

    /*//////////////////////////////////////////////////////////////
                        FUNCTION SIGNATURES
    //////////////////////////////////////////////////////////////*/

    function mintIdentity() external virtual returns (uint256);

    function endorse(uint256 fromTokenId, uint256 toTokenId) external virtual;

    function revoke(uint256 fromTokenId, uint256 toTokenId) external virtual;

    function markCompromised(uint256 tokenId) external virtual;
}
