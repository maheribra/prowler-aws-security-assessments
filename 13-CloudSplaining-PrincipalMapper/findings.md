# Findings — CloudSplaining + Principal Mapper

## Assessment Overview

This assessment evaluates AWS IAM security using two complementary tools:

* **CloudSplaining** — analyzes IAM policies for excessive permissions, unrestricted resource access, and risky IAM actions.
* **Principal Mapper** — builds an IAM relationship graph and identifies effective permissions and administrative principals.

The assessment was performed against AWS account `018134828551` using the `prowler-auditor` IAM user.

---

## 1. CloudSplaining Assessment

### Tool

CloudSplaining

### Assessment Input

The IAM account authorization details were exported using:

```bash
aws iam get-account-authorization-details > cloudsplaining/output/iam-authorization-details.json
```

The authorization details were then analyzed using:

```bash
cloudsplaining scan -i cloudsplaining/output/iam-authorization-details.json -o cloudsplaining/reports -s
```

### Generated Reports

The assessment generated:

* `iam-results-iam-authorization-details.json`
* `iam-findings-iam-authorization-details.json`
* `iam-report-iam-authorization-details.html`

### Assessment Result

CloudSplaining successfully completed the IAM policy assessment and generated HTML and JSON reports for further analysis.

The generated reports should be reviewed to identify:

* Policies with unrestricted resource access
* Policies containing risky IAM actions
* Potential privilege escalation permissions
* Permissions that may allow data exposure or exfiltration
* Infrastructure modification capabilities
* Policies that could be reduced according to least-privilege principles

The detailed CloudSplaining findings are available in the generated JSON and HTML reports stored under:

```text
cloudsplaining/reports/
```

---

## 2. Principal Mapper Assessment

### Tool

Principal Mapper v1.1.5

### Python Environment

Principal Mapper was executed using a dedicated Python 3.10 virtual environment because the installed Principal Mapper version is not compatible with newer Python versions without modification.

Virtual environment:

```text
.venv-pmapper
```

### Graph Creation

The IAM graph was created using the active AWS region:

```bash
pmapper graph create --include-regions eu-west-1
```

### Graph Results

The generated Principal Mapper graph contained:

* **Nodes:** 12
* **Administrative principals:** 1
* **Edges:** 0
* **Groups:** 0
* **Tracked policies:** 16

---

## 3. Finding — Administrative IAM Principal

### Severity

**Critical**

### Description

Principal Mapper identified the following principal as an administrative principal:

```text
user/prowler-auditor
```

The following query was used:

```bash
pmapper query "preset privesc *"
```

Result:

```text
user/prowler-auditor is an administrative principal
```

### Security Impact

An administrative IAM principal has broad permissions across the AWS environment. If the credentials associated with this principal are compromised, an attacker may be able to:

* Modify or delete AWS resources
* Access sensitive data
* Modify IAM permissions
* Create additional privileged identities
* Disable or weaken security controls
* Establish persistence within the AWS account

Administrative permissions should only be granted when operationally necessary.

---

## 4. Finding — Unrestricted S3 Permissions

### Severity

**High**

### Description

Principal Mapper identified that:

```text
user/prowler-auditor
```

is authorized to perform:

```text
s3:*
```

against:

```text
Resource: *
```

The query used was:

```bash
pmapper query "who can do s3:*"
```

Result:

```text
user/prowler-auditor IS authorized to call action s3:* for resource *
```

### Security Impact

The principal has broad S3 permissions across all S3 resources rather than access being limited to specific buckets or objects.

If the credentials are compromised, an attacker may potentially:

* List S3 buckets
* Read objects
* Upload objects
* Delete objects
* Modify bucket configurations
* Access sensitive data stored in S3

This violates the principle of least privilege unless the broad permissions are explicitly required.

---

## 5. Finding — Service-Linked Roles

### Severity

**Informational**

### Description

Principal Mapper identified AWS service-linked roles associated with the following services:

* AWS IAM Access Analyzer
* Amazon GuardDuty
* Amazon GuardDuty Malware Protection
* Amazon Inspector
* AWS Config
* Amazon Resource Explorer
* AWS Security Hub
* AWS Security Hub CSPM / Security Hub v2
* AWS Support
* AWS Trusted Advisor

These roles are associated with AWS service principals and are generally created and managed by AWS services.

### Security Impact

Service-linked roles are typically expected in AWS environments where the corresponding services are enabled.

They should nevertheless be periodically reviewed to ensure:

* The associated AWS service is still required.
* The service-linked role is expected.
* No unnecessary AWS security services remain enabled without operational purpose.

No immediate security issue was identified from this finding alone.

---

## 6. Finding — Wrong Administrative Privilege

### Severity

**Informational / Positive Result**

The Principal Mapper query:

```bash
pmapper query "preset wrongadmin"
```

returned no results.

This indicates that Principal Mapper did not identify an additional administrative principal matching its `wrongadmin` detection criteria.

This is a positive result; however, it does not eliminate the risk associated with the confirmed administrative `prowler-auditor` principal.

---

## 7. Overall Assessment Summary

The combined CloudSplaining and Principal Mapper assessment identified significant IAM security risks.

### Primary Risks

1. **Administrative privileges assigned to `prowler-auditor`.**
2. **Full S3 permissions (`s3:*`) granted against all resources (`*`).**
3. **Broad permissions should be reviewed against operational requirements and reduced where possible.**

### Positive Results

* CloudSplaining successfully generated IAM policy assessment reports.
* Principal Mapper successfully generated an IAM permissions graph.
* No `wrongadmin` findings were returned by Principal Mapper.
* AWS service-linked roles were identified and documented for review.

### Recommended Priority

The highest priority should be reviewing the `prowler-auditor` IAM user's administrative access and determining whether full administrative and S3 permissions are genuinely required.

Where possible, permissions should be replaced with narrowly scoped, task-specific policies following the principle of least privilege.
