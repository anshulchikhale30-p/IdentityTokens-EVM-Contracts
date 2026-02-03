/*
PROTOCOL FLOW (Mini DIT)

1. User self-mints an identity token
2. Identity tokens can endorse other identity tokens
3. Endorsements are revocable by the endorser
4. Identity owners can signal compromise
5. Protocol exposes raw facts; trust logic is external
*/



//Identity Token
//Self-issued
//Non-transferable (or explicitly noted if transferable is experimental)
struct Identity {
    address owner;
    bool compromised;
}

//Endorsements (token → token)
//Endorsements are claims,not trust decisions
struct Endorsement {
    uint256 fromId;
    uint256 toId;
    bool active;
}

//Revocation & Signals
//Signals ≠ deletion
struct RevocationSignal {
    uint256 identityId;
    string reason;
    uint256 timestamp;
}

//Events = protocol interface
event IdentityMinted(uint256 indexed id, address indexed owner);
event Endorsed(uint256 indexed fromId, uint256 indexed toId);
event EndorsementRevoked(uint256 indexed fromId, uint256 indexed toId);
event IdentityCompromised(uint256 indexed id);

//Identity minting
function mintIdentity() external {
    require(ownerToId[msg.sender] == 0, "Already has identity");
    ...
}

//Endorsement rules
require(!identities[fromId].compromised, "Compromised identity");

//Revocation rules
require(msg.sender == identities[fromId].owner);


// NOTE:
// - No trust scoring
// - No sybil resistance
// - No off-chain verification
// - No governance

