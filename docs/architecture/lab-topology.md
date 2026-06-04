# Lab Topology

Physical and logical layout for the AD Security Lab. Customize placeholders before deployment.

## Virtual Machines

| Hostname | Role | OS | vCPU | RAM | Notes |
|----------|------|-----|------|-----|-------|
| `DC01` | Primary domain controller | Windows Server 2022 | 2 | 4–8 GB | DNS, AD DS, optional CA |
| `DC02` | Secondary DC (optional) | Windows Server 2022 | 2 | 4 GB | Replication, DCSync scenarios |
| `SRV01` | App / file server | Windows Server 2022 | 2 | 4 GB | SPN targets, shares |
| `WS01` | Standard user workstation | Windows 11 | 2 | 4 GB | Initial access simulation |
| `WS02` | Admin jump (Tier 0) | Windows 11 | 2 | 4 GB | Restricted use; no browsing |
| `SIEM01` | Log collector (optional) | Linux or Windows | 2 | 8 GB | WEF subscriber, BloodHound DB |

## Network

| Parameter | Example value |
|-----------|----------------|
| Lab domain FQDN | `corp.lab.local` |
| NetBIOS | `CORPLAB` |
| Lab subnet | `10.10.10.0/24` |
| DC01 IP | `10.10.10.10` |
| DNS | DC01 only (no external forwarders for AD DNS zone) |
| Gateway | None (isolated) or lab-only router |

## Hypervisor Notes

- Use **private/internal** virtual switch only.
- Disable clipboard/shared folders from host to lab if simulating malware handling.
- Snapshot after clean build: `baseline-clean`, `post-vuln-config`, `post-hardening`.

## Time Synchronization

Kerberos is time-sensitive (default 5-minute skew). Ensure:

- DC holds PDC emulator role.
- All members point to lab DC for NTP.
- Hypervisor time sync does not fight guest time (disable on DC VMs if drift occurs).

## Build Order

1. Install DC01, promote forest root domain.
2. Create OUs, users, groups per [domain-design.md](domain-design.md).
3. Join member servers and workstations.
4. Configure WEF / SIEM forwarding before attack exercises.
5. Introduce intentional misconfigurations for attack docs (document in CHANGELOG).

## Validation Checklist

- [ ] `nltest /dsgetdc:corp.lab.local` succeeds from WS01
- [ ] LDAP `389/636` reachable only on lab subnet
- [ ] SYSVOL replication healthy if multi-DC
- [ ] Security log size and retention adequate for detection labs
