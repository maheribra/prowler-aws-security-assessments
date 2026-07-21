# Project 13 — CloudSplaining + Principal Mapper

## Overview

This project combines **CloudSplaining** and **Principal Mapper** to assess AWS IAM security, identify excessive permissions, analyze administrative privileges, and evaluate IAM relationships.

The assessment focuses on the principle of least privilege and identifies IAM permissions that may introduce security risks.

---

## Objectives

* Analyze IAM policies for excessive permissions.
* Identify unrestricted resource access.
* Identify potentially risky IAM permissions.
* Detect administrative IAM principals.
* Analyze effective permissions.
* Identify potential privilege escalation risks.
* Review IAM service-linked roles.
* Provide remediation recommendations.
* Validate IAM security through repeatable assessments.

---

## Tools Used

### CloudSplaining

CloudSplaining analyzes AWS IAM policies and identifies potentially risky permissions, including permissions that may allow privilege escalation, data exposure, or unrestricted access.

### Principal Mapper

Principal Mapper creates an IAM permissions graph and helps identify effective permissions, administrative principals, and relationships between IAM identities and AWS resources.

---

## Project Structure

```text
13-CloudSplaining-PrincipalMapper/
│
├── README.md
├── findings.md
├── remediation.md
│
├── cloudsplaining/
│   ├── reports/
│   │   ├── iam-results-iam-authorization-details.json
│   │   ├── iam-findings-iam-authorization-details.json
│   │   └── iam-report-iam-authorization-details.html
│   │
│   └── output/
│       └── iam-authorization-details.json
│
├── principalmapper/
│   ├── reports/
│   │   └── principalmapper-results.txt
│   │
│   └── output/
│
└── screenshots/
```

---

## Environment

### AWS Account

The assessment was performed against an AWS account using an IAM security assessment identity.

### AWS Region

Principal Mapper regional analysis was restricted to:

```text
eu-west-1
```

### Principal Mapper Environment

Principal Mapper was executed inside a dedicated Python virtual environment:

```text
.venv-pmapper
```

Python version:

```text
Python 3.10
```

The dedicated environment was used because the installed Principal Mapper version requires compatibility adjustments when running on newer Python versions.

---

## Assessment Methodology

The assessment was performed in the following stages:

1. Export AWS IAM account authorization details.
2. Analyze IAM policies with CloudSplaining.
3. Generate JSON and HTML CloudSplaining reports.
4. Create an IAM permissions graph using Principal Mapper.
5. Query effective permissions.
6. Identify administrative principals.
7. Review service-linked roles.
8. Document security findings.
9. Develop remediation recommendations.
10. Re-assess the environment after remediation.

---

# CloudSplaining Assessment

## 1. Export IAM Authorization Details

The AWS IAM account authorization details were exported using:

```bash
aws iam get-account-authorization-details > cloudsplaining/output/iam-authorization-details.json
```

This file was used as the input for the CloudSplaining assessment.

---

## 2. Run CloudSplaining

The IAM authorization details were analyzed using:

```bash
cloudsplaining scan -i cloudsplaining/output/iam-authorization-details.json -o cloudsplaining/reports -s
```

The assessment successfully generated:

```text
iam-results-iam-authorization-details.json
iam-findings-iam-authorization-details.json
iam-report-iam-authorization-details.html
```

The reports are stored under:

```text
cloudsplaining/reports/
```

---

# Principal Mapper Assessment

## 1. Create the IAM Graph

The Principal Mapper IAM graph was created using:

```bash
pmapper graph create --include-regions eu-west-1
```

The graph assessment produced:

```text
Nodes: 12
Administrative principals: 1
Edges: 0
Groups: 0
Tracked policies: 16
```

---

## 2. Query S3 Permissions

The following query was used:

```bash
pmapper query "who can do s3:*"
```

Result:

```text
user/prowler-auditor IS authorized to call action s3:* for resource *
```

This indicates that the identified principal has unrestricted S3 permissions across all resources.

---

## 3. Identify Administrative Principals

The following Principal Mapper preset was used:

```bash
pmapper query "preset privesc *"
```

Result:

```text
user/prowler-auditor is an administrative principal
```

This indicates that the `prowler-auditor` principal has administrative-level permissions.

---

## 4. Review Service Access

The following query was used:

```bash
pmapper query "preset serviceaccess"
```

The assessment identified AWS service-linked roles associated with services including:

* IAM Access Analyzer
* Amazon GuardDuty
* Amazon GuardDuty Malware Protection
* Amazon Inspector
* AWS Config
* Amazon Resource Explorer
* AWS Security Hub
* AWS Support
* AWS Trusted Advisor

These roles should be reviewed to confirm that their associated AWS services are intentionally enabled and required.

---

## 5. Check for Incorrect Administrative Privileges

The following query was used:

```bash
pmapper query "preset wrongadmin"
```

Result:

```text
No results
```

No additional administrative principals matching the `wrongadmin` detection criteria were identified.

---

# Key Findings

| Finding                                                  | Severity      | Status             |
| -------------------------------------------------------- | ------------- | ------------------ |
| `prowler-auditor` identified as administrative principal | Critical      | Requires Review    |
| `s3:*` access on `Resource: *`                           | High          | Requires Review    |
| CloudSplaining IAM policy findings                       | Varies        | Requires Review    |
| AWS service-linked roles identified                      | Informational | Review             |
| `wrongadmin` query returned no results                   | Positive      | No Action Required |

---

## Critical Finding — Administrative Principal

Principal Mapper identified:

```text
user/prowler-auditor
```

as an administrative principal.

Administrative privileges should be restricted to trusted identities that genuinely require them.

The potential impact of compromised administrative credentials includes:

* AWS resource modification or deletion.
* IAM policy modification.
* Creation of additional privileged identities.
* Access to sensitive data.
* Disabling or weakening security controls.
* Persistence within the AWS environment.

---

## High Finding — Unrestricted S3 Permissions

Principal Mapper identified that:

```text
user/prowler-auditor
```

can perform:

```text
s3:*
```

against:

```text
Resource: *
```

This represents broad S3 access and should be reviewed against the actual requirements of the security assessment workflow.

Where possible, S3 permissions should be restricted to:

* Required S3 actions.
* Specific buckets.
* Specific objects.
* Appropriate IAM conditions.

---

# Remediation Recommendations

Recommended remediation actions include:

1. Review the administrative privileges assigned to `prowler-auditor`.
2. Remove unnecessary administrator permissions.
3. Replace broad S3 permissions with task-specific actions.
4. Restrict S3 access to specific resources where possible.
5. Review CloudSplaining findings and remediate excessive permissions.
6. Review AWS service-linked roles and confirm associated services are required.
7. Use IAM roles and temporary credentials where appropriate.
8. Require MFA for interactive privileged access.
9. Monitor IAM changes using AWS CloudTrail.
10. Perform periodic IAM access reviews.
11. Re-run CloudSplaining and Principal Mapper after remediation.

Detailed remediation guidance is available in:

```text
remediation.md
```

---

# Security Principles Demonstrated

This project demonstrates practical application of:

* Principle of Least Privilege.
* IAM policy analysis.
* Effective permission analysis.
* Privilege escalation analysis.
* Administrative privilege identification.
* IAM relationship mapping.
* AWS service-linked role review.
* Security assessment automation.
* Security findings documentation.
* Remediation planning.
* Post-remediation validation.

---

# Assessment Limitations

Principal Mapper's regional analysis was restricted to `eu-west-1`.

Some AWS regions were not analyzed because they were disabled or unavailable to the assessment identity.

The assessment results represent the AWS environment at the time of scanning and should be repeated periodically as IAM permissions and AWS resources change.

Remediation actions should be performed only after confirming the permissions required by the security assessment workflow. Removing required permissions may cause security assessment tools or operational workflows to fail.

---

# Conclusion

The combined CloudSplaining and Principal Mapper assessment identified significant IAM security risks related to excessive privileges and unrestricted S3 access.

The primary findings were:

* An administrative IAM principal was identified.
* Full S3 permissions were granted against all resources.
* CloudSplaining generated IAM policy analysis reports for further review.
* AWS service-linked roles were identified and documented.
* No additional `wrongadmin` findings were identified.

The recommended next step is to review and reduce unnecessary permissions, apply least-privilege IAM policies, and repeat the CloudSplaining and Principal Mapper assessments to validate improvements.

This project demonstrates an end-to-end AWS IAM security assessment workflow covering **discovery, analysis, risk identification, documentation, remediation planning, and validation**.
