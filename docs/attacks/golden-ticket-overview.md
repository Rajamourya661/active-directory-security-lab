# Golden Ticket (Overview) — Optional Module

Forge TGTs using the **krbtgt** account hash after domain compromise. Advanced module for understanding persistence and detection—run only in isolated lab.

## MITRE ATT&CK

- [T1558.001 – Steal or Forge Kerberos Tickets: Golden Ticket](https://attack.mitre.org/techniques/T1558/001/)

## Prerequisites

- Compromised **krbtgt** NTLM hash (e.g., from DCSync)
- Domain SID, domain FQDN
- Tools: Mimikatz `kerberos::golden`, Rubeus `diamond` / golden ticket variants

## Lab notes

Golden ticket attacks are **destructive to detect and remediate**. Prefer documenting detection and **krbtgt double-reset** over repeated lab execution.

## Detection

| Signal | Detail |
|--------|--------|
| MDI | Suspected Golden Ticket usage |
| 4769 / 4624 | Anomalies: TGT lifetime, encryption anomalies, missing PAC |
| Operational | Two krbtgt resets required for remediation |

## Hardening / remediation

See [../hardening/kerberos-hardening.md](../hardening/kerberos-hardening.md) — **krbtgt rotation** section.

## Status

⬜ Optional — complete after DCSync module or as tabletop exercise.
