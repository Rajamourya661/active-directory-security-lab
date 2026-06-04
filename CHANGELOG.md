# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Password spraying playbook and 4625 detection (Splunk/KQL + Sigma)
- `docs/detection/sigma/` — Kerberoast, AS-REP, password spray YAML rules
- `docs/detection/defender-identity-notes.md` — MDI comparison
- Architecture: `threat-model.md`, `hybrid-and-cloud-notes.md`
- Advanced roadmap: AD CS, DCSync, golden ticket overviews
- `SECURITY.md`, `Export-SecurityBaseline.ps1`, `Invoke-DetectionTest.ps1`

### Changed

- Kerberoast detection: corrected 4769 field semantics, Splunk/KQL, evasion table, response playbook
- AS-REP detection: false positives, proactive AD query, hybrid note
- Hardening: Protected Users guidance, krbtgt rotation, LDAP signing, LAPS, AdminSDHolder, CIS summary
- MITRE matrix: T1110.003, optional technique links, Navigator JSON reference only
- `.gitignore`: narrow BloodHound zips; add `scripts/logs/`
- Root README: purple-team workflow and detection highlights

## [0.1.0] - 2026-06-05

### Added

- Initial repository scaffold and core documentation modules

[Unreleased]: https://github.com/your-org/active-directory-security-lab/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/your-org/active-directory-security-lab/releases/tag/v0.1.0
