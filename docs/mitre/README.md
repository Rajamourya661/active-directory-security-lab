# MITRE ATT&CK Mapping

Framework alignment for techniques practiced in the Active Directory Security Lab.

## Scope

- **Matrix:** [Enterprise](https://attack.mitre.org/matrices/enterprise/)
- **Platforms:** Windows, Active Directory
- **Focus tactics:** Reconnaissance, Credential Access, Privilege Escalation, Lateral Movement, Persistence, Defense Evasion

## Contents

| Document | Purpose |
|----------|---------|
| [coverage-matrix.md](coverage-matrix.md) | Technique coverage table |
| [technique-notes.md](technique-notes.md) | Narrative per technique |

## How to Use

1. After each lab module, mark technique **Practiced**, **Detected**, or **Mitigated** in the matrix.
2. Link detection rules and hardening docs from matrix rows.
3. Export matrix screenshot for portfolio (`screenshots/`).

## External Resources

- [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) — import layer JSON you maintain locally
- [Atomic Red Team](https://github.com/redcanaryco/atomic-red-team) — optional atomic tests (lab only)

## Disclaimer

MITRE technique IDs describe adversary behavior for defensive analysis. Lab execution is authorized testing only.
