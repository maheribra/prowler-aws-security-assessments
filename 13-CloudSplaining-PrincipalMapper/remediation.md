# Remediation — CloudSplaining + Principal Mapper

## Remediation Overview

The CloudSplaining and Principal Mapper assessment identified IAM permissions that should be reviewed to ensure compliance with the principle of least privilege.

The primary risks identified were:

* Administrative privileges assigned to the `prowler-auditor` IAM user.
* Full S3 permissions (`s3:*`) across all S3 resources.
* Broad IAM permissions that may exceed the requirements of a security assessment account.

The following remediation actions are recommended.

---

## 1. Remediate Excessive Administrative Privileges

### Finding

Principal Mapper identified:

```text
user/prowler-auditor is an administrative principal
```

### Risk

Administrative permissions provide broad access to AWS resources and IAM functionality.

If the credentials associated with the user are compromised, an attacker may be able to:

* Access sensitive AWS resources.
* Modify or delete infrastructure.
* Create or modify IAM identities.
* Grant additional permissions.
* Disable security services.
* Establish persistence within the AWS environment.

### Recommended Remediation

Determine whether administrative access is required for the `prowler-auditor` account.

If administrative access is not required:

1. Review the policies attached to `prowler-auditor`.
2. Identify the specific AWS services required for security assessments.
3. Remove unnecessary administrator policies.
4. Replace broad permissions with narrowly scoped policies.
5. Restrict permissions to the required resources.
6. Regularly review the account's permissions.

Use AWS IAM Access Analyzer to help identify unused and excessive permissions.

### Validation

After remediation, recreate the Principal Mapper graph:

```bash
pmapper graph create --include-regions eu-west-1
```

Then verify administrative privileges:

```bash
pmapper query "preset privesc *"
```

The expected result is that `prowler-auditor` is no longer identified as an administrative principal, assuming administrator access is not operationally required.

---

## 2. Restrict Full S3 Permissions

### Finding

Principal Mapper identified:

```text
user/prowler-auditor IS authorized to call action s3:* for resource *
```

### Risk

The `s3:*` permission grants broad access to Amazon S3.

The wildcard resource:

```text
*
```

means the permissions are not restricted to specific S3 resources.

Depending on the attached policies, this could allow the principal to:

* List buckets.
* Read objects.
* Upload objects.
* Delete objects.
* Modify bucket configurations.
* Modify access controls.
* Access sensitive data.

### Recommended Remediation

Replace:

```text
s3:*
```

with only the S3 actions required for the security assessment.

For example, if the assessment only requires read access, consider restricting permissions to the required read-only actions.

Where possible, restrict access to specific resources instead of:

```text
Resource: *
```

For example:

```text
arn:aws:s3:::example-security-assessment-bucket
```

and, where required:

```text
arn:aws:s3:::example-security-assessment-bucket/*
```

Avoid granting write or delete permissions unless they are explicitly required.

### Validation

After modifying the IAM policies, recreate the Principal Mapper graph:

```bash
pmapper graph create --include-regions eu-west-1
```

Then run:

```bash
pmapper query "who can do s3:*"
```

The expected result is that `prowler-auditor` is no longer authorized for unrestricted `s3:*` access.

Re-run CloudSplaining to confirm that excessive S3 permissions have been reduced.

---

## 3. Review IAM Policies Identified by CloudSplaining

### Finding

CloudSplaining successfully analyzed the IAM authorization details and generated reports containing potential IAM security risks.

Reports generated:

```text
cloudsplaining/reports/iam-results-iam-authorization-details.json
cloudsplaining/reports/iam-findings-iam-authorization-details.json
cloudsplaining/reports/iam-report-iam-authorization-details.html
```

### Recommended Remediation

Review each CloudSplaining finding and determine whether the identified permission is operationally required.

For each unnecessary permission:

1. Identify the IAM policy containing the permission.
2. Determine which principal is using the policy.
3. Identify the required AWS actions.
4. Remove unnecessary actions.
5. Replace wildcard actions with specific actions.
6. Replace wildcard resources with specific ARNs where supported.
7. Add appropriate IAM conditions where possible.
8. Re-run CloudSplaining after making changes.

Priority should be given to:

* Critical findings.
* High-severity findings.
* Privilege escalation permissions.
* Wildcard permissions.
* Permissions that allow data access or exfiltration.
* Permissions that allow IAM policy modification.

---

## 4. Review Service-Linked Roles

### Finding

Principal Mapper identified service-linked roles associated with AWS services including:

* IAM Access Analyzer
* Amazon GuardDuty
* Amazon GuardDuty Malware Protection
* Amazon Inspector
* AWS Config
* Amazon Resource Explorer
* AWS Security Hub
* AWS Security Hub v2
* AWS Support
* AWS Trusted Advisor

### Recommended Remediation

Service-linked roles are normally managed by AWS and should not be manually modified.

Instead:

1. Confirm that the associated AWS services are intentionally enabled.
2. Confirm that the service-linked roles are expected.
3. Review whether the services are still required.
4. Disable unused AWS services through their respective service configuration where appropriate.
5. Allow AWS to manage the lifecycle of the associated service-linked roles.

Do not delete service-linked roles manually unless the associated AWS service no longer requires them and AWS permits their removal.

---

## 5. Implement Least-Privilege Access

The assessment demonstrates that IAM permissions should follow the principle of least privilege.

Recommended practices include:

* Grant only required permissions.
* Avoid `Action: "*"` where possible.
* Avoid `Resource: "*"` where possible.
* Use resource-level permissions when supported.
* Use IAM conditions to restrict access.
* Separate administrative accounts from assessment and operational accounts.
* Use temporary credentials where possible.
* Review IAM policies regularly.
* Remove unused permissions.
* Monitor IAM activity using AWS CloudTrail.

---

## 6. Use Dedicated Security Assessment Roles

The `prowler-auditor` user should be reviewed to determine whether a dedicated IAM role is more appropriate.

Where possible:

* Use IAM roles instead of long-term IAM user access keys.
* Use temporary credentials.
* Require MFA for interactive access.
* Limit access to the permissions required by security assessment tools.
* Avoid using permanent administrator credentials for routine assessments.

A dedicated security assessment role should contain only the permissions required by the assessment tools and workflows.

---

## 7. Enable Continuous IAM Monitoring

IAM permissions should be continuously reviewed because permissions can change over time.

Recommended controls include:

* AWS IAM Access Analyzer.
* AWS CloudTrail.
* AWS Config.
* AWS Security Hub.
* Regular IAM access reviews.
* Monitoring unused IAM permissions.
* Periodic review of privileged identities.

IAM changes should be tracked and investigated when unexpected modifications occur.

---

## 8. Re-Assessment After Remediation

After remediation is completed, repeat both assessments.

### CloudSplaining

Export the latest IAM authorization details:

```bash
aws iam get-account-authorization-details > cloudsplaining/output/iam-authorization-details-after.json
```

Run CloudSplaining again:

```bash
cloudsplaining scan -i cloudsplaining/output/iam-authorization-details-after.json -o cloudsplaining/reports -s
```

### Principal Mapper

Recreate the IAM graph:

```bash
pmapper graph create --include-regions eu-west-1
```

Check administrative privileges:

```bash
pmapper query "preset privesc *"
```

Check unrestricted S3 access:

```bash
pmapper query "who can do s3:*"
```

Check for incorrectly identified administrative principals:

```bash
pmapper query "preset wrongadmin"
```

Compare the results against the original assessment.

---

## 9. Expected Outcome

Successful remediation should result in:

* Removal of unnecessary administrative privileges.
* Reduced S3 permissions.
* Removal of unnecessary wildcard permissions.
* More narrowly scoped IAM policies.
* Reduced privilege escalation risk.
* Improved adherence to least privilege.
* Better separation of administrative and assessment roles.
* Improved visibility into IAM relationships and effective permissions.

The final security posture should be validated by repeating the CloudSplaining and Principal Mapper assessments and comparing the before-and-after results.

---

## Remediation Status

| Finding                                    | Recommended Action                          | Status             |
| ------------------------------------------ | ------------------------------------------- | ------------------ |
| Administrative `prowler-auditor` principal | Review and reduce administrative privileges | Requires Review    |
| Unrestricted `s3:*` permissions            | Restrict actions and resources              | Requires Review    |
| CloudSplaining IAM findings                | Review and remediate excessive permissions  | Requires Review    |
| Service-linked roles                       | Validate associated services                | Review             |
| `wrongadmin` Principal Mapper query        | No findings identified                      | No Action Required |
| Continuous IAM monitoring                  | Implement ongoing monitoring                | Recommended        |
| Post-remediation validation                | Re-run both tools                           | Recommended        |

> **Note:** Remediation actions should be performed only after confirming the permissions required by the security assessment workflow. Removing required permissions may cause security assessment tools or operational workflows to fail.
