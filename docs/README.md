# Documentation

Knowledge base for the Active Directory Security Lab.

## Sections

| Folder | Description |
|--------|-------------|
| [architecture/](architecture/README.md) | Topology, threat model, tiering, hybrid |
| [attacks/](attacks/README.md) | Lab playbooks + optional advanced modules |
| [detection/](detection/README.md) | Use cases, Sigma, Splunk/KQL, MDI |
| [hardening/](hardening/README.md) | Kerberos, accounts, tiering, auditing |
| [mitre/](mitre/README.md) | Coverage matrix + Navigator layer |
| [portfolio/](portfolio/README.md) | Resume and interview prep |

## Learning path

1. [architecture/lab-topology.md](architecture/lab-topology.md) + [threat-model.md](architecture/threat-model.md)
2. [attacks/bloodhound-recon.md](attacks/bloodhound-recon.md) → credential attacks
3. [detection/](detection/) — enable auditing first ([log-sources.md](detection/log-sources.md))
4. [hardening/](hardening/) — measure before/after in portfolio
5. [mitre/coverage-matrix.md](mitre/coverage-matrix.md) — mark ✅ when validated

## Purple-team command

```powershell
..\..\scripts\Invoke-DetectionTest.ps1 -UseCaseId AD-DC-001
```

## Contributing to your fork

- Update [CHANGELOG.md](../CHANGELOG.md) per module
- Never commit BloodHound exports or hashes — see [.gitignore](../.gitignore)
