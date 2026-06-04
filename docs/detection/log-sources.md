# Log Sources

Minimum telemetry for AD attack detection in the security lab.

## Domain Controllers (Critical)

| Log | Events / categories | Purpose |
|-----|---------------------|---------|
| Security | 4624, 4625, 4672, 4768, 4769, 4770, 4771 | Auth, Kerberos, privilege |
| Security | 5136, 5137, 5138, 5139, 5141 | AD object changes |
| Security | 4662 | Directory service access (SACL required) |
| Directory Service | — | Replication issues (less attack-focused) |

### Audit Policy (GPO)

Enable on DCs and members for lab:

- Audit Kerberos Authentication Service
- Audit Kerberos Service Ticket Operations
- Audit Logon
- Audit Account Logon
- Audit Directory Service Changes (with SACLs on sensitive OUs)

## Member Servers and Workstations

| Source | Notes |
|--------|-------|
| Security 4688 | Process creation (PowerShell, SharpHound) |
| PowerShell 4103/4104 | Script block logging (module logging optional) |
| Sysmon (optional) | Process, network, file — Microsoft Sysmon |

## LDAP / Network

- **4624** Type 3 from unexpected hosts to DC LDAP ports
- Firewall logs: spike in `389/636/3268` from single workstation
- DNS: large volume of SRV lookups (recon)

## Forwarding Architecture

```
[ DC / Members ] --WEF--> [ WEC / SIEM01 ] --parser--> [ Detections ]
```

Document subscription XML and agent config in your local notes (not committed if containing IPs/secrets).

## Retention

| Tier | Retention (lab suggestion) |
|------|----------------------------|
| Hot (SIEM) | 30 days |
| Warm | 90 days |
| Cold / export | 1 year for portfolio snapshots |

## Baseline Before Attacks

Capture 24–48 hours of **normal** lab activity to reduce false positives when tuning Kerberoast rules.
