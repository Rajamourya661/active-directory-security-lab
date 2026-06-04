# Threat Model

Structured view of lab adversaries, assets, and controls for the AD Security Lab.

## Scope

- **In scope:** `corp.lab.local` forest, lab VLAN `10.10.10.0/24`, domain-joined systems
- **Out of scope:** Internet-facing apps, production tenant, physical security

## Assets

| Asset | Value | Impact if compromised |
|-------|-------|------------------------|
| Domain Admins / Tier 0 | Critical | Full domain control |
| Service accounts (SPNs) | High | Lateral movement, data access |
| User workstations | Medium | Initial access, credential theft |
| SIEM / WEF collector | High | Evidence tampering, blind SOC |
| AD CS (if deployed) | Critical | Certificate-based domain takeover |

## Threat actors

| Actor | Capability | Motivation (lab simulation) |
|-------|------------|------------------------------|
| External attacker | Low → High after foothold | Domain dominance |
| Malicious insider | Medium | Escalation, data exfil |
| Ransomware operator | High post-DA | Encrypt / double extort |

## Attack paths (summary)

```
Initial access (phish / spray / stolen creds)
    → Discovery (BloodHound)
    → Credential access (Kerberoast / AS-REP / DCSync)
    → Privilege escalation (ACL / group abuse)
    → Lateral movement (SMB / WinRM)
    → Impact (GPO / golden ticket — advanced modules)
```

## Controls matrix

| Control | Mitigates | Doc |
|---------|-----------|-----|
| Tiering + deny logon | DA path from workstations | [identity-tiering.md](identity-tiering.md) |
| Kerberos hardening | Kerberoast success | [../hardening/kerberos-hardening.md](../hardening/kerberos-hardening.md) |
| Account hygiene | AS-REP, spray | [../hardening/account-hygiene.md](../hardening/account-hygiene.md) |
| 4768/4769/4625 detections | Credential attacks | [../detection/](../detection/) |
| Auditing + SACLs | ACL abuse, tampering | [../hardening/auditing-baseline.md](../hardening/auditing-baseline.md) |
| Network isolation | External entry | [lab-topology.md](lab-topology.md) |

## Residual risks (after hardening)

- Low-and-slow roasting below thresholds
- Compromised Tier 0 jump host
- AD CS misconfiguration (if enabled without hardening)
- Insider with legitimate helpdesk ACLs

## Review cadence

Update this document when adding modules (AD CS, DCSync) or changing lab topology.
