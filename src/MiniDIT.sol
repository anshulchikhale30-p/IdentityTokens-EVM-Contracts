// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title MiniDIT
 * @notice Experimental 1-week prototype for Decentralized Identity Tokens (DIT)
 * @dev NOT production-ready. Built for design exploration only.
 */
contract MiniDIT is ERC721 {
    uint256 public nextTokenId;

    struct IdentityMetadata {
        string name;
        string github;
        string linkedin;
        string ageGroup; // e.g. "18+", "21+", etc.
        bool compromised;
    }

    // tokenId => metadata
    mapping(uint256 => IdentityMetadata) public identities;

    // fromTokenId => toTokenId => endorsed?
    mapping(uint256 => mapping(uint256 => bool)) public endorsements;

    event IdentityMinted(address indexed owner, uint256 indexed tokenId);
    event Endorsed(uint256 indexed fromTokenId, uint256 indexed toTokenId);
    event EndorsementRevoked(uint256 indexed fromTokenId, uint256 indexed toTokenId);
    event IdentityCompromised(uint256 indexed tokenId);

    constructor() ERC721("Mini Decentralized Identity Token", "MiniDIT") {}

    /**
     * @notice Mint a self-issued identity token
     */
    function mintIdentity(
        string calldata name,
        string calldata github,
        string calldata linkedin,
        string calldata ageGroup
    ) external {
        uint256 tokenId = nextTokenId++;
        _safeMint(msg.sender, tokenId);

        identities[tokenId] = IdentityMetadata({
            name: name,
            github: github,
            linkedin: linkedin,
            ageGroup: ageGroup,
            compromised: false
        });

        emit IdentityMinted(msg.sender, tokenId);
    }

    /**
     * @notice Endorse another identity token
     */
    function endorse(uint256 fromTokenId, uint256 toTokenId) external {
    // Caller must own the endorsing identity
    require(ownerOf(fromTokenId) == msg.sender, "Not token owner");

    // Prevent self-endorsement
    require(fromTokenId != toTokenId, "Self endorsement not allowed");

    // Endorsing identity must not be compromised
    require(!identities[fromTokenId].compromised, "Compromised identity cannot endorse");

    // Target identity must exist
    ownerOf(toTokenId); // ERC721 reverts if token does not exist

    endorsements[fromTokenId][toTokenId] = true;
    emit Endorsed(fromTokenId, toTokenId);
}

    /**
     * @notice Revoke an endorsement
     */
    function revokeEndorsement(uint256 fromTokenId, uint256 toTokenId) external {
        require(ownerOf(fromTokenId) == msg.sender, "Not token owner");

        endorsements[fromTokenId][toTokenId] = false;
        emit EndorsementRevoked(fromTokenId, toTokenId);
    }

    /**
     * @notice Signal identity compromise
     */
    function markCompromised(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not token owner");

        identities[tokenId].compromised = true;
        emit IdentityCompromised(tokenId);
    }
}
