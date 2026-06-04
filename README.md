# Active Directory Security Lab
![MITRE](https://img.shields.io/badge/MITRE-ATT%26CK-red)
![Platform](https://img.shields.io/badge/Platform-Active%20Directory-blue)
![Focus](https://img.shields.io/badge/Focus-Detection%20Engineering-green)
![PowerShell](https://img.shields.io/badge/PowerShell-100%25-blue)
Hands-on portfolio for **Active Directory** attack techniques, **detection engineering**, **hardening**, and **MITRE ATT&CK** mapping in an isolated lab.

**Authorized lab use only.** See [SECURITY.md](SECURITY.md).

## What this repo includes

| Track | Content |
|-------|---------|
| **Red (lab)** | Kerberoast, AS-REP, password spray, BloodHound, ACL abuse |
| **Blue** | 4768/4769/4625 detections, Sigma rules, Splunk/KQL, MDI notes |
| **Green** | Tiering, gMSA, LAPS, auditing, krbtgt rotation |
| **Purple** | Attack → detect → harden → re-test loop with metrics |

## Repository structure

```
├── docs/
│   ├── architecture/     # Topology, threat model, hybrid notes
│   ├── attacks/          # Lab playbooks + optional advanced modules
│   ├── detection/        # Use cases, Sigma/, SIEM queries
│   ├── hardening/        # Defensive baselines
│   ├── mitre/            # Coverage matrix + Navigator JSON
│   └── portfolio/        # Resume / interview materials
├── scripts/              # Connectivity, baseline export, detection checklist
├── screenshots/          # Evidence (redact before publish)
├── SECURITY.md
├── CHANGELOG.md
└── LICENSE
```

## Quick start

1. Read [docs/architecture/lab-topology.md](docs/architecture/lab-topology.md) and [threat-model.md](docs/architecture/threat-model.md).
2. Deploy isolated lab VMs; configure WEF → SIEM **before** attacks.
3. Run playbooks in [docs/attacks/](docs/attacks/).
4. Validate [docs/detection/](docs/detection/) — import [docs/detection/sigma/](docs/detection/sigma/).
5. Apply [docs/hardening/](docs/hardening/); export baseline:

   ```powershell
   .\scripts\Export-SecurityBaseline.ps1 -DomainFqdn corp.lab.local
   ```

6. Update [docs/mitre/coverage-matrix.md](docs/mitre/coverage-matrix.md) and [docs/portfolio/project-summary.md](docs/portfolio/project-summary.md).

## Detection highlights

- **Kerberoast:** Event **4769** — correlate by **`IpAddress` / Client Address**, not `Account Name` (service account target). See [kerberoast-detection.md](docs/detection/kerberoast-detection.md).
- **AS-REP:** Event **4768** `PreAuthType = 0` + proactive AD audit.
- **Password spray:** Many **4625** distinct users, one source IP.

## Prerequisites

- Windows Server + Windows 11 clients (eval OK)
- Isolated hypervisor network
- Optional: BloodHound, Impacket, Rubeus, Splunk or Sentinel
- RSAT (for `Export-SecurityBaseline.ps1` AD queries)

## Documentation index

- [Architecture](docs/architecture/README.md)
- [Attacks](docs/attacks/README.md)
- [Detection](docs/detection/README.md)
- [Hardening](docs/hardening/README.md)
- [MITRE](docs/mitre/README.md)
- [Portfolio](docs/portfolio/README.md)

## Ethics

Unauthorized access is illegal. No production testing without written approval. Do not commit secrets — [.gitignore](.gitignore).

## License

[MIT](LICENSE)

## Author

Complete [docs/portfolio/project-summary.md](docs/portfolio/project-summary.md) with your metrics and screenshots.
