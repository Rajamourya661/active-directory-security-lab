# BloodHound / SharpHound Indicators

Detect collection and LDAP enumeration consistent with AD path mapping (T1087, T1069, T1482).

## Host-based

| Indicator | Detail |
|-----------|--------|
| Process | `SharpHound.exe`, `AzureHound.exe`, BloodHound ingest |
| PowerShell | `Invoke-BloodHound`, download cradles |
| Files | `*.json`, `SharpHound-*.zip` in user profile (Sysmon 11) |
| Command line | `-c All`, `--collectionmethods` |

## DC / LDAP

| Pattern | Description |
|---------|-------------|
| LDAP bind spike | One host → thousands of reads |
| 4662 | Directory service access (requires SACLs) |
| SAMR / remote admin | Session collection via `ADMIN$` |

## Detection use cases

| ID | Logic |
|----|--------|
| AD-LAB-BH-001 | Process name SharpHound / Rubeus on workstation |
| AD-LAB-BH-002 | &gt; N LDAP operations / 5 min from non-DC IP |

## Splunk (example)

```spl
index=windows (EventCode=4688 OR EventCode=1)
  (Process_Name="*SharpHound*" OR CommandLine="*BloodHound*" OR CommandLine="*Invoke-BloodHound*")
```

## MDI

Reconnaissance / Suspected identity enumeration — compare with custom rules ([defender-identity-notes.md](defender-identity-notes.md)).

## Evasion vs detection

| Attacker | Defender response |
|----------|-------------------|
| Linux LDAP-only collector | DC-centric 4662 / LDAP volume |
| Split collection over days | Lower threshold + baseline anomaly |
| Exclude session collection | Shorter paths may be missed — accept tradeoff |
| Rename binary | Hash/block unsigned tools; AppLocker |

## Validation

Run [../attacks/bloodhound-recon.md](../attacks/bloodhound-recon.md); confirm 4688 or MDI within lab SLA.

## References

- [Sigma community rules](https://github.com/SigmaHQ/sigma) — search BloodHound / SharpHound
