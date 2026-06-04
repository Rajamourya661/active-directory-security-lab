# Interview Talking Points

STAR-style prompts for discussing this project.

## Kerberoasting Detection

**Situation:** Needed to detect service ticket abuse in AD without drowning in false positives.

**Task:** Build a lab scenario and detection for T1558.003.

**Action:** Configured `svc_sql` with SPN, ran Rubeus/Impacket roast, forwarded 4769 to SIEM, wrote rule for RC4 TGS volume and tuned machine-account filters.

**Result:** Alert fired within _[X]_ minutes; after gMSA/long password, crack failed while detection still logged attempt.

**Deep dive:** Explain difference between 4768 and 4769, encryption types `0x17` vs AES.

---

## BloodHound for Defense

**Situation:** Flat AD with helpdesk ACLs created non-obvious path to Domain Admins.

**Task:** Visualize and remediate attack paths.

**Action:** SharpHound collection, shortest path query, removed `GenericAll`, implemented tier GPO deny logon.

**Result:** Path count reduced from _[N]_ to _[M]_; recurring collection planned monthly.

---

## AS-REP Roasting

**Situation:** Legacy account had pre-auth disabled.

**Task:** Demonstrate risk and eliminate misconfiguration.

**Action:** `GetNPUsers`, hashcat crack in lab, 4768 detection, `Set-ADAccountControl` remediation.

**Result:** Zero accounts with `DoesNotRequirePreAuth`; proactive scheduled audit query.

---

## Ethics & Scope

**Prompt:** "How do you practice offensive skills safely?"

**Answer:** Isolated VLAN, eval licenses, no production data, snapshots, written rules of engagement for employer labs, never commit secrets, responsible disclosure if finding issues outside lab.

---

## Questions to Ask Interviewers

- How do you ingest AD events today (WEF, AD FS, Defender for Identity)?
- What is your Kerberoast false positive rate?
- Do you use BloodHound or similar for continuous ACL review?

---

## 30-Second Version

"I built an AD security lab where I Kerberoasted service accounts, detected it with 4769 analytics, mapped everything to MITRE, then hardened with tiering and Kerberos controls and proved the attack path disappeared in BloodHound."
