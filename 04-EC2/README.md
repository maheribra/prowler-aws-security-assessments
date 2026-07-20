# AWS EC2 Security Assessment with Prowler

## Overview

This project demonstrates an AWS EC2 security assessment using **Prowler v5.34.0**.

A security assessment was performed against AWS EC2 resources to identify security misconfigurations and verify compliance with security best practices.

## Tools Used

- AWS
- Prowler v5.34.0
- AWS CLI

## Scan Summary

| Metric | Result |
|---------|--------|
| Service | EC2 |
| Checks Executed | 72 |
| Passed | 51 |
| Failed | 0 |
| Critical | 0 |
| High | 0 |
| Medium | 0 |
| Low | 0 |

## Assessment Results

The EC2 assessment identified **no security findings**.

All evaluated EC2 security checks passed successfully, indicating that the configured EC2 resources meet the tested security controls.

## Reports

```
reports/
├── ec2-before-scan.html
```

## Skills Demonstrated

- AWS EC2 Security Assessment
- Cloud Security Auditing
- Security Baseline Validation
- AWS Security Best Practices
- Prowler CLI Usage
- Security Reporting