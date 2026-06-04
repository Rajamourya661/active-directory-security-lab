# AS-REP Roasting Detection

Identify Kerberos AS-REQ traffic for accounts without pre-authentication (T1558.004).

## Primary Signal: Event 4768

**A Kerberos authentication ticket (TGT) was requested.**

| Field | Meaning | Suspicious pattern |
|-------|---------|-------------------|
| **Target User Name** | Account requested | Matches roastable / unknown users |
| **Pre-Authentication Type** | `0` = pre-auth not used | Required for AS-REP roast |
| **Status** | `0x0` success | Hash material returned to client |
| **IpAddress** | Requesting client | Unexpected subnet, VPN egress |

## Detection logic

```
IF EventID = 4768
  AND PreAuthType = 0
  AND Status = 0x0
THEN Alert "AS-REP roast - TGT issued without pre-authentication"
```

Combine with **proactive AD hygiene** (higher fidelity than 4768 alone).

## Proactive control (preferred)

```powershell
$vuln = Get-ADUser -Filter {DoesNotRequirePreAuth -eq $true} -Properties DoesNotRequirePreAuth
if ($vuln.Count -gt 0) { /* alert: configuration drift */ }
```

Schedule daily; alert on any result outside documented break-glass accounts.

## Splunk SPL

```spl
index=windows EventCode=4768 Pre_Authentication_Type=0 Status=0x0
| stats count BY Target_User_Name, IpAddress, _time span=5m
```

## Sentinel KQL

```kql
SecurityEvent
| where EventID == 4768
| where PreAuthType == "0" and Status == "0x0"
| summarize Count=count() by TargetUserName, IpAddress, bin(TimeGenerated, 5m)
```

## Sigma rule

[sigma/asrep-no-preauth.yml](sigma/asrep-no-preauth.yml)

## False positives

| Scenario | Mitigation |
|----------|------------|
| Misconfigured legacy service account | Fix account; exclude after change ticket |
| Parser normalizes `PreAuthType` differently | Validate raw XML; map in SIEM |
| Lab rebuild with stale forwarders | Filter by `domain` / hostname |
| Duplicate events from WEF | Dedupe on `RecordID` + `Computer` |

**Note:** Some environments rarely emit noisy 4768 pre-auth-0 outside true misconfigurations—treat alerts as **high severity** until proven benign.

## Supplemental signals

| Indicator | Source |
|-----------|--------|
| `GetNPUsers.py` / Rubeus `asreproast` | 4688, EDR |
| User enumeration before roast | 4625 bursts, LDAP |
| MDI | Unusual Kerberos toward sensitive accounts |

## Hybrid / cloud note

On-prem AS-REP targets the **KDC**. Entra ID–joined users with MFA are not a substitute for fixing on-prem `DoesNotRequirePreAuth`. See [../architecture/hybrid-and-cloud-notes.md](../architecture/hybrid-and-cloud-notes.md).

## Validation

1. Enable lab account per [../attacks/asrep-roasting.md](../attacks/asrep-roasting.md).
2. Confirm 4768 + SIEM alert.
3. Remediate; confirm proactive query returns zero.

## Response playbook

| Step | Action |
|------|--------|
| 1 | Disable account or force `DoesNotRequirePreAuth $false` |
| 2 | Force password reset |
| 3 | Block / investigate `IpAddress` |
| 4 | Hunt for follow-on 4769 / 4624 Type 3 from same IP |

Severity: **High**.
