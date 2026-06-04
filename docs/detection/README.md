# Detection Engineering

Blue-team content for identifying AD attack techniques in the lab SIEM or native event logs.

## Philosophy

1. **Telemetry first** — WEF or agent forwarding before attacks.
2. **Correct field semantics** — e.g., 4769 `Account Name` = service account, not attacker; pivot on `Client Address`.
3. **Chain events** — Combine DC, endpoint, and identity alerts (MDI).
4. **Validate in lab** — Measure MTTD; document false positives.

## Contents

| Document | Focus |
|----------|--------|
| [log-sources.md](log-sources.md) | Windows events, audit policy |
| [kerberoast-detection.md](kerberoast-detection.md) | 4769 + Splunk/KQL |
| [asrep-detection.md](asrep-detection.md) | 4768 + proactive AD query |
| [password-spray-detection.md](password-spray-detection.md) | 4625 correlation |
| [bloodhound-indicators.md](bloodhound-indicators.md) | LDAP / process / network |
| [defender-identity-notes.md](defender-identity-notes.md) | MDI vs custom rules |
| [detection-use-cases.md](detection-use-cases.md) | Master register |
| [sigma/](sigma/) | Exportable Sigma YAML |

## MITRE mapping

[../mitre/coverage-matrix.md](../mitre/coverage-matrix.md)

## Suggested SIEM stack

- Microsoft Sentinel / Defender for Identity
- Splunk (ESCU)
- Elastic + Sigma

## Purple-team loop

```
Attack playbook → Raw event on DC → SIEM rule → Tune FP → Harden → Re-attack
```

Document each cycle in [CHANGELOG.md](../../CHANGELOG.md).
