# Mini DIT – User Flow

This document describes the explicit user flow exposed by the Mini DIT protocol.
The UI reflects protocol facts only; interpretation is left to external systems.

---

## 1. Mint Identity
Actor: User

Flow:
- User connects wallet
- Calls `mintIdentity(name, github, linkedin, ageGroup)`
- Protocol emits `IdentityMinted(id, owner)`

UI:
- Shows Identity Token ID
- Shows status: Active / Compromised

---

## 2. View Identity (Read-only)
Actor: Any user

Flow:
- Fetch identity data by tokenId
- Read:
  - owner
  - compromised flag
  - endorsements in/out

UI:
- Identity card
- No trust score
- No validity judgment

---

## 3. Endorse Identity
Actor: Identity owner

Flow:
- User selects `fromId` and `toId`
- Calls `endorse(fromId, toId)`
- Protocol emits `Endorsed(fromId, toId)`


---

## 4. Revoke Endorsement
Actor: Endorser

Flow:
- User calls `revokeEndorsement(fromId, toId)`
- Protocol emits `EndorsementRevoked(fromId, toId)`

Note:
- Revocation ≠ deletion
- History remains visible

---

## 5. Signal Compromise
Actor: Identity owner

Flow:
- User calls `markCompromised(tokenId)`
- Protocol emits `IdentityCompromised(id)`

Effect:
- Identity remains readable
- Future endorsements blocked (if enforced — see contract)
