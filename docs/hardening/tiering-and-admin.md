# Tiering and Admin Hardening

Implement administrative tier separation per [../architecture/identity-tiering.md](../architecture/identity-tiering.md).

## Group hygiene

| Practice | Action |
|----------|--------|
| No nested DA paths | Remove helpdesk from groups with transitive DA membership |
| Split accounts | `jdoe` vs `jdoe-adm` — no email/web on Tier 0 |
| Protected groups | Alert on 4728/4732 for Domain Admins |

## AdminSDHolder

- Protected groups receive **AdminSDHolder** ACL reset every 60 minutes (default).
- Do not rely on manual ACL fixes without addressing **source** mis-delegation.
- Audit **5136** on `CN=AdminSDHolder,CN=System,...` in advanced scenarios.

## GPO: deny logon

On Tier 2 workstation OUs:

- **Deny log on locally** / **Deny log on through RDS** — include `Domain Admins`
- Document break-glass account excluded from deny policies

## LAPS (local administrator password solution)

| Option | Notes |
|--------|-------|
| **Windows LAPS** (Server 2025+ / client policy) | Preferred for greenfield |
| **Legacy Microsoft LAPS** | GPO + AD computer attribute |

Steps (lab):

1. Extend schema / install LAPS policy (per Microsoft doc for your version).
2. Deploy GPO to `OU=Workstations` and `OU=Servers`.
3. Verify unique password per host via authorized retrieval tool.

Reduces lateral movement via shared local admin passwords.

## Remote management

- **JEA** for helpdesk instead of broad `GenericAll`.
- Remove dangerous ACEs from BloodHound report.

## NTLM restriction

`RestrictSendingNTLMTraffic` / `RestrictReceivingNTLMTraffic` — test app impact in lab before production-style rollout.

## Validation

1. BloodHound ingest post-hardening.
2. Compare shortest paths to Domain Admins (before vs after).
3. Lateral movement from WS01 should fail or hit detection.

## CIS / benchmark mapping (summary)

| CIS Control (IG1+) | Lab control |
|--------------------|-------------|
| 5.4 Restrict admin privileges | Tiering |
| 6.8 Role-based access | JEA / ACL cleanup |
| 8.2 Collect audit logs | [auditing-baseline.md](auditing-baseline.md) |

Full CIS AD benchmarks: use as checklist when extending portfolio.
