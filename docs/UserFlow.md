flowchart TB

%% ======================
%% WALLET
%% ======================
subgraph WALLET["Wallet"]
    W1[Open DIT App]
    W2[Connect Wallet]
end

%% ======================
%% OVERVIEW
%% ======================
subgraph OVERVIEW["Overview"]
    O1[View Protocol Summary]
    O2[Check Identity Status]
end

%% ======================
%% ONBOARDING
%% ======================
subgraph ONBOARDING["Onboarding"]
    OB1{Has Identity?}
    OB2[Mint Identity NFT]
end

%% ======================
%% DASHBOARD
%% ======================
subgraph DASHBOARD["Dashboard"]
    D1[View Identity Card]
    D2[View Metadata]
    D3[View Endorsements In / Out]
    D4[View Compromise Status]
end

%% ======================
%% MANAGE IDENTITY
%% ======================
subgraph MANAGE["Manage Identity"]
    M1[Add / Update Claims]
    M2[Transfer Identity NFT]
end

%% ======================
%% ENDORSEMENTS
%% ======================
subgraph ENDORSE["Endorsements"]
    E1[Browse Other Identities]
    E2[Endorse Identity]
    E3[Revoke Endorsement]
end

%% ======================
%% REVOCATION & SIGNALS
%% ======================
subgraph SIGNALS["Revocation & Signals"]
    S1[Mark Identity Compromised]
    S2[View Revocation History]
end

%% ======================
%% FLOW
%% ======================
W1 --> W2 --> O1 --> O2 --> OB1
OB1 -->|No| OB2 --> D1
OB1 -->|Yes| D1

D1 --> D2 --> D3 --> D4

D1 --> M1 --> D1
M1 --> M2 --> D1

D1 --> E1 --> E2 --> D3
E2 --> E3 --> D3

D1 --> S1 --> S2 --> D4
