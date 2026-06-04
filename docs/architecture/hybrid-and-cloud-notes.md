# Hybrid and Cloud Notes

How on-prem AD lab techniques relate to **Entra ID (Azure AD)** and hybrid deployments.

## Scope

This lab is **on-prem AD** focused. Use this page when extending to hybrid or explaining interviews.

## Technique vs environment

| Technique | On-prem AD lab | Entra ID / hybrid |
|-----------|----------------|-------------------|
| Kerberoasting | Yes — KDC issues TGS | N/A in pure cloud; hybrid user sync does not roast Entra |
| AS-REP roast | Yes — `DoesNotRequirePreAuth` on AD user | Fix on-prem; cloud auth separate |
| Password spray | 4625 on DC / NTLM / Kerberos | Entra **Sign-in logs**, Smart Lockout, CA policies |
| BloodHound | AD CS, ACLs, sessions | **BloodHound CE** for Entra + on-prem |
| DCSync | On-prem DC | Cloud-only tenants: different paths |

## MFA does not fix on-prem Kerberos abuse

Interactive MFA protects many **cloud** apps. **Kerberoasting** abuses service tickets from the on-prem KDC. Harden AD service accounts and monitor 4769 regardless of Entra MFA.

## Recommended hybrid hardening

- **Entra Password Protection** — block common passwords in cloud + hybrid agents
- **Conditional Access** — require MFA for admins
- **MDI** — AD-specific detections ([../detection/defender-identity-notes.md](../detection/defender-identity-notes.md))
- **Disable legacy auth** in Entra where possible (does not remove on-prem Kerberos)

## Lab extension (optional)

- Azure AD Connect VM on lab VLAN (isolated)
- Sync subset of users; observe spray in **Sign-in logs** vs 4625

## References

- [Microsoft Entra hybrid identity](https://learn.microsoft.com/entra/identity/hybrid/)
