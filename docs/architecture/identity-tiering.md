# Identity Tiering

Administrative tier model aligned with Microsoft **Enterprise Access Model** (Tier 0 / 1 / 2) for the lab.

## Tier Definitions

| Tier | Assets | Example accounts | Logon restrictions |
|------|--------|------------------|-------------------|
| **0** | Domain controllers, AD, PKI | `DA-*`, `AD-Admin-*` | No logon to Tier 1/2 systems except jump break-glass |
| **1** | Member servers, apps | `SA-*`, `SQL-Admin-*` | No logon to Tier 2 workstations for daily use |
| **2** | Workstations | `WA-*`, helpdesk | No admin rights on servers or DCs |

## Jump Host Pattern

```
[ Admin ] --> WS02 (Tier 0 jump) --> DC01 / DC02 only
[ Server admin ] --> dedicated mgmt host --> SRV01
```

- Enable **Restricted Admin** / RDP hardening on jumps.
- No email or web browsing on Tier 0 jumps.

## Protected Users (Hardening Phase)

After attack exercises, enroll Tier 0 accounts into **Protected Users** group where supported:

- No NTLM, no DES, no unconstrained delegation caching (varies by OS).
- Document break-glass procedure if lockout occurs.

## BloodHound Implications

Tier violations appear as:

- Shortest paths crossing tier boundaries via ACLs or sessions.
- `AdminTo`, `MemberOf`, `CanRDP`, `HasSession` edges.

Capture graphs before and after tiering remediation for portfolio comparison.

## Lab Exercise

1. Map current admins with BloodHound (pre-tiering).
2. Implement OU + GPO deny logon rights.
3. Re-ingest data and compare path count to Domain Admins.

See [../hardening/tiering-and-admin.md](../hardening/tiering-and-admin.md).
