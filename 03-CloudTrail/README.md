# AWS CloudTrail Security Assessment with Prowler

## Overview

This project demonstrates an AWS CloudTrail security assessment using **Prowler v5.34.0**.

A baseline security scan was performed to identify CloudTrail logging weaknesses. Security hardening was applied, and a second scan was conducted to validate the improvements.

---

## Tools Used

- AWS CloudTrail
- Prowler v5.34.0
- AWS CLI
- Amazon S3

---

## Assessment Process

1. Performed an initial CloudTrail security scan using Prowler
2. Identified CloudTrail logging weaknesses
3. Enabled multi-region CloudTrail logging
4. Enabled management event logging
5. Enabled log file validation
6. Performed a second Prowler scan to verify remediation

---

# Initial Assessment (Before)

Command used:

```bash
prowler aws --service cloudtrail
```

Results:

| Status | Count |
|---|---:|
| Failed | 35 |
| Passed | 0 |

Severity:

| Severity | Findings |
|---|---:|
| High | 17 |
| Medium | 1 |
| Low | 17 |

## Identified Issues

- Multi-region CloudTrail logging was disabled
- Management events were not being captured
- Amazon Bedrock API logging was not enabled

---

# Remediation Applied

## Multi-Region CloudTrail Logging

Enabled a CloudTrail trail with:

- Multi-region coverage
- Continuous logging
- Global AWS API activity monitoring

---

## Management Event Logging

Enabled CloudTrail management events:

- Read events
- Write events

This provides visibility into:

- IAM changes
- Security configuration changes
- AWS resource modifications

---

## Log File Validation

Enabled CloudTrail log file validation to help detect unauthorized modification of delivered log files.

---

# Final Assessment (After)

Command used:

```bash
prowler aws --service cloudtrail
```

Results:

| Status | Count |
|---|---:|
| Failed | 7 |
| Passed | 37 |

Severity:

| Severity | Findings |
|---|---:|
| High | 0 |
| Medium | 3 |
| Low | 4 |

---

# Security Improvement

The CloudTrail security posture improved after remediation:

- High severity findings reduced from **17 to 0**
- Total failed findings reduced from **35 to 7**
- AWS API activity monitoring was enabled
- Audit visibility improved across regions

---

# Reports

The `reports/` directory contains:

- Initial assessment results
- Remediation validation results
- HTML reports
- CSV exports
- JSON exports

---

# Repository Structure

```
03-CloudTrail/
├── reports/
│   ├── cloudtrail-before-scan.html
│   ├── cloudtrail-before-scan.csv
│   ├── cloudtrail-before-scan.json
│   ├── cloudtrail-after-scan.html
│   ├── cloudtrail-after-scan.csv
│   └── cloudtrail-after-scan.json
├── README.md
├── findings.md
├── remediation.md
└── .gitignore
```