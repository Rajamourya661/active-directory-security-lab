# DCSync (Overview) — Optional Module

Simulate replication abuse to retrieve password hashes (DRSUAPI). **Advanced lab only** after core Kerberos modules.

## MITRE ATT&CK

- [T1003.006 – OS Credential Dumping: DCSync](https://attack.mitre.org/techniques/T1003/006/)

## Requirements

- Compromised account with **Replicating Directory Changes** / **All** rights (e.g., Domain Admin, or misconfigured ACL)
- Tools: Mimikatz `lsadump::dcsync`, Impacket `secretsdump.py`

## Lab execution (authorized)

```bash
# Example — lab only
impacket-secretsdump 'CORPLAB/jdoe:Password123!@DC01.corp.lab.local' -just-dc
```

## Detection

| Source | Signal |
|--------|--------|
| MDI | Suspected DCSync attack (primary in enterprise) |
| 4662 | Directory service access with replication GUIDs |
| 4624 | Privileged logon on DC from unusual host |

See [../detection/detection-use-cases.md](../detection/detection-use-cases.md) AD-DC-006.

## Hardening

- Tier 0 only on DCs; no unnecessary replication rights
- Monitor AdminSDHolder / privileged group membership
- [tiering-and-admin.md](../hardening/tiering-and-admin.md)

## Status

⬜ Optional — enable when Tier 0 compromise scenario is in scope.
