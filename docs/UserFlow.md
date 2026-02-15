# Mini DIT Prototype – User Flow

This document describes the **user flow for the Mini DIT prototype UI**.  
The UI interacts with the Mini DIT protocol and reflects on-chain facts only.  
No trust judgement is made by the UI itself.

---

## 🧭 Flow Diagram

```mermaid
flowchart TB

%% ====================
%% USER ACTIONS
%% ====================
subgraph USER["User"]
    U1[Open Mini DIT App]
    U2[Connect Wallet]
    U3[View My Identity]
    U4[Create Identity]
    U5[Edit Identity Claims]
    U6[View Other Identity]
    U7[Endorse Identity]
    U8[Revoke Endorsement]
    U9[Mark Identity as Compromised]
end

%% ====================
%% UI SCREENS
%% ====================
subgraph UI["UI Screens"]
    S1[Landing / Connect Wallet]
    S2[My Identity Card]
    S3[Identity Form (Create/Edit)]
    S4[Identity Details (Other)]
    S5[Endorsement List View]
end

%% ====================
%% CONTRACT CALLS
%% ====================
subgraph CONTRACT["On-Chain Protocol"]
    C1[mintIdentity(name, ...)]
    C2[addClaims]
    C3[endorse(fromId,toId)]
    C4[revokeEndorsement(fromId,toId)]
    C5[markCompromised(tokenId)]
end

%% ====================
%% FLOWS
%% ====================

%% User -> Wallet
U1 --> S1
S1 --> U2
U2 --> S2

%% My Identity
S2 -->|No Identity| S3
S3 --> C1
C1 --> S2

S2 --> U5 --> S3
S3 --> C2 --> S2

%% View Others
S2 --> U6 --> S4

S4 --> U7 --> C3 --> S5
S4 --> U8 --> C4 --> S5
S4 --> U9 --> C5 --> S4
