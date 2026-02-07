// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract MiniDITProtocol {
    struct IdentityMetadata {
        string name;
        string github;
        string linkedin;
        string ageGroup;
        bool compromised;
    }

    /// EVENTS (match MiniDIT exactly)
    event IdentityMinted(address indexed owner, uint256 indexed tokenId);
    event Endorsed(uint256 indexed fromTokenId, uint256 indexed toTokenId);
    event Revoked(uint256 indexed fromTokenId, uint256 indexed toTokenId);
    event Compromised(uint256 indexed tokenId);

    /// FUNCTIONS (match signatures exactly)
    function mintIdentity(
        string calldata name,
        string calldata github,
        string calldata linkedin,
        string calldata ageGroup
    ) external virtual;

    function endorse(uint256 fromTokenId, uint256 toTokenId) external virtual;

    function revokeEndorsement(uint256 fromTokenId, uint256 toTokenId)
        external
        virtual;

    function markCompromised(uint256 tokenId) external virtual;
}
