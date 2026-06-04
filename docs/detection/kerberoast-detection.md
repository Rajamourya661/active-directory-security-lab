# Kerberoast Detection

Detect suspicious Kerberos service ticket requests consistent with offline cracking (T1558.003).

## Primary Signal: Event 4769

**A Kerberos service ticket was requested.**

### Critical field semantics (read this first)

| Field (Windows XML) | Meaning | Use in detection |
|---------------------|---------|------------------|
| **Account Name** | **Service account** that owns the SPN (ticket *target*) | Track *which* accounts are being roasted |
| **Service Name** | SPN requested (e.g., `MSSQLSvc/host:1433`) | Filter sensitive SPN types |
| **Client Address** / **IpAddress** | **Requesting host** (often the attacker workstation) | **Primary pivot** — volume per client |
| **Ticket Encryption Type** | `0x17` RC4-HMAC, `0x11`/`0x12` AES | RC4 on user SPN accounts is high signal in modern domains |

**Do not** count events by `Account Name` alone to find the attacker—that field names the **victim service account**, not the user who ran Rubeus.

Correlate the requester with **4624** (logon) on the same `Client Address` or EDR process telemetry (`4688`).

### Field normalization (SIEM aliases)

| Windows Security XML | Splunk (common) | Microsoft Sentinel |
|----------------------|-----------------|---------------------|
| `EventID` | `EventCode` | `EventID` |
| `TicketEncryptionType` | `Ticket_Encryption_Type` | `TicketEncryptionType` |
| `ServiceName` | `Service_Name` | `ServiceName` |
| `IpAddress` / `Client Address` | `IpAddress` | `IpAddress` |
| `AccountName` | `Account_Name` | `TargetUserName` (verify parser) |

Always validate field names against one raw 4769 event in your pipeline.

## Detection logic (corrected)

```
IF EventID = 4769
  AND TicketEncryptionType = 0x17          # RC4 — tune; see AES note below
  AND ServiceName does NOT match *$         # optional: reduce machine-account noise
  AND ServiceName matches sensitive SPN list (MSSQLSvc, HTTP, etc.)
GROUP BY ClientAddress, bin(5m)
HAVING distinct_count(ServiceName) >= 3    # threshold — baseline in lab first
THEN Alert "Possible Kerberoasting"
```

For **AES** roasting (post-hardening labs), monitor unusual volume of `0x11`/`0x12` TGS for many user SPNs from one client, not only RC4.

## Splunk SPL (starter)

```spl
index=windows EventCode=4769 Ticket_Encryption_Type=0x17
| search NOT Service_Name="*$"
| stats dc(Service_Name) AS unique_spns values(Service_Name) AS spns
    BY IpAddress, _time span=5m
| where unique_spns >= 3
| lookup ad_workstations.csv ip AS IpAddress OUTPUT is_expected
| where isnull(is_expected)
```

## Microsoft Sentinel KQL (starter)

```kql
SecurityEvent
| where EventID == 4769
| where TicketEncryptionType == "0x17"
| where ServiceName !endswith "$"
| summarize UniqueSPNs=dcount(ServiceName), SPNS=make_set(ServiceName)
    by IpAddress, bin(TimeGenerated, 5m)
| where UniqueSPNs >= 3
```

## Sigma rule

Canonical rule file: [sigma/kerberoast-rc4-volume.yml](sigma/kerberoast-rc4-volume.yml)

## Supplemental signals

| Event | Note |
|-------|------|
| 4688 | `Rubeus.exe`, `GetUserSPNs.py` execution |
| 4104 | Script block: `Invoke-Kerberoast`, encoded download |
| 4662 | Mass LDAP read (SPN enumeration) before roast |
| MDI | *Kerberos attacks* — see [defender-identity-notes.md](defender-identity-notes.md) |

## False positives

| Source | Mitigation |
|--------|------------|
| Legacy apps using RC4 | Allowlist service accounts; time-bound exceptions |
| Vulnerability scanners | Exclude scanner IPs after inventory |
| Clustered SQL/IIS | Allowlist known management hosts |
| Machine accounts (`$`) | Filter `ServiceName` ending in `$` where appropriate |

## Attacker evasion (detection response)

| Evasion | Detection adjustment |
|---------|----------------------|
| AES-only tickets (`/tgtdeleg`, modern Rubeus) | Volume-based rules on user SPNs; not RC4-only |
| Low-and-slow (1–2 SPNs) | Lower threshold + 4662 LDAP correlation |
| Remote roast from Linux (Impacket) | DC-only view; no 4688 on DC — rely on 4769 + 4624 |
| Stolen creds of service owner | Rare; behavior may look “normal” — UEBA / MDI |

## Tuning methodology

1. Baseline 48h of lab traffic; record P95 of `unique_spns` per `ClientAddress`.
2. Set threshold above P95 (e.g., 3–5 SPNs / 5 min for lab).
3. Run [../attacks/kerberoasting.md](../attacks/kerberoasting.md); confirm alert &lt; 15 min MTTD.
4. Document false positives in [detection-use-cases.md](detection-use-cases.md).

## Validation

1. Run Kerberoast playbook from WS01.
2. Confirm 4769 on DC; verify `IpAddress` = WS01.
3. Confirm SIEM alert; screenshot → `screenshots/`.

## Response playbook

| Step | Action | Owner |
|------|--------|-------|
| 1 | Contain: disable or isolate source host (`Client Address`) | SOC |
| 2 | Identify requesting user via 4624 / EDR on source host | SOC |
| 3 | Reset passwords for all service accounts in `spns` set | Identity |
| 4 | Hunt: BloodHound path from user to DA; check 4768/4776 | IR |
| 5 | Harden: gMSA, AES, remove RC4-capable weak accounts | AD team |
| 6 | Post-incident: tune rule; update allowlists | Detection eng |

Severity: **High** (credential access precursor to lateral movement).
