# Password Spraying

Attempt one or few common passwords against many accounts to avoid per-account lockout thresholds.

## Objective

Demonstrate low-and-slow credential guessing against AD (lab only) and validate lockout-aware detection.

## MITRE ATT&CK

- [T1110.003 – Brute Force: Password Spraying](https://attack.mitre.org/techniques/T1110/003/)

## How it works

1. Attacker harvests usernames (LDAP, OSINT, `enum4linux`, email format).
2. Tries **one password** (e.g., `Spring2026!`) against all users.
3. Waits for lockout counter reset; repeats with next password.
4. Successful auth → 4624; failures → **4625**.

## Lab preconditions

- Domain password policy documented (lockout threshold, reset duration).
- Test users with **different** passwords; one intentional weak password on decoy account.
- **Disable or raise lockout** only if you accept resetting lab—prefer realistic thresholds.

## Execution examples (lab)

### CrackMapExec (from attacker VM)

```bash
crackmapexec smb 10.10.10.0/24 -u users.txt -p 'Spring2026!' --continue-on-success
```

### PowerShell (single DC validation — low volume)

```powershell
# Lab only — do not run against production
$users = Get-Content .\users.txt
$password = 'Spring2026!' | ConvertTo-SecureString -AsPlainText -Force
foreach ($u in $users) {
  $cred = New-Object PSCredential ("CORPLAB\$u", $password)
  # Test logon via Start-Process or ldap bind — prefer dedicated lab tools
}
```

Prefer dedicated tools; avoid custom scripts in production-like environments without safeguards.

## Success criteria

- [ ] One successful 4624 on decoy account
- [ ] Multiple 4625 from same source IP
- [ ] Detection [../detection/password-spray-detection.md](../detection/password-spray-detection.md) fires
- [ ] Lockout policy behaves as expected

## Detection

[../detection/password-spray-detection.md](../detection/password-spray-detection.md)

## Hardening

- Smart lockout / Entra Password Protection (hybrid)
- MFA for interactive users
- Honey accounts (`svc_honey`) — alert on any 4625/4624
- Disable legacy protocols where not needed

## Evasion

| Technique | Note |
|-----------|------|
| One attempt per user per day | Below lockout; needs longer baseline |
| Passwordless spray via Kerberos | Different event patterns |
| Targeted spray on admins only | Lower volume — watch 4625 on privileged OUs |

## Portfolio tip

Document lockout threshold math: `users_tested × attempts` vs `lockoutThreshold`.
