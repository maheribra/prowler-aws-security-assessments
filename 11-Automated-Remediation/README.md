# Automated AWS Security Remediation with Python and Boto3

## Overview

This project demonstrates automated AWS security remediation using Python and the AWS SDK for Python (Boto3).

The scripts automatically apply security hardening actions to AWS services based on common security findings identified during previous AWS security assessments.

## Objectives

* Automate AWS security remediation tasks.
* Use Python and Boto3 to interact with AWS services.
* Reduce manual security configuration work.
* Demonstrate practical cloud security automation skills.
* Provide evidence of successful remediation through screenshots.

## Technologies Used

* Python
* Boto3
* AWS IAM
* Amazon S3
* AWS CloudTrail
* AWS CLI
* Git and GitHub

## Project Structure

```text
11-Automated-Remediation/
│
├── scripts/
│   ├── remediate_s3.py
│   ├── remediate_iam.py
│   └── remediate_cloudtrail.py
│
├── screenshots/
│   ├── s3-remediation-success.png
│   ├── iam-remediation-success.png
│   └── cloudtrail-remediation-success.png
│
├── README.md
├── findings.md
└── remediation.md
```

## Automated Remediation Scripts

### 1. S3 Public Access Block Remediation

**Script:** `scripts/remediate_s3.py`

The script enables Amazon S3 Block Public Access settings for the specified S3 bucket.

The following controls are enabled:

* Block public ACLs
* Ignore public ACLs
* Block public bucket policies
* Restrict public buckets

The script was successfully executed against the CloudTrail S3 logging bucket.

**Result:**

```text
[SUCCESS] S3 Block Public Access enabled
```

Evidence:

`screenshots/s3-remediation-success.png`

---

### 2. IAM Password Policy Remediation

**Script:** `scripts/remediate_iam.py`

The script automatically applies a stronger AWS account IAM password policy.

The configured policy includes:

* Minimum password length: 14 characters
* Uppercase characters required
* Lowercase characters required
* Numbers required
* Symbols required
* Maximum password age: 90 days
* Password reuse prevention: 24 previous passwords
* Users can change their own passwords

**Result:**

```text
[SUCCESS] IAM password policy updated successfully.
```

Evidence:

`screenshots/iam-remediation-success.png`

---

### 3. CloudTrail Log File Validation Remediation

**Script:** `scripts/remediate_cloudtrail.py`

The script enables CloudTrail log file validation for the configured CloudTrail trail.

Log file validation helps detect whether CloudTrail log files have been modified or deleted after delivery.

The script targets the CloudTrail trail:

```text
security-audit-trail
```

The CloudTrail trail uses `eu-north-1` as its home region.

**Result:**

```text
[SUCCESS] CloudTrail log file validation enabled for: security-audit-trail
```

Evidence:

`screenshots/cloudtrail-remediation-success.png`

---

## How to Run

Ensure that AWS credentials are configured and that the IAM identity running the scripts has permission to perform the required remediation actions.

Run the S3 remediation:

```bash
python scripts/remediate_s3.py
```

Run the IAM remediation:

```bash
python scripts/remediate_iam.py
```

Run the CloudTrail remediation:

```bash
python scripts/remediate_cloudtrail.py
```

## Security Considerations

These scripts perform direct changes to AWS security configurations.

Before running automated remediation in a production environment:

* Test changes in a non-production environment.
* Review the target AWS resources carefully.
* Use least-privilege IAM permissions.
* Confirm that security changes do not disrupt legitimate workloads.
* Review AWS configuration after remediation.
* Maintain backups or rollback procedures where appropriate.

## Results

All three automated remediation scripts were successfully executed:

| AWS Service    | Security Action                   | Status     |
| -------------- | --------------------------------- | ---------- |
| Amazon S3      | Enabled Block Public Access       | Successful |
| AWS IAM        | Enforced stronger password policy | Successful |
| AWS CloudTrail | Enabled log file validation       | Successful |

## Skills Demonstrated

This project demonstrates practical experience with:

* AWS cloud security
* Python scripting
* Boto3 automation
* IAM security hardening
* S3 security controls
* CloudTrail security configuration
* Automated security remediation
* AWS CLI
* Security operations automation
* Infrastructure security

## Conclusion

This project demonstrates how Python and Boto3 can be used to automate common AWS security remediation tasks.

Automating remediation reduces manual effort, improves consistency, and provides a repeatable approach to addressing cloud security misconfigurations.
