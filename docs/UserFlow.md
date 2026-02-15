1. Visit DIT Frontend

Actor: User

Flow:

User opens Mini DIT frontend

Frontend loads protocol state (read-only)

UI:

“Connect Wallet” CTA

No trust score shown

No verification claims

2. Connect Wallet

Actor: User

Flow:

User connects EVM wallet

Wallet address becomes session identity

UI:

Wallet address displayed

Existing identity token (if any) detected

3. Mint Identity Token

Actor: User

Flow:

User calls
mintIdentity(name, github, linkedin, ageGroup)

Protocol mints Identity NFT

Protocol emits
IdentityMinted(tokenId, owner)

On-chain State:

Identity NFT stored on-chain

Identity metadata publicly readable

UI:

Displays Identity Token ID

Displays owner address

Status: Active

4. Add Identity Claims

Actor: Identity Owner

Flow:

User adds identity-related claims

Claims are stored as facts, not validations

On-chain State:

Claims linked to identity token

No truth evaluation by protocol

UI:

Shows claims as “Self-declared”

No verification badge

5. View Identity (Read-only)

Actor: Any User / Verifier

Flow:

Fetch identity by tokenId

Read:

Owner

Identity metadata

Endorsements (incoming / outgoing)

Compromise or revocation signals

UI:

Identity card

Public facts only

❌ No trust score

❌ No accept/reject label

6. Endorse Identity

Actor: Identity Owner (Endorser)

Flow:

User selects:

fromId (their identity)

toId (target identity)

Calls
endorse(fromId, toId)

Protocol emits
Endorsed(fromId, toId)

On-chain State:

Endorsement recorded permanently

UI:

Shows endorsement link

Timestamp visible

7. Revoke Endorsement

Actor: Endorser

Flow:

User calls
revokeEndorsement(fromId, toId)

Protocol emits
EndorsementRevoked(fromId, toId)

Important:

Revocation ≠ deletion

History remains immutable

UI:

Shows endorsement as revoked

Previous endorsement still visible

8. Signal Compromise / Revocation

Actor: Identity Owner

Flow:

User calls
markCompromised(tokenId)

Protocol emits
IdentityCompromised(tokenId)

Effect:

Identity remains readable

Compromise signal becomes permanent

Future endorsements may be blocked (contract-level rule)

UI:

Status changes to Compromised

Warning banner displayed

9. Wallet Rotation (Identity Transfer)

Actor: Identity Owner

Flow:

User transfers Identity NFT to a new wallet

Ownership updated on-chain

On-chain State:

Identity persists

History remains intact

UI:

Owner address updated

Identity continuity preserved

10. External Verification & Trust Decision

Actor: External Application / Organization

Flow:

External system:

Reads identity token data

Reads endorsements and revocations

Reads compromise signals

Applies its own trust rules

Makes independent decision

Possible Outcomes:

Accept

Reject

Manual Review

