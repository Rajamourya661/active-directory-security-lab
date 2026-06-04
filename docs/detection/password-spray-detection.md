# Password Spray Detection

Detect many **4625** logon failures for **distinct accounts** from a **single source** in a short window (T1110.003).

## Primary signal: Event 4625

**An account failed to log on.**

| Field | Use |
|-------|-----|
| `TargetUserName` | Distinct account dimension |
| `IpAddress` / `Workstation Name` | Source pivot |
| `Status` / `Sub Status` | `0xC000006A` bad password common |
| `Logon Type` | 3 (network), 10 (RDP), 3 NTLM spray |

## Detection logic

```
IF EventID = 4625
  AND LogonType IN (2, 3, 10)
GROUP BY IpAddress, bin(15m)
HAVING dc(TargetUserName) >= 10
THEN Alert "Possible password spraying"
```

Tune `10` and `15m` to your lockout policy (stay below lockout threshold per user).

## Splunk SPL

```spl
index=windows EventCode=4625
| stats dc(Target_Account_Name) AS unique_accounts count AS failures
    BY src_ip, _time span=15m
| where unique_accounts >= 10
```

## Sentinel KQL

```kql
SecurityEvent
| where EventID == 4625
| summarize UniqueAccounts=dcount(TargetAccount), Failures=count()
    by IpAddress, bin(TimeGenerated, 15m)
| where UniqueAccounts >= 10
```

## Sigma

[sigma/password-spray-4625.yml](sigma/password-spray-4625.yml) — add aggregation in SIEM (Sigma alone is event-level).

## Honey account

Create `svc_honey` with impossible password; **any** 4625/4624 on that account = critical alert.

## False positives

- Misconfigured service trying wrong password across users
- Citrix/shared NAT (many users, one IP)

## Validation

Run [../attacks/password-spraying.md](../attacks/password-spraying.md).

## Response

| Step | Action |
|------|--------|
| 1 | Block source IP at firewall (lab) |
| 2 | Force password reset on successful logon accounts |
| 3 | Review Entra sign-in if hybrid |
