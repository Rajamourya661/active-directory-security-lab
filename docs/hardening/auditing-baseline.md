# Auditing Baseline

Group Policy and SACL configuration for detection-ready telemetry.

## Advanced Audit Policy (DC GPO)

Configure via GPO or `auditpol`:

| Subcategory | Setting |
|-------------|---------|
| Kerberos Authentication Service | Success and Failure |
| Kerberos Service Ticket Operations | Success and Failure |
| Logon | Success and Failure |
| Account Logon | Success and Failure |
| Directory Service Changes | Success (and Failure if needed) |
| Directory Service Access | Success (with SACLs) |
| Process Creation | Success (members, optional DC) |

```cmd
auditpol /get /category:* 
```

## SACL on Sensitive OUs

Enable auditing for **Everyone** or **Authenticated Users** on:

- `OU=Domain Admins` (or Tier0 OU)
- `OU=ServiceAccounts`
- AdminSDHolder-protected objects (default protections apply)

Example intent: log **5136** when `servicePrincipalName` or `member` changes.

## Log Size

| Log | Suggested size (lab) |
|-----|---------------------|
| Security | 4 GB+ |
| Sysmon Operational | 1 GB |

Enable **Do not overwrite events** only if disk allows; otherwise forward to SIEM quickly.

## Windows Event Forwarding

1. Install WEC on `SIEM01` or dedicated collector.
2. GPO: Configure target subscription on members and DCs.
3. Verify `ForwardedEvents` channel receives 4768/4769 during attack tests.

## Verification Script

Use `scripts/Test-LabConnectivity.ps1` and manual:

```powershell
Get-WinEvent -LogName Security -MaxEvents 5 | Where-Object Id -in 4768,4769
```

## Maintenance

Re-audit after each major lab scenario; attack tools may disable logging (simulate red team) and test tamper detections separately.
