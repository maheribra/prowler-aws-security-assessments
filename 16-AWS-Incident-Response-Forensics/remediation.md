# Incident Response Remediation

## 1. Overview

This document defines the remediation actions identified during the AWS incident-response and forensic investigation.

The investigation identified:

1. Unauthorized AWS resource discovery attempts using the `incident-response-test-user` IAM identity.
2. GuardDuty findings indicating root credential usage.
3. Security Hub findings identifying monitoring and logging gaps.
4. An active access key associated with the test IAM identity.

The simulated discovery attempts were successfully blocked by AWS IAM authorization controls. No confirmed resource modification or data deletion was identified.

---

## 2. Immediate Containment

### 2.1 Disable the Test IAM Access Key

The access key associated with the test identity should be disabled after evidence collection is complete.

```bash
aws iam update-access-key \
  --user-name incident-response-test-user \
  --access-key-id AKIAQIOHLQYDZI3TPU54 \
  --status Inactive
```

This prevents further API requests using the identified credential while preserving the IAM user and access key metadata for investigation.

### 2.2 Delete the Test User After Evidence Collection

Once all investigation evidence has been collected, the test IAM user can be removed.

```bash
aws iam delete-access-key \
  --user-name incident-response-test-user \
  --access-key-id AKIAQIOHLQYDZI3TPU54
```

Then delete the test user:

```bash
aws iam delete-user \
  --user-name incident-response-test-user
```

The user should only be deleted after all required evidence has been collected and documented.

---

## 3. IAM Security Improvements

### 3.1 Enforce Least Privilege

IAM identities should only receive the permissions required to perform their intended functions.

Recommended actions:

* Remove unnecessary permissions.
* Avoid broad `AdministratorAccess` permissions where possible.
* Review IAM policies regularly.
* Use IAM Access Analyzer to identify excessive access.
* Apply permissions based on job function.
* Review permissions following role or responsibility changes.

### 3.2 Prefer Temporary Credentials

Long-lived IAM access keys should be avoided where possible.

Recommended alternatives include:

* IAM roles
* AWS IAM Identity Center
* Short-lived STS credentials
* Workload identity mechanisms

Temporary credentials reduce the risk associated with stolen or leaked long-lived access keys.

### 3.3 Access Key Management

IAM access keys should be:

* Rotated regularly.
* Disabled when not required.
* Removed when no longer needed.
* Stored securely.
* Never committed to source code.
* Monitored for unusual activity.

---

## 4. Root Account Security

GuardDuty identified repeated API activity using AWS root credentials.

The root account should not be used for routine AWS API operations.

Recommended actions:

1. Enable MFA on the root account.
2. Remove root access keys if they exist and are not required.
3. Use IAM roles for administrative operations.
4. Review all root account API activity.
5. Confirm whether the detected root activity was authorized.
6. Investigate the source IP and timestamps associated with the activity.
7. Monitor future root credential usage.

Root credential usage should generate an immediate security review because of the unrestricted privileges associated with the root identity.

---

## 5. CloudTrail Improvements

CloudTrail provided valuable forensic evidence during this investigation.

The following improvements are recommended:

* Maintain multi-region CloudTrail logging.
* Enable log file validation.
* Encrypt CloudTrail logs using AWS KMS.
* Send CloudTrail logs to a dedicated S3 bucket.
* Restrict access to CloudTrail logs.
* Enable CloudTrail integration with CloudWatch Logs.
* Retain logs according to organizational requirements.
* Protect logs against unauthorized deletion or modification.

CloudTrail should provide centralized visibility into AWS API activity across the environment.

---

## 6. CloudWatch Monitoring and Alerting

Security Hub identified several missing or incomplete monitoring controls.

Recommended CloudWatch monitoring should include alerts for:

* Root user activity
* IAM policy changes
* CloudTrail configuration changes
* S3 bucket policy changes
* VPC configuration changes
* KMS key state changes
* Console authentication failures
* Console sign-ins without MFA
* AWS Config configuration changes

These alerts should notify the appropriate security or operations team when sensitive activity occurs.

---

## 7. GuardDuty

Amazon GuardDuty should remain enabled and monitored.

Recommended actions:

* Review GuardDuty findings regularly.
* Investigate root credential usage.
* Configure automated notification of high-severity findings.
* Integrate GuardDuty with Security Hub.
* Forward relevant findings to an incident-response workflow.
* Establish documented response procedures for compromised credentials.

GuardDuty findings should be investigated in conjunction with CloudTrail events to establish the complete sequence of activity.

---

## 8. Security Hub

AWS Security Hub should be used as a centralized security findings platform.

Recommended actions:

* Review active findings regularly.
* Prioritize findings based on severity and business impact.
* Remediate critical and high-priority findings first.
* Track remediation status.
* Enable relevant security standards.
* Integrate findings into incident-response workflows.

The Security Hub findings identified during this investigation should be reviewed and remediated according to organizational priorities.

---

## 9. Incident Response Workflow

A repeatable response process should be established for suspected AWS credential compromise.

Recommended workflow:

```text
Suspicious Activity Detected
          ↓
Identify IAM Identity
          ↓
Review CloudTrail Events
          ↓
Check GuardDuty Findings
          ↓
Review Security Hub Findings
          ↓
Determine Scope and Impact
          ↓
Contain Credentials
          ↓
Rotate or Revoke Access
          ↓
Investigate Persistence
          ↓
Remediate Security Gaps
          ↓
Document Incident
          ↓
Monitor for Recurrence
```

---

## 10. Credential Compromise Response

If an IAM access key is suspected to be compromised, responders should:

1. Identify the affected IAM identity.
2. Identify all associated access keys.
3. Review CloudTrail activity.
4. Identify suspicious API operations.
5. Determine the source IP addresses.
6. Disable the affected access key.
7. Review for persistence mechanisms.
8. Check for unauthorized IAM users and roles.
9. Review changes to security controls.
10. Rotate or remove compromised credentials.
11. Investigate potential data access or resource modification.
12. Continue monitoring for additional suspicious activity.

---

## 11. Findings and Remediation Summary

| Finding                             | Recommended Action                           | Priority |
| ----------------------------------- | -------------------------------------------- | -------- |
| Unauthorized API discovery attempts | Review and monitor IAM activity              | Medium   |
| Active test access key              | Disable and delete after evidence collection | High     |
| Root credential usage               | Investigate and confirm authorization        | High     |
| Missing root activity alerting      | Configure CloudWatch metric filter and alarm | High     |
| CloudTrail monitoring gaps          | Improve multi-region logging and monitoring  | High     |
| IAM policy monitoring gaps          | Configure monitoring and alerting            | Medium   |
| S3 policy monitoring gaps           | Configure monitoring and alerting            | Medium   |
| VPC change monitoring gaps          | Configure monitoring and alerting            | Medium   |
| Authentication monitoring gaps      | Configure monitoring and alerting            | Medium   |
| KMS monitoring gaps                 | Configure monitoring and alerting            | Medium   |

---

## 12. Final Assessment

The simulated incident demonstrated that AWS IAM least-privilege controls successfully prevented an identity with limited permissions from performing unauthorized resource discovery.

CloudTrail provided detailed forensic evidence that enabled the investigation team to identify the IAM identity, access key, API operations, timestamps, and source information associated with the activity.

GuardDuty provided additional visibility into root credential usage, while Security Hub highlighted weaknesses in monitoring and security configuration.

The primary remediation priorities are:

1. Disable and remove the test credentials after evidence collection.
2. Investigate the root credential activity identified by GuardDuty.
3. Strengthen CloudTrail and CloudWatch monitoring.
4. Configure alerting for sensitive security events.
5. Continue enforcing least-privilege IAM access.
6. Prefer temporary credentials over long-lived access keys.
7. Establish a repeatable AWS credential-compromise response procedure.

These improvements will strengthen the organization's ability to detect, investigate, contain, and recover from future AWS security incidents.
