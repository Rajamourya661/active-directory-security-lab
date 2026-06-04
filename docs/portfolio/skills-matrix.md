# Skills Matrix

Map lab work to job-relevant skills with evidence pointers.

| Skill | Proficiency | Evidence in repo |
|-------|-------------|------------------|
| Active Directory security | | `docs/architecture/`, `docs/hardening/` |
| Kerberos attacks & defenses | | `docs/attacks/kerberoasting.md`, `docs/hardening/kerberos-hardening.md` |
| BloodHound / attack path analysis | | `docs/attacks/bloodhound-recon.md` |
| Detection engineering (Windows) | | `docs/detection/`, Events 4768/4769/4625 |
| Sigma / SIEM query writing | | `docs/detection/sigma/`, Splunk/KQL in detection docs |
| Password spray / lockout awareness | | `docs/attacks/password-spraying.md` |
| Microsoft Defender for Identity | | `docs/detection/defender-identity-notes.md` |
| MITRE ATT&CK mapping | | `docs/mitre/coverage-matrix.md` |
| PowerShell automation | | `scripts/` |
| Security documentation | | Entire `docs/` tree |
| Risk remediation / hardening | | `docs/hardening/` |
| Ethical hacking / lab scope | | Root README ethics section |

## Proficiency Key

- **Foundational** — Followed guide, completed once  
- **Proficient** — Tuned detections, measured outcomes  
- **Advanced** — Extended lab (DCSync, golden ticket, custom rulesets)

## Role Alignment

| Role | Highlight |
|------|-----------|
| SOC Analyst | Detection use cases, 4769 tuning, alert validation |
| Detection Engineer | Sigma starters, log sources, FP tuning narrative |
| Pentester / Red Team | Attack playbooks, BloodHound paths (authorized) |
| Identity / AD Admin | Tiering, gMSA, GPO audit baseline |

Update proficiency column as you complete each module.
