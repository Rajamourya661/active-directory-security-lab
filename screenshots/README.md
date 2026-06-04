# Screenshots

Store lab evidence here for portfolio and documentation (BloodHound graphs, detection alerts, GPO settings, etc.).

## Guidelines

- Use **isolated lab domains** only; never capture production tenant or customer data.
- **Redact** hostnames, IPs, usernames, and SIDs if publishing publicly.
- Prefer descriptive filenames: `bloodhound-path-to-da-01.png`, `sentinel-kerberoast-alert.png`.
- Reference images from docs with relative paths, e.g. `../screenshots/example.png`.

## Suggested Captures

| Scenario | Example filename |
|----------|------------------|
| BloodHound attack path | `bloodhound-shortest-path-da.png` |
| Kerberoast detection | `detection-4769-encryption-0x17.png` |
| AS-REP roast alert | `detection-preauth-disabled.png` |
| Hardening GPO | `gpo-kerberos-policy.png` |
| MITRE coverage matrix | `mitre-coverage-heatmap.png` |

Add a `.gitkeep` in this folder if you need an empty directory in Git without images yet.
