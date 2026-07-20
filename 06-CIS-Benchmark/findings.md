# CIS Benchmark Findings

## Overview

The AWS CIS Benchmark assessment was performed using **Prowler v5.34.0**.

The scan evaluated AWS security configuration against the **CIS AWS Foundations Benchmark v6.0**.

## Results Summary

- Total Checks: 118
- Passed: 39
- Failed: 79
- Compliance Score: 33.05%

## Failed Areas

### Identity and Access Management (IAM)

Findings identified around:

- IAM security configuration
- MFA requirements
- Password policy controls
- User and access management

Severity:
- Critical: 1
- High: 1
- Low: 4

---

### Logging

Findings identified around:

- CloudTrail configuration
- Log protection
- AWS logging best practices

Severity:
- Medium: 2
- Low: 2

---

### Monitoring

Findings identified around:

- CloudWatch monitoring
- Alerting configuration
- Security monitoring controls

Severity:
- Medium: 15

---

### AWS Config

Findings identified around:

- AWS Config not fully configured
- Missing configuration monitoring controls

Severity:
- Medium: 17

---

### Security Hub

Findings identified around:

- Security Hub configuration
- Security standards monitoring

Severity:
- High: 17

---

### S3 Security

Findings identified around:

- S3 security configuration
- Bucket protection controls

Severity:
- High: 1
- Medium: 2

## Conclusion

The assessment identified multiple CIS compliance gaps. The findings represent opportunities to improve AWS security posture and align the environment with industry security standards.