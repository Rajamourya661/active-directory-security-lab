# AD Certificate Services (Overview) — Roadmap

Optional advanced module for **ESC1–ESC8**-style attacks in the lab. Not required for core portfolio completion.

## Why AD CS matters

Misconfigured certificate templates are a common **real-world** path to domain admin, often surfaced by BloodHound (**Certipy** / **PKI** edges).

## Lab prerequisites

- `DC01` or dedicated `CA01` with AD CS role
- Web Enrollment (only if simulating specific ESC scenarios)
- BloodHound CE with PKI collection

## Planned exercises (v0.2)

| Item | Technique | MITRE |
|------|-----------|-------|
| ESC1 | Misconfigured template EKU | T1649 |
| ESC8 | NTLM relay to HTTP enrollment | T1557 |

## Detection pointers

- MDI PKI-related alerts
- Event logs on CA server
- Certipy output → document in `screenshots/`

## Hardening pointers

- Restrict enrollment agents
- Disable NTLM on CA web enrollment where possible
- [MITRE CA best practices](https://learn.microsoft.com/windows-server/identity/ad-cs/ad-cs-security-guidance)

## Status

⬜ **Planned** — add full playbook when CA is deployed in your lab.
