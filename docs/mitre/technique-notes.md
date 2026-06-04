# Technique Notes

Short defensive narratives for portfolio discussions and interviews.

## T1558.003 – Kerberoasting

**What it is:** Requesting service tickets for SPN-backed accounts and cracking ticket encryption offline.

**Why it matters:** Service accounts often have weak passwords and excessive privileges.

**Lab evidence:** 4769 alerts, cracked `svc_sql` hash (before hardening), BloodHound Kerberoastable Users query.

**Mitigations:** Long passwords, gMSA, AES, Protected Users, detection on RC4 TGS volume.

---

## T1558.004 – AS-REP Roasting

**What it is:** Obtaining AS-REP for users without Kerberos pre-authentication.

**Why it matters:** Unauthenticated attack surface; often misconfiguration on legacy accounts.

**Lab evidence:** 4768 with PreAuthType 0; `GetNPUsers` success on `legacyapp`.

**Mitigations:** Disable `DoesNotRequirePreAuth`, audit AD regularly, alert on 4768 pattern.

---

## T1087 / T1069 – Discovery via BloodHound

**What it is:** Mapping users, groups, sessions, and ACLs to find paths to domain admin.

**Why it matters:** Recon enables precise escalation vs blind spraying.

**Lab evidence:** Shortest path graph PNG; SharpHound zip metadata.

**Mitigations:** ACL cleanup, tiering, LDAP anomaly detection, limit local admin exposure.

---

## T1098 – Account Manipulation

**What it is:** Modifying AD objects (password, SPN, group membership, ACLs) to persist or escalate.

**Why it matters:** Stealthy compared to malware; blends with admin activity.

**Lab evidence:** 5136 on `servicePrincipalName` or `member` after scripted change.

**Mitigations:** SACL auditing, least privilege, PAM/JEA, BloodHound recurring audits.

---

## Interview Sound Bite

> "I built an isolated AD lab, executed Kerberoast and AS-REP scenarios, engineered detections on 4769 and 4768, mapped techniques to MITRE ATT&CK, and measured risk reduction after tiering and Kerberos hardening."

Customize with your SIEM and actual metrics.
