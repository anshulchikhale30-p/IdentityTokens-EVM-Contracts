flowchart TB

subgraph WALLET["Wallet"]
    W1[Open DIT App]
    W2[Connect Wallet]
end

subgraph OVERVIEW["Overview"]
    O1[Protocol Summary]
    O2[Check Identity Status]
end

subgraph ONBOARDING["Onboarding"]
    OB1{Has Identity?}
    OB2[Mint Identity NFT]
end

subgraph DASHBOARD["Dashboard"]
    D1[View Identity Card]
    D2[View Metadata]
    D3[View Endorsements In / Out]
    D4[View Compromise Status]
end

subgraph MANAGE["Manage Identity"]
    M1[Add / Update Claims]
    M2[Transfer Identity NFT]
end

subgraph ENDORSE["Endorsements"]
    E1[Browse Other Identities]
    E2[Endorse Identity]
    E3[Revoke Endorsement]
end

subgraph SIGNALS["Revocation & Signals"]
    S1[Mark Identity Compromised]
    S2[View Revocation History]
end

W1 --> W2 --> O1 --> O2 --> OB1
OB1 -->|No| OB2 --> D1
OB1 -->|Yes| D1

D1 --> D2 --> D3 --> D4

D1 --> M1 --> D1
M1 --> M2 --> D1

D1 --> E1 --> E2 --> D3
E2 --> E3 --> D3

D1 --> S1 --> S2 --> D4


D1 --> S1 --> S2 --> D4
