# Screenshots

Store lab evidence here for portfolio and documentation (BloodHound graphs, detection alerts, GPO settings, etc.).

## Guidelines

- Use **isolated lab domains** only; never capture production tenant or customer data.
- **Redact** hostnames, IPs, usernames, and SIDs if publishing publicly.
- Prefer descriptive filenames: `bloodhound-path-to-da-01.png`, `sentinel-kerberoast-alert.png`.
- Reference images from docs with relative paths, e.g. `../screenshots/example.png`.

  <img width="1727" height="861" alt="ad-users-and-computers" src="https://github.com/user-attachments/assets/e05ff235-b023-4b54-ac15-4c059920b8c3" />
<img width="1661" height="834" alt="domain-joined-client.png" src="https://github.com/user-attachments/assets/b44b7c7a-6431-49ef-938d-6846f60c8881" />
<img width="1672" height="285" alt="domain-join-confirmation.png" src="https://github.com/user-attachments/assets/7b6a62c6-c63d-4528-8bf7-512a0ad573cb" />




## Suggested Captures

<img width="1297" height="1147" alt="bloodhound-privilege-paths.png" src="https://github.com/user-attachments/assets/ad7903b2-aea2-450b-b725-cb37b76f642f" />
<img width="1751" height="866" alt="kali-ad-enumeration" src="https://github.com/user-attachments/assets/85d4ec6f-c0a9-49fa-aac2-9250d8d2abb8" />
<img width="1672" height="880" alt="password-policy-gpo" src="https://github.com/user-attachments/assets/a7826ec8-2961-4501-b381-6185c02da1c1" />
<img width="1536" height="938" alt="1234" src="https://github.com/user-attachments/assets/00060dc7-933d-4075-8ae4-e08a7d73ecd9" />






| Scenario | Example filename |
|----------|------------------|
| BloodHound attack path | `bloodhound-shortest-path-da.png` |
| Kerberoast detection | `detection-4769-encryption-0x17.png` |
| AS-REP roast alert | `detection-preauth-disabled.png` |
| Hardening GPO | `gpo-kerberos-policy.png` |
| MITRE coverage matrix | `mitre-coverage-heatmap.png` |

Add a `.gitkeep` in this folder if you need an empty directory in Git without images yet.
