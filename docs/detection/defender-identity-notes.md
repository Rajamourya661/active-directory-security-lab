# Microsoft Defender for Identity (MDI)

Compare on-prem Windows event detections with MDI alerts for the same lab scenarios.

## Why include MDI

Many enterprises rely on **MDI** (formerly Azure ATP) for AD-centric detections without writing all rules in Splunk. Documenting both shows hybrid SOC maturity.

## Lab setup (optional)

1. Install MDI sensor on `DC01` (or mirror port if using physical tap).
2. Activate MDI workspace in Defender portal.
3. Run attacks after 24–48h learning period.

## Technique mapping

| Lab technique | MDI alert (examples) | On-prem event fallback |
|---------------|----------------------|-------------------------|
| Kerberoasting | Reconnaissance / Suspected Kerberos SPN exposure, Kerberos attacks | 4769 volume per client |
| AS-REP roast | Suspected AS-REP Roasting | 4768 PreAuthType 0 |
| BloodHound / LDAP recon | Reconnaissance, Suspected enumeration | 4662, 4688, network |
| DCSync | Suspected DCSync attack | 4662, replication anomalies |
| Golden ticket | Suspected Golden Ticket usage | 4769 anomalies, krbtgt |

Exact alert names change with MDI versions—verify in your tenant during lab.

## Comparison table

| Dimension | Custom 4769 rule | MDI |
|-----------|------------------|-----|
| Tuning burden | High (FP, baselines) | Lower for known patterns |
| Custom SPN lists | Full control | Limited |
| Cost | SIEM ingest only | License |
| Offline/air-gapped lab | Works | Requires cloud connectivity |
| Portfolio value | Shows detection engineering | Shows Microsoft stack |

## Portfolio action

Capture one MDI alert screenshot alongside your Splunk/Sentinel 4769 alert for the same Kerberoast run (redacted).

## References

- [Microsoft Defender for Identity documentation](https://learn.microsoft.com/defender-for-identity/)
