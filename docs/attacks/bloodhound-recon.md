# BloodHound Reconnaissance

Graph-based Active Directory path discovery for privilege escalation and lateral movement planning.

## Objective

Identify attack paths to high-value targets (e.g., Domain Admins) using collected LDAP, session, and ACL data.

## MITRE ATT&CK

- [T1087 – Account Discovery](https://attack.mitre.org/techniques/T1087/)
- [T1069 – Permission Groups Discovery](https://attack.mitre.org/techniques/T1069/)
- [T1482 – Domain Trust Discovery](https://attack.mitre.org/techniques/T1482/)

## Prerequisites

- Domain user credentials (any authenticated user for default collection)
- SharpHound collector on lab workstation or attacker VM with LDAP/Kerberos to DC
- BloodHound GUI or BloodHound CE

## Collection (SharpHound)

Example from domain-joined lab host (adjust domain and output path):

```powershell
# PowerShell — example flags; verify SharpHound version syntax
.\SharpHound.exe -c All --domain corp.lab.local --zipfilename corp-lab-bh.zip
```

Collection methods:

| Method | Data |
|--------|------|
| `Group` | Group membership |
| `LocalAdmin` | Local admin rights (requires remote access or agent) |
| `Session` | Logged-on users (needs privileged collection or admin) |
| `ACL` | Dangerous ACEs |
| `Trusts` | Domain trusts |

## Analysis Queries (BloodHound)

| Query | Purpose |
|-------|---------|
| Find all Domain Admins | Baseline high-value group |
| Shortest Paths to Domain Admins | Primary portfolio visualization |
| Kerberoastable Users | Links to [kerberoasting.md](kerberoasting.md) |
| AS-REP Roastable Users | Links to [asrep-roasting.md](asrep-roasting.md) |
| Unconstrained Delegation | Delegation abuse planning |

## Expected Lab Outcomes

- Document at least one **non-obvious path** (e.g., `GenericAll` on user → `ForceChangePassword` → DA group).
- Export graph PNG to `screenshots/` (redacted).

## Detection

See [../detection/bloodhound-indicators.md](../detection/bloodhound-indicators.md) for LDAP enumeration and share access patterns.

## Attacker evasion

- Collect from **non-domain-joined** Linux with LDAP only (fewer 4688 signals on endpoints).
- Use **session-less** collection methods to reduce SMB noise (less complete graph).
- Split collection across days to evade volume thresholds.

## Defensive Notes

- Limit **authenticated LDAP** visibility where possible (difficult; focus on detecting mass enumeration).
- Tier admin accounts; remove unnecessary ACLs identified in graph.
- Regular **ACL audits** with BloodHound in blue-team mode.

## References

- [BloodHound Documentation](https://bloodhound.specterops.io/)
- SpecterOps: *Six Ways to Discover Domain Admin Attack Paths*
