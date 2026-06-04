# LAPS Implementation

Unique local administrator passwords on member workstations and servers.

## Options

| Solution | Notes |
|----------|-------|
| **Windows LAPS** (Server 2019+ / Win11) | Built-in; Azure AD or on-prem policy |
| **Legacy Microsoft LAPS** | GPO Client Side Extension; still common |

## Windows LAPS (recommended for new labs)

1. Extend schema / install LAPS feature per [Microsoft docs](https://learn.microsoft.com/windows-server/identity/laps/laps-overview).
2. Create Entra ID or AD policy assigning password complexity and rotation.
3. Deploy to `OU=Workstations` and `OU=Servers`.

## Legacy LAPS (GPO summary)

1. Install `LAPS.x64.msi` on managed clients.
2. GPO: **Computer Configuration** → LAPS password settings.
3. Delegate read permission to helpdesk; deny users.

## Validation

```powershell
# From management host with rights
Get-LapsADPassword -Identity WS01 -AsPlainText  # cmdlet name varies by LAPS version
```

## Security value

- Blocks lateral movement using shared local `Administrator` password.
- Complements tiering — does not replace domain credential hygiene.

## Portfolio

Screenshot LAPS policy + proof unique password per host (redact password).
