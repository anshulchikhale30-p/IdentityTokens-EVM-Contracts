# Mini DIT – User Flow

This document describes the **explicit user flow** exposed by the Mini DIT protocol.

> The frontend reflects **protocol facts only**.  
> **Trust interpretation is delegated to external systems.**

---

## High-Level Flow Diagram

```mermaid
flowchart LR

%% =========================
%% USER
%% =========================
subgraph User
    A1[Visit DIT Frontend]
    A2[Connect Wallet]
    A3[Mint Identity NFT]
    A4[Add Identity Claims]
end

%% =========================
%% PROTOCOL (ON-CHAIN)
%% =========================
subgraph Protocol["DIT Protocol (On-Chain Source of Truth)"]
    P1[Identity NFT Stored On-Chain]
    P2[Identity Data Publicly Readable]
    P3[Endorsements Recorded]
    P4[Endorsements Revoked]
    P5[Compromise Signal Stored]
    P6[Identity Transferable]
end

%% =========================
%% EXTERNAL VERIFIERS
%% =========================
subgraph Verifier["External Applications / Verifiers"]
    V1[Read Identity Data]
    V2[Read Endorsements & Revocations]
    V3[Read Compromise Signals]
    V4[Apply Own Trust Rules]
    V5{Trust Decision}
    V6[Accept]
    V7[Reject]
    V8[Manual Review]
end

%% USER FLOW
A1 --> A2 --> A3 --> A4 --> P1
P1 --> P2

%% ENDORSEMENT FLOW
P2 --> P3 --> P4 --> P5 --> P6

%% VERIFIER FLOW
P1 --> V1
P3 --> V2
P4 --> V2
P5 --> V3
V1 --> V4
V2 --> V4
V3 --> V4
V4 --> V5
V5 -->|Accept| V6
V5 -->|Reject| V7
V5 -->|Manual Review| V8

