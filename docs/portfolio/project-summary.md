# Project Summary

**Project:** Active Directory Security Lab  
**Author:** _[Your Name]_  
**Role:** _[e.g., SOC Analyst / Security Engineer]_  
**Dates:** _[Start – End]_  
**Repository:** _[GitHub URL]_

## Elevator pitch

Built an isolated AD lab and ran full **purple-team cycles**: Kerberoasting, AS-REP roasting, and password spraying against intentional misconfigurations; engineered **4769/4768/4625** detections with Sigma + Splunk/KQL; hardened with gMSA, tiering, and audit baselines; mapped techniques to **MITRE ATT&CK** with measurable before/after metrics.

## Objectives completed (check when done)

- [ ] Lab deployed per [lab-topology.md](../architecture/lab-topology.md)
- [ ] WEF/SIEM ingesting DC Security log
- [ ] P1 detections validated (Kerberoast, AS-REP, spray)
- [ ] Hardening applied and attacks re-tested
- [ ] MITRE matrix statuses updated to ✅
- [ ] 3+ redacted screenshots in `screenshots/`

## Key results (fill with your data)

| Metric | Before | After |
|--------|--------|-------|
| Kerberoast MTTD (minutes) | | |
| AS-REP vulnerable accounts | | 0 |
| Password spray alert triggered | No | Yes |
| BloodHound paths to DA | | |
| Kerberoastable users (BloodHound) | | |

## Technical highlights for recruiters

1. **4769 semantics** — Detections keyed on `IpAddress` (attacker host), not `Account Name` (service account).
2. **Defense in depth** — Detection still fires after gMSA/long-password hardening even when crack fails.
3. **Sigma + SIEM** — Rules in `docs/detection/sigma/` converted to your platform.
4. **Optional MDI** — Compared custom 4769 rule with Defender for Identity alert.

## Artifacts

| Type | Location |
|------|----------|
| Playbooks | `docs/attacks/` |
| Detections | `docs/detection/`, `docs/detection/sigma/` |
| MITRE | `docs/mitre/coverage-matrix.md` |
| Evidence | `screenshots/` |

## Lessons learned (example — replace with yours)

_RC4 TGS volume per client was high-signal in the lab; AES-only roasting required lowering the SPN count threshold. Proactive `DoesNotRequirePreAuth` audit caught misconfig faster than 4768 alone._

## Ethics

All activity on self-built isolated VMs. No employer/production systems without written authorization.
