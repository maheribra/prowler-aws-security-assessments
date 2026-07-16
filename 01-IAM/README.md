# AWS IAM Security Assessment with Prowler

## Overview

This project demonstrates an AWS IAM security assessment using **Prowler v5.34.0**.

A security baseline scan was performed, IAM weaknesses were identified, security hardening was applied, and a second scan was conducted to measure improvement.

---

## Tool

- **Tool:** Prowler v5.34.0
- **Service Assessed:** AWS IAM
- **Cloud Provider:** Amazon Web Services (AWS)

---

# Before Hardening

Initial IAM security scan results:

- ❌ Failed Checks: 20
- ✅ Passed Checks: 19

## Severity Breakdown

| Severity | Findings |
|----------|----------|
| Critical | 1 |
| High | 4 |
| Medium | 9 |
| Low | 6 |

Report:

`reports/iam-scan-before.html`

---

# Security Remediation Performed

Implemented IAM password policy improvements:

✅ Minimum password length: 14 characters  
✅ Require uppercase characters  
✅ Require lowercase characters  
✅ Require numbers  
✅ Require symbols  
✅ Prevent password reuse: 24 passwords  
✅ Password expiration: 90 days  

---

# After Hardening

Second IAM security scan results:

- ❌ Failed Checks: 13
- ✅ Passed Checks: 26

## Severity Breakdown

| Severity | Findings |
|----------|----------|
| Critical | 1 |
| High | 4 |
| Medium | 3 |
| Low | 5 |

Report:

`reports/iam-scan-after.html`

---

# Improvement Summary

| Metric | Before | After |
|---|---|---|
| Failed Checks | 20 | 13 |
| Passed Checks | 19 | 26 |
| Total Checks | 39 | 39 |

Security posture improved by reducing failed IAM checks and strengthening account password controls.

---

# Final Status

After implementing IAM password policy hardening:

## Before

- Failed Checks: 20
- Passed Checks: 19

## After

- Failed Checks: 13
- Passed Checks: 26

Remaining findings were reviewed and include items requiring additional controls such as hardware MFA, enterprise federation, and IAM architecture changes.

---

# Documentation

Detailed documentation:

- [Security Findings](findings.md)
- [Remediation Actions](remediation.md)

Prowler Reports:

- [Before Hardening Report](reports/iam-scan-before.html)
- [After Hardening Report](reports/iam-scan-after.html)


# Project Structure

```text
AWS-IAM-Security-Assessment/
│
├── README.md
│
└── reports/
    ├── iam-scan-before.html
    └── iam-scan-after.html