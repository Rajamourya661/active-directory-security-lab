# Attack Playbooks (Lab Only)

Step-by-step notes for **authorized** Active Directory attack techniques used in this lab. Pair each playbook with detection and hardening docs.

## Authorization

Execute only on lab domains you control. Document scope, snapshots, and rollback before running tooling.

## Core playbooks

| Technique | Document | MITRE |
|-----------|----------|-------|
| BloodHound / SharpHound | [bloodhound-recon.md](bloodhound-recon.md) | T1087, T1069, T1482 |
| Kerberoasting | [kerberoasting.md](kerberoasting.md) | T1558.003 |
| AS-REP Roasting | [asrep-roasting.md](asrep-roasting.md) | T1558.004 |
| Password spraying | [password-spraying.md](password-spraying.md) | T1110.003 |
| ACL / path abuse | [acl-abuse-overview.md](acl-abuse-overview.md) | T1098 |

## Advanced / roadmap

| Technique | Document | Status |
|-----------|----------|--------|
| AD Certificate Services | [ad-cs-overview.md](ad-cs-overview.md) | Planned (v0.2) |
| DCSync | [dcsync-overview.md](dcsync-overview.md) | Optional |
| Golden ticket | [golden-ticket-overview.md](golden-ticket-overview.md) | Optional |

## Workflow

1. **Recon** — BloodHound, LDAP ([threat model](../architecture/threat-model.md))
2. **Execute** — Controlled attack playbook
3. **Capture** — Screenshots (gitignored hashes/exports)
4. **Detect** — Validate [../detection/](../detection/) + [sigma/](../detection/sigma/)
5. **Harden** — [../hardening/](../hardening/) and re-test

## Tooling

- [BloodHound](https://github.com/BloodHoundAD/BloodHound) / SharpHound
- [Impacket](https://github.com/fortra/impacket) — `GetUserSPNs.py`, `GetNPUsers.py`, `secretsdump.py`
- [Rubeus](https://github.com/GhostPack/Rubeus)
- CrackMapExec (password spray — lab only)

Verify syntax against current tool versions before running.
