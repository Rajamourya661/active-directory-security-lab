# Account Hygiene

Reduce AS-REP roasting, password spraying, and stale account risk.

## Pre-authentication (AS-REP)

```powershell
Get-ADUser -Filter {DoesNotRequirePreAuth -eq $true} -Properties DoesNotRequirePreAuth |
  ForEach-Object {
    Set-ADAccountControl -Identity $_.SamAccountName -DoesNotRequirePreAuth $false
  }
```

Schedule daily count; alert if &gt; 0 outside break-glass. See [../detection/asrep-detection.md](../detection/asrep-detection.md).

## Password policy

| Setting | Target |
|---------|--------|
| Minimum length | 14+ users, 25+ service accounts |
| Complexity | Enabled |
| Fine-grained PSO | Stricter policy on `OU=ServiceAccounts` |

## Password spraying resistance

| Control | Implementation |
|---------|----------------|
| Lockout threshold | Low enough to block spray; document in lab (e.g., 5 / 30 min) |
| Honey account | `svc_honey` — alert on any 4625 ([detection](../detection/password-spray-detection.md)) |
| Entra Password Protection | Hybrid: block common passwords ([hybrid notes](../architecture/hybrid-and-cloud-notes.md)) |
| No password reuse | Training + technical policy |

## Smart card / MFA

- Tier 0: smart card or phishing-resistant MFA where simulated.
- Hybrid: Entra CA for admin roles — does **not** replace Kerberoast monitoring on-prem.

## Stale accounts

```powershell
$days = 90
Get-ADUser -Filter * -Properties LastLogonDate |
  Where-Object { $_.LastLogonDate -lt (Get-Date).AddDays(-$days) } |
  Select-Object Name, SamAccountName, LastLogonDate
```

## AdminSDHolder / protected groups

- Monitor membership in Domain Admins, Enterprise Admins, Schema Admins.
- Event **4728** / **4729** / **4732** (group member changes) with alerts.
- Run BloodHound after any helpdesk ACL change.

## Checklist

- [ ] Zero `DoesNotRequirePreAuth` accounts
- [ ] Honey account + spray detection tested
- [ ] Service passwords rotated post-attack phase
- [ ] Guest / default accounts disabled
- [ ] DA count ≤ 2 break-glass in lab
