# Domain Design

Organizational structure and object placement for realistic attack and defense scenarios.

## Forest and Domain

- **Single forest, single domain** recommended for initial portfolio scope.
- Optional child domain or trust later for advanced paths (external trust, SID history).

## Organizational Units

```
corp.lab.local
├── OU=Tier0,DC=corp,DC=lab,DC=local          # Domain Admins, DCs (no interactive logon to Tier1/2)
├── OU=Tier1,DC=corp,DC=lab,DC=local          # Server admins, service operators
├── OU=Tier2,DC=corp,DC=lab,DC=local          # Workstation admins (if used)
├── OU=Users,DC=corp,DC=lab,DC=local
├── OU=Servers,DC=corp,DC=lab,DC=local
├── OU=Workstations,DC=corp,DC=lab,DC=local
└── OU=ServiceAccounts,DC=corp,DC=lab,DC=local
```

## Sample Accounts (Lab Only)

| Account | Purpose | Intentional weakness (for exercises) |
|---------|---------|--------------------------------------|
| `svc_sql` | SQL service | Weak password + SPN for Kerberoast |
| `svc_web` | IIS app pool | SPN on SRV01 |
| `jdoe` | Standard user | Member of helpdesk-like group |
| `asmith` | Helpdesk | ACLs for reset password / write SPn (optional) |
| `krbtgt` | — | Monitor golden ticket detection only in advanced labs |

**Rotate and randomize** passwords in your lab; never reuse table values in production.

## Groups

| Group | Members | Use case |
|-------|---------|----------|
| `Corp-IT-Helpdesk` | `asmith` | ACL abuse / targeted Kerberos |
| `Corp-SQL-Admins` | `svc_sql` owner | Privilege path documentation |
| `Domain Admins` | Break-glass only | Tier 0; minimal count |

## Service Principal Names (SPNs)

Document SPNs registered for detection tuning:

```
HOST/SRV01.corp.lab.local
MSSQLSvc/SRV01.corp.lab.local:1433
HTTP/SRV01.corp.lab.local
```

Use `setspn -L corp\svc_sql` after creation to verify.

## GPO Scope

| GPO name | Linked OU | Purpose |
|----------|-----------|---------|
| `Baseline-Security` | Domain | Auditing, LSA protection (when hardened) |
| `Tier0-Logon-Restrictions` | Tier0 | Deny logon to lower tiers |
| `Vuln-Lab-Kerberos` | ServiceAccounts | **Lab only:** weak encryption types for roast demos |

Remove vuln GPOs before showcasing hardening outcomes.

## DNS and Naming

- Computer names match [lab-topology.md](lab-topology.md).
- Avoid `.local` in production (mDNS conflicts); acceptable in isolated labs with documentation.
