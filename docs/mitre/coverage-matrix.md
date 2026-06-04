# MITRE ATT&CK Coverage Matrix

Lab coverage for Active Directory techniques. Update status as you complete purple-team cycles.

**Legend:** ✅ Complete · 🔄 In progress · ⬜ Planned · 🔒 Optional / roadmap

| ID | Name | Tactic | Attack doc | Detection | Hardening | Status |
|----|------|--------|------------|-----------|-----------|--------|
| T1087.002 | Domain Account | Discovery | [bloodhound-recon](../attacks/bloodhound-recon.md) | [bloodhound-indicators](../detection/bloodhound-indicators.md) | [tiering](../hardening/tiering-and-admin.md) | ⬜ |
| T1069.002 | Domain Groups | Discovery | bloodhound-recon | bloodhound-indicators | tiering-and-admin | ⬜ |
| T1482 | Domain Trust Discovery | Discovery | bloodhound-recon | bloodhound-indicators | — | ⬜ |
| T1558.003 | Kerberoasting | Credential Access | [kerberoasting](../attacks/kerberoasting.md) | [kerberoast-detection](../detection/kerberoast-detection.md) | [kerberos-hardening](../hardening/kerberos-hardening.md) | ⬜ |
| T1558.004 | AS-REP Roasting | Credential Access | [asrep-roasting](../attacks/asrep-roasting.md) | [asrep-detection](../detection/asrep-detection.md) | [account-hygiene](../hardening/account-hygiene.md) | ⬜ |
| T1110.003 | Password Spraying | Credential Access | [password-spraying](../attacks/password-spraying.md) | [password-spray-detection](../detection/password-spray-detection.md) | [account-hygiene](../hardening/account-hygiene.md) | ⬜ |
| T1098 | Account Manipulation | Persistence | [acl-abuse-overview](../attacks/acl-abuse-overview.md) | [detection-use-cases](../detection/detection-use-cases.md) | tiering-and-admin | ⬜ |
| T1484.001 | Group Policy Modification | Defense Evasion | acl-abuse-overview | 5136 / GPO audit | [auditing-baseline](../hardening/auditing-baseline.md) | ⬜ |
| T1021.002 | SMB/Admin Shares | Lateral Movement | — | 5140 / 4688 | tiering-and-admin | 🔒 Roadmap |
| T1003.006 | DCSync | Credential Access | [dcsync-overview](../attacks/dcsync-overview.md) | AD-DC-006, MDI | tiering-and-admin | 🔒 Optional |
| T1558.001 | Golden Ticket | Credential Access | [golden-ticket-overview](../attacks/golden-ticket-overview.md) | AD-DC-007, MDI | [kerberos-hardening](../hardening/kerberos-hardening.md) | 🔒 Optional |
| T1649 | Steal or Forge Certificates | Credential Access | [ad-cs-overview](../attacks/ad-cs-overview.md) | CA logs, MDI | AD CS hardening | 🔒 v0.2 |

## Tactic summary

| Tactic | Count (core + optional) |
|--------|-------------------------|
| Discovery | 3 |
| Credential Access | 6 (incl. optional) |
| Persistence | 1 |
| Defense Evasion | 1 |
| Lateral Movement | 1 (roadmap) |

## Navigator layer

Import **[navigator-layer.json](navigator-layer.json)** into [ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/). Update technique IDs when MITRE releases new versions.

## Out of scope (v0.1)

- Pass-the-Hash / Pass-the-Ticket (T1550) — add in v0.3
- NTLM relay / PetitPotam — add with AD CS / relay module
