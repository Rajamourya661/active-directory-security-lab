# Kerberos Hardening

Mitigate Kerberoasting and related Kerberos abuse in the lab domain.

## Service accounts

| Control | Implementation |
|---------|----------------|
| Long passwords | 25+ random characters; password vault |
| gMSA | Use Group Managed Service Accounts on supported apps |
| SPN hygiene | One SPN owner; remove duplicate/unused SPNs |
| No domain admin as SPN owner | Service accounts tier 1 only |

```powershell
Get-ADUser -Filter {ServicePrincipalName -like "*"} -Properties ServicePrincipalName
```

## Protected Users (guidance)

| Account type | Recommendation |
|--------------|----------------|
| **Tier 0 human admins** | Enroll after compatibility testing |
| **Service accounts (e.g., svc_sql)** | Prefer **gMSA + long password** first; Protected Users can **break apps** (NTLM, delegation, session limits) |
| **Break-glass** | Document exception; enhanced monitoring |

```powershell
# Tier 0 admin example — not default for all service accounts
Add-ADGroupMember -Identity "Protected Users" -Members "jdoe-adm"
```

## Encryption

- Raise domain functional level for AES where supported.
- Phase out RC4 for service accounts after application testing.
- Monitor 4769: RC4 on user SPN accounts should trend to **zero**.

## Kerberos policy (GPO)

| Setting | Recommendation |
|---------|----------------|
| Maximum service ticket lifetime | Reduce if apps permit |
| Network security: Configure encryption types allowed for Kerberos | Prefer AES; remove DES/RC4 when safe |

## Delegation

- No **unconstrained delegation** on member servers.
- Prefer **resource-based constrained delegation** with explicit SPNs.
- BloodHound: remediate *Unconstrained Delegation* computers.

## LDAP signing and channel binding

Reduces NTLM relay to LDAP/AD CS (adjacent threats):

- Domain controller: require LDAP signing (GPO).
- Consider LDAP channel binding on supported clients.

## krbtgt rotation (golden ticket remediation)

After suspected golden ticket or Tier 0 compromise:

1. Reset **krbtgt** password **twice** (proper procedure per Microsoft guidance).
2. Document in CHANGELOG; expect full Kerberos ticket refresh.

## Post-hardening test

Re-run [../attacks/kerberoasting.md](../attacks/kerberoasting.md):

- [ ] Crack fails or impractical
- [ ] Detection still fires on attempt (defense in depth)
