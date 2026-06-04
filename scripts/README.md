# Scripts

Lab automation and purple-team helpers. **Authorized lab only.**

## Scripts

| Script | Purpose |
|--------|---------|
| [Test-LabConnectivity.ps1](Test-LabConnectivity.ps1) | DNS, DC locator, LDAP 389, time sync, domain join |
| [Export-SecurityBaseline.ps1](Export-SecurityBaseline.ps1) | Audit policy + AD summary (pre-auth count, SPN users) → `logs/` |
| [Invoke-DetectionTest.ps1](Invoke-DetectionTest.ps1) | Checklist linking attacks to events and Sigma rules |

## Usage

```powershell
# From domain-joined lab host
.\Test-LabConnectivity.ps1 -DomainFqdn corp.lab.local -DomainController DC01

.\Export-SecurityBaseline.ps1 -DomainFqdn corp.lab.local

.\Invoke-DetectionTest.ps1
.\Invoke-DetectionTest.ps1 -UseCaseId AD-DC-001
```

## Conventions

- No embedded passwords.
- Output under `scripts/logs/` is **gitignored**.
- Requires RSAT **ActiveDirectory** module for full baseline export.

## Logs directory

Create automatically on first export. Do not commit `logs/*.json` (may contain SamAccountNames).
