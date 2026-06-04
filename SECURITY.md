# Security Policy

## Supported scope

This repository contains **documentation and lab helper scripts** for authorized Active Directory security education. It does not include exploit binaries, wordlists, or live domain data.

## Reporting vulnerabilities in this repo

If you find sensitive data committed by mistake (passwords, hashes, BloodHound exports):

1. **Do not** open a public issue with the secret content.
2. Notify the repository owner privately.
3. Rotate any exposed lab credentials immediately.

## Safe use of lab techniques

| Rule | Detail |
|------|--------|
| Authorization | Only test domains and systems you own or have **written** permission to assess |
| Isolation | Keep lab VLAN disconnected from production and corporate networks |
| Secrets | Never commit `.kirbi`, NTDS, SharpHound zips, or cracked hashes — see `.gitignore` |
| Disclosure | Do not use these techniques against third parties without a contract / ROE |

## Script safety

Scripts under `scripts/` are read-only or diagnostic unless explicitly documented. Review code before running as Domain Admin.

## Dependency security

Third-party tools (BloodHound, Impacket, Rubeus) are **not** vendored in this repo. Install from official sources and verify checksums.

## License

MIT — see [LICENSE](LICENSE). Techniques described may be illegal if misused; authors assume no liability for unauthorized use.
