# Detection Use Cases

Master table linking lab attacks, data sources, MITRE techniques, and rule files.

## Use case register

| ID | Name | Technique | Log sources | Rule / doc | Status |
|----|------|-----------|-------------|------------|--------|
| AD-DC-001 | Kerberoast – TGS volume per client | T1558.003 | 4769 | [kerberoast-detection.md](kerberoast-detection.md), [sigma/kerberoast-rc4-volume.yml](sigma/kerberoast-rc4-volume.yml) | Planned |
| AD-DC-002 | AS-REP – no pre-auth TGT | T1558.004 | 4768, AD query | [asrep-detection.md](asrep-detection.md), [sigma/asrep-no-preauth.yml](sigma/asrep-no-preauth.yml) | Planned |
| AD-DC-003 | SharpHound execution | T1087 / T1069 | 4688, 4104 | [bloodhound-indicators.md](bloodhound-indicators.md) | Planned |
| AD-DC-004 | LDAP mass enumeration | T1087 | 4662, network | [bloodhound-indicators.md](bloodhound-indicators.md) | Planned |
| AD-DC-005 | Sensitive AD object change | T1098 | 5136 | [log-sources.md](log-sources.md) | Planned |
| AD-DC-006 | DCSync | T1003.006 | 4662, MDI | [dcsync-overview](../attacks/dcsync-overview.md) | Optional |
| AD-DC-007 | Golden ticket indicators | T1558.001 | 4769, MDI | [golden-ticket-overview](../attacks/golden-ticket-overview.md) | Optional |
| AD-DC-008 | Password spraying | T1110.003 | 4625 | [password-spray-detection.md](password-spray-detection.md) | Planned |

Update **Status** to `Tuned`, `Lab-validated`, or `False positive` after purple-team runs.

## Priority matrix

| Likelihood (lab) | Impact | Priority |
|------------------|--------|----------|
| Kerberoast | High | P1 |
| AS-REP | High | P1 |
| Password spray | Medium | P1 |
| BloodHound | Medium | P2 |
| DCSync / Golden | Critical | P2 when advanced lab ready |

## Testing template

1. **Trigger** — Attack playbook
2. **Observe** — Raw XML on DC; note `Client Address` / `IpAddress`
3. **Alert** — SIEM + MDI (if licensed)
4. **Tune** — FP documented with reason
5. **Artifact** — Screenshot → `screenshots/`

## Alert metadata (corrected entities)

```json
{
  "use_case_id": "AD-DC-001",
  "title": "Possible Kerberoasting",
  "severity": "high",
  "mitre": ["T1558.003"],
  "entities": {
    "attacker_host": "IpAddress",
    "target_service_accounts": "AccountName",
    "spns": "ServiceName"
  }
}
```

**Note:** For 4769, `AccountName` is the **service account** (target), not the roasting user.

## Cross-references

- [kerberoast-detection.md](kerberoast-detection.md)
- [asrep-detection.md](asrep-detection.md)
- [password-spray-detection.md](password-spray-detection.md)
- [defender-identity-notes.md](defender-identity-notes.md)
- [../mitre/coverage-matrix.md](../mitre/coverage-matrix.md)
