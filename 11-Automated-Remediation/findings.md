# Security Findings

## Overview

This project focuses on demonstrating automated remediation of common AWS security configuration issues using Python and Boto3.

The findings addressed by the automation scripts were identified from previous AWS security assessments and security hardening activities.

---

## Finding 1: S3 Public Access Configuration

### Risk

An S3 bucket that allows public access can potentially expose sensitive data to unauthorized users.

### Affected Resource

```text
aws-cloudtrail-logs-018134828551-513d4334
```

### Remediation

The `remediate_s3.py` script automatically enables all four S3 Block Public Access settings:

* BlockPublicAcls
* IgnorePublicAcls
* BlockPublicPolicy
* RestrictPublicBuckets

### Result

```text
[SUCCESS] S3 Block Public Access enabled
```

---

## Finding 2: IAM Password Policy

### Risk

A weak IAM password policy can increase the risk of compromised user credentials and unauthorized AWS account access.

### Remediation

The `remediate_iam.py` script automatically enforces the following password requirements:

* Minimum password length of 14 characters
* Uppercase characters required
* Lowercase characters required
* Numbers required
* Symbols required
* Maximum password age of 90 days
* Password reuse prevention of 24 previous passwords

### Result

```text
[SUCCESS] IAM password policy updated successfully.
```

---

## Finding 3: CloudTrail Log File Validation

### Risk

Without CloudTrail log file validation, it may be more difficult to detect whether CloudTrail log files have been modified or deleted after delivery.

### Affected Resource

```text
security-audit-trail
```

### Remediation

The `remediate_cloudtrail.py` script automatically enables CloudTrail log file validation.

The CloudTrail trail uses `eu-north-1` as its home region.

### Result

```text
[SUCCESS] CloudTrail log file validation enabled for: security-audit-trail
```

---

## Summary

| Finding              | AWS Service    | Automated Remediation           | Status     |
| -------------------- | -------------- | ------------------------------- | ---------- |
| S3 Public Access     | Amazon S3      | Block Public Access enabled     | Remediated |
| Weak Password Policy | AWS IAM        | Strong password policy enforced | Remediated |
| Log File Validation  | AWS CloudTrail | Log file validation enabled     | Remediated |

All three remediation scripts were successfully executed using Python and Boto3.
