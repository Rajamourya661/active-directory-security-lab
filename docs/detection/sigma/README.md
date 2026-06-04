# Sigma Rules

Exportable detection rules for the AD Security Lab. Import into:

- [Sigma CLI](https://github.com/SigmaHQ/sigma) → Splunk, Elastic, Sentinel
- [Uncoder](https://uncoder.io/) or similar converters

## Rules

| File | Technique | Notes |
|------|-----------|-------|
| [kerberoast-rc4-volume.yml](kerberoast-rc4-volume.yml) | T1558.003 | Add **aggregation** in SIEM (distinct SPNs per `IpAddress`) |
| [asrep-no-preauth.yml](asrep-no-preauth.yml) | T1558.004 | High severity; low FP if pre-auth disabled accounts = 0 |
| [password-spray-4625.yml](password-spray-4625.yml) | T1110.003 | Event-level; correlate `dc(TargetUserName)` in SIEM |

## Validation

After conversion, run the matching attack playbook and confirm alert within your lab SLA.

## Status field

Keep `status: experimental` until you complete purple-team validation, then set `test` or `stable` per your org policy.
