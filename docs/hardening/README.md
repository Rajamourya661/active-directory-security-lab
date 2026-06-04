# Hardening

Defensive controls applied after attack and detection exercises.

## Phases

```
Phase 1: Visibility   → auditing-baseline + WEF
Phase 2: Credentials  → kerberos-hardening + account-hygiene
Phase 3: Structure    → tiering-and-admin + LAPS
Phase 4: Validate     → re-run attacks; expect detect-only or failure
```

## Contents

| Document | Focus |
|----------|--------|
| [kerberos-hardening.md](kerberos-hardening.md) | SPNs, gMSA, AES, krbtgt, LDAP signing |
| [account-hygiene.md](account-hygiene.md) | Pre-auth, spray, honey accounts |
| [tiering-and-admin.md](tiering-and-admin.md) | Tiering, AdminSDHolder, NTLM restrict |
| [laps-implementation.md](laps-implementation.md) | Windows / legacy LAPS steps |
| [auditing-baseline.md](auditing-baseline.md) | GPO audit + SACLs |

## Measurement

| Metric | Before | After |
|--------|--------|-------|
| Kerberoastable users (BloodHound) | | |
| AS-REP roastable users | | |
| Shortest paths to DA | | |
| MTTD Kerberoast (min) | | |

Record in [../portfolio/project-summary.md](../portfolio/project-summary.md).

## Scripts

- [Export-SecurityBaseline.ps1](../../scripts/Export-SecurityBaseline.ps1) — export GPO/audit settings before and after
