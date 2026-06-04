# ACL Abuse Overview

Active Directory access control entries (ACEs) often grant non-obvious control paths exploited after BloodHound mapping.

## Objective

Understand common dangerous rights and how they chain toward domain dominance in the lab.

## MITRE ATT&CK (Selected)

| Abuse | Technique |
|-------|-----------|
| `GenericAll` / `WriteDacl` | [T1098 – Account Manipulation](https://attack.mitre.org/techniques/T1098/) |
| `ForceChangePassword` | T1098 |
| `AddMember` to privileged group | T1098 |
| GPO modification | [T1484 – Domain Policy Modification](https://attack.mitre.org/techniques/T1484/) |

## High-Value Rights

| Right | Impact |
|-------|--------|
| `GenericAll` on user | Reset password, set SPN, disable protections |
| `WriteOwner` | Take ownership, then modify ACL |
| `GenericWrite` on group | Add self to group |
| `WriteDACL` | Grant self further rights |
| `AllExtendedRights` | Includes `User-Force-Change-Password` |
| `WriteGPLink` on OU | Deploy malicious GPO |

## Lab Scenario Ideas

1. Helpdesk group with `ForceChangePassword` on `svc_sql` → Kerberoast path.
2. `GenericWrite` on `Corp-SQL-Admins` → nested group privilege.
3. Compromised user with `WriteGPLink` on `OU=Servers` → credential deployment via GPO.

Document your exact ACEs in `domain-design.md` when built.

## Enumeration

- BloodHound: **ACL Analysis** pre-built queries
- PowerView (lab): `Find-InterestingDomainAcl`
- `dsacls` / ADUC — Advanced Security for verification

## Remediation

- Remove unnecessary ACLs; use **Delegation Wizard** minimally.
- Enable **AdminSDHolder** monitoring for protected groups.
- Audit changes: Event **5136** (directory service object modified).

## Detection

Correlate **5136** with sensitive attribute changes (`servicePrincipalName`, `member`, `gpLink`).

See [../detection/detection-use-cases.md](../detection/detection-use-cases.md).

## Further Reading

- SpecterOps: *An ACE Up the Sleeve*
- Microsoft: Active Directory security best practices
