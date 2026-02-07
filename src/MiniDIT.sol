// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";


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

function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
    address from = _ownerOf(tokenId);
    if (from != address(0) && to != address(0)) {
        revert("MiniDIT: identity tokens are non-transferable");
    }
    return super._update(to, tokenId, auth);
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
    string memory name,
    string memory github,
    string memory linkedin,
    string memory ageGroup
) external {
    require(balanceOf(msg.sender) == 0, "Already has identity");

    uint256 tokenId = nextTokenId;
    nextTokenId++;

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
    require(ownerOf(fromTokenId) == msg.sender, "Not token owner");
    require(fromTokenId != toTokenId, "Self endorsement not allowed");

    // Endorser must not be compromised
    require(
        !identities[fromTokenId].compromised,
        "Compromised identity cannot endorse"
    );

    // Target must exist (ERC721 ownerOf reverts if not)
    ownerOf(toTokenId);

    // Target must not be compromised
    require(
        !identities[toTokenId].compromised,
        "Cannot endorse compromised target"
    );

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
