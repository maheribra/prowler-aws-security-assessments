# AWS CIS Benchmark Security Assessment with Prowler

## Overview

This project demonstrates an AWS security compliance assessment using **Prowler v5.34.0** against the **CIS AWS Foundations Benchmark**.

The assessment evaluates AWS configuration against CIS security recommendations covering:

- Identity and Access Management (IAM)
- Storage Security
- Logging
- Monitoring

## Tool Used

- Prowler v5.34.0
- AWS CIS Foundations Benchmark v6.0

## Assessment Command

```bash
prowler aws --compliance cis_6.0_aws -M html
```

## Assessment Results

The CIS Benchmark assessment completed successfully.

Summary:

- Total Checks: 118
- Passed: 39
- Failed: 79
- Compliance Score: 33.05%

## Key Findings

The assessment identified security improvements required in:

- IAM security controls
- CloudTrail logging configuration
- CloudWatch monitoring
- AWS Config enablement
- Security Hub configuration
- S3 security settings

## Reports

HTML report:

```
reports/cis-benchmark-scan.html
```

Compliance CSV report:

```
output/compliance/prowler-output-018134828551-20260720125956_cis_6.0_aws.csv
```

## Remediation

Recommended improvements include:

- Enable multi-factor authentication (MFA)
- Strengthen IAM password policies
- Enable AWS Config
- Enable Security Hub
- Improve CloudTrail logging security
- Enable CloudWatch monitoring alerts
- Review S3 security configurations

## Skills Demonstrated

- AWS Security Assessment
- Cloud Security Posture Management (CSPM)
- CIS Compliance Auditing
- Prowler Security Automation
- AWS Security Hardening
- Compliance Reporting