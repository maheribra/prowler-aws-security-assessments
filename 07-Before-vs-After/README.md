# AWS Security Hardening: Before vs After

## Overview

This project demonstrates an AWS security assessment and hardening workflow using **Prowler v5.34.0**.

The project compares the AWS security posture before and after remediation by identifying security weaknesses, applying security improvements, and validating changes through reassessment.

The objective was to demonstrate a complete cloud security lifecycle:

**Assess → Identify → Remediate → Validate**

---

## Assessments Included

This project combines results from:

- AWS IAM Security Assessment
- AWS S3 Security Assessment
- AWS CloudTrail Security Assessment
- AWS EC2 Security Assessment
- AWS KMS Security Assessment
- CIS AWS Foundations Benchmark Assessment

---

## Security Workflow

1. Perform AWS security scans using Prowler
2. Analyze security findings
3. Apply AWS security hardening recommendations
4. Perform validation scans
5. Compare before and after results
6. Document security improvements

---

# Before vs After Results

## IAM Security Assessment

### Before

Initial IAM assessment identified security weaknesses including:

- Weak password policy configuration
- Authentication security improvements required
- Multiple failed security checks

### Remediation

Applied IAM hardening:

- Minimum password length increased to 14 characters
- Uppercase letters required
- Lowercase letters required
- Numbers required
- Symbols required
- Password history enabled
- Password expiration enabled

### After

Results:

- Improved IAM security posture
- Reduced account security risks
- Stronger authentication controls implemented

---

## CloudTrail Security Assessment

### Before

Initial assessment identified:

- Logging configuration weaknesses
- Audit monitoring improvements required
- Encryption recommendations

### Remediation

Reviewed and improved:

- Multi-region logging configuration
- Log file validation
- Audit visibility
- Encryption recommendations

### After

Results:

- Improved AWS activity monitoring
- Better security visibility
- Improved audit readiness

---

## CIS AWS Foundations Benchmark

### Before

CIS Benchmark assessment identified compliance gaps against AWS security best practices.

### Remediation

Reviewed failed controls and documented:

- Security impact
- Recommended remediation steps
- AWS best practices

### After

Results:

- Improved CIS compliance awareness
- Security hardening roadmap created

---

# Evidence Screenshots

The screenshots folder contains before and after evidence from Prowler reports.

## IAM Evidence

| Screenshot | Description |
|---|---|
| iam-before.png | IAM assessment summary before remediation |
| iam-before-full.png | Full IAM findings before remediation |
| iam-after.png | IAM assessment summary after remediation |
| iam-after-full.png | Full IAM findings after remediation |

## CloudTrail Evidence

| Screenshot | Description |
|---|---|
| cloudtrail-before.png | CloudTrail assessment summary before remediation |
| cloudtrail-before-full.png | Full CloudTrail findings before remediation |
| cloudtrail-after.png | CloudTrail assessment summary after remediation |
| cloudtrail-after-full.png | Full CloudTrail findings after remediation |

## CIS Benchmark Evidence

| Screenshot | Description |
|---|---|
| cis-summary.png | CIS benchmark summary |
| cis-summary-full.png | Full CIS benchmark results |

---

# Tools Used

- Prowler v5.34.0
- AWS IAM
- AWS S3
- AWS CloudTrail
- AWS EC2
- AWS KMS
- CIS AWS Foundations Benchmark

---

# Repository Structure

```
07-Before-vs-After
│
├── README.md
├── before-after-summary.md
├── screenshots
│   ├── iam-before.png
│   ├── iam-before-full.png
│   ├── iam-after.png
│   ├── iam-after-full.png
│   ├── cloudtrail-before.png
│   ├── cloudtrail-before-full.png
│   ├── cloudtrail-after.png
│   ├── cloudtrail-after-full.png
│   ├── cis-summary.png
│   └── cis-summary-full.png
└── .gitignore
```

---

# Outcome

This project demonstrates practical AWS cloud security skills including:

- Security assessment using Prowler
- AWS security hardening
- Vulnerability identification
- Compliance validation
- Security documentation
- Before and after security comparison

The final result demonstrates the ability to identify cloud security risks, apply remediation actions, and validate improvements.