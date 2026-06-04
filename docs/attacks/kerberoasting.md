# Kerberoasting

Request service tickets (TGS) for accounts with SPNs and crack offline to recover service account passwords.

## Objective

Demonstrate abuse of Kerberos TGS-REQ behavior for accounts with registered SPNs and weak passwords.

## MITRE ATT&CK

- [T1558.003 – Steal or Forge Kerberos Tickets: Kerberoasting](https://attack.mitre.org/techniques/T1558/003/)

## How It Works

1. Attacker authenticates as any domain user.
2. Client requests TGS for SPN(s) — typically via `GetUserSPNs` or `Rubeus kerberoast`.
3. TGS encrypted with **Kerberos keys derived from the account password** (RC4-HMAC uses the NT hash; AES uses separate key material).
4. Offline cracking (hashcat mode `13100` for RC4-HMAC) recovers password if weak.

## Lab Preconditions

- Service account `svc_sql` with SPN `MSSQLSvc/SRV01.corp.lab.local:1433`
- Weak password (lab only) for successful crack demo
- Optional: account not in **Protected Users** (Protected Users affect encryption behavior)

## Execution Examples

### Impacket (from Linux attacker VM)

```bash
impacket-GetUserSPNs corp.lab.local/jdoe:Password123! -request -outputfile kerberoast.txt
```

### Rubeus (Windows)

```text
Rubeus.exe kerberoast /outfile:kerberoast_hashes.txt
```

### hashcat (offline, lab)

```bash
hashcat -m 13100 kerberoast_hashes.txt wordlist.txt
```

Use AES-capable modes when tickets use AES (`19700` etc.) per hash format.

## Success Criteria

- [ ] TGS hash captured for `svc_sql`
- [ ] Password recovered with lab wordlist
- [ ] Detection alert fired (see detection doc)
- [ ] Post-hardening: roast fails or crack impractical (long password + AES)

## Detection

[../detection/kerberoast-detection.md](../detection/kerberoast-detection.md)

Key signal: Event **4769** with unusual encryption type (e.g., `0x17` RC4) or volume spike for one client.

## Hardening

[../hardening/kerberos-hardening.md](../hardening/kerberos-hardening.md)

- Long random service account passwords (25+ characters)
- **gMSA** where supported
- Remove unused SPNs
- Monitor 4769 anomalies

## Attacker evasion

| Technique | Note |
|-----------|------|
| AES tickets only | Use hashcat AES modes (`19700`+); detection must not rely on RC4 alone |
| `/nowrap` / targeted SPNs | Low volume — harder for threshold rules |
| Linux + Impacket | No Rubeus on host — rely on DC **4769** + `Client Address` |

## Portfolio Tip

Document **before/after**: one 4769 alert in Splunk/Sentinel with cracked password timeline, then hardened state with no crack. Note that **4769 Account Name = service account**, not the attacker — show `IpAddress` correlation.
