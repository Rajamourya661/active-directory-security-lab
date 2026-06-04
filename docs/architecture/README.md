# Architecture Documentation

Design notes for the Active Directory Security Lab: topology, naming, trust boundaries, and identity model.

## Contents

| Document | Description |
|----------|-------------|
| [lab-topology.md](lab-topology.md) | VMs, networks, DNS, hypervisor |
| [domain-design.md](domain-design.md) | OUs, accounts, SPNs, GPO scope |
| [identity-tiering.md](identity-tiering.md) | Tier 0/1/2 and jump hosts |
| [threat-model.md](threat-model.md) | Assets, actors, controls matrix |
| [hybrid-and-cloud-notes.md](hybrid-and-cloud-notes.md) | Entra ID / hybrid vs on-prem techniques |

## Design principles

1. **Isolation** — Lab VLAN only; no production routing.
2. **Realism** — Intentional misconfigs for purple-team (document in CHANGELOG).
3. **Repeatability** — Snapshots: `baseline-clean`, `post-vuln`, `post-hardening`.
4. **Telemetry** — WEF/SIEM before first attack ([detection log sources](../detection/log-sources.md)).

## Reference diagram

```
                    [ Internet blocked / NAT off ]
                             |
                    +---------+---------+
                    |   Lab vSwitch     |
                    +---------+---------+
           +--------+--------+--------+
           |        |                 |
      +----+---+ +--+---+        +----+----+
      |  DC01  | | WS01 |        | SIEM01  |
      | (T0)   | | user |        | WEF     |
      +--------+ +------+        +---------+
```


Kali Linux
      |
      v
Windows Server (DC01)
      |
      v
Windows 11 Client
Customize IPs in [lab-topology.md](lab-topology.md).
