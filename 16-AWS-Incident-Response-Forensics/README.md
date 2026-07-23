# AWS Incident Response & Forensics

## Overview

This project demonstrates a simulated AWS security incident involving a compromised or suspicious IAM identity performing unauthorized resource discovery attempts.

The assessment uses native AWS security and monitoring services to investigate, analyze, and document suspicious activity across an AWS environment.

The investigation demonstrates an incident-response workflow covering:

* IAM identity investigation
* AWS access key investigation
* CloudTrail forensic analysis
* GuardDuty threat detection
* Security Hub security findings
* Unauthorized API activity analysis
* Incident timeline development
* Security impact assessment
* Credential containment and cleanup
* Remediation recommendations

The project was conducted in an authorized AWS test environment for security assessment and incident-response learning purposes.

---

## Objectives

The primary objectives of this project were to:

1. Simulate suspicious IAM activity in an AWS environment.
2. Investigate the identity responsible for the activity.
3. Analyze AWS API calls recorded by CloudTrail.
4. Identify unauthorized resource discovery attempts.
5. Review GuardDuty findings for additional security indicators.
6. Analyze Security Hub findings related to monitoring and logging.
7. Build a forensic incident timeline.
8. Assess the potential security impact.
9. Contain the simulated compromised credentials.
10. Document remediation and security improvement recommendations.

---

## Architecture / Investigation Flow

```text
                    AWS Account
                         │
                         ▼
              incident-response-test-user
                         │
                         │ AWS Access Key
                         ▼
              Suspicious API Activity
                         │
              ┌──────────┼──────────┐
              │          │          │
              ▼          ▼          ▼
             S3         EC2        IAM
              │          │          │
              └──────────┼──────────┘
                         │
                         ▼
                    AWS CloudTrail
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
        Amazon GuardDuty       AWS Security Hub
             │                       │
             └───────────┬───────────┘
                         ▼
                Incident Investigation
                         │
                         ▼
                 Forensic Analysis
                         │
                         ▼
                    Containment
                         │
                         ▼
              Credential Deletion
```

---

## Incident Scenario

An IAM user named:

```text
incident-response-test-user
```

was created specifically for the incident-response simulation.

The identity was provided with limited AWS permissions and used to simulate suspicious reconnaissance activity.

The simulated activity included attempts to discover:

* IAM users
* IAM roles
* IAM policies
* S3 buckets
* EC2 instances
* EC2 security groups
* AWS account information

The attempted discovery operations were denied by AWS IAM because the identity did not have the required permissions.

The identity was nevertheless able to authenticate successfully and generate AWS API requests, demonstrating how a compromised credential with limited privileges can still generate suspicious activity requiring investigation.

---

## Incident Response Workflow

The investigation followed the following workflow:

```text
1. Create Test IAM Identity
          │
          ▼
2. Generate Simulated Suspicious Activity
          │
          ▼
3. Investigate IAM Identity
          │
          ▼
4. Analyze CloudTrail Events
          │
          ▼
5. Review GuardDuty Findings
          │
          ▼
6. Review Security Hub Findings
          │
          ▼
7. Build Incident Timeline
          │
          ▼
8. Assess Security Impact
          │
          ▼
9. Collect Evidence
          │
          ▼
10. Disable/Delete Test Credentials
          │
          ▼
11. Document Remediation
```

---

## Investigation Results

### Finding 1 — Unauthorized AWS Resource Discovery Attempts

The test identity performed a series of read-only AWS API requests that attempted to discover information about the AWS environment.

Confirmed CloudTrail activity included:

| Time         | Service | API Operation            | Result        |
| ------------ | ------- | ------------------------ | ------------- |
| 19:30:56 UTC | STS     | `GetCallerIdentity`      | Successful    |
| 19:33:46 UTC | S3      | `ListAllMyBuckets`       | Access Denied |
| 19:33:53 UTC | EC2     | `DescribeInstances`      | Unauthorized  |
| 19:34:13 UTC | EC2     | `DescribeSecurityGroups` | Unauthorized  |

The activity was associated with the IAM identity:

```text
incident-response-test-user
```

The attempted discovery operations were unsuccessful because of insufficient IAM permissions.

No evidence was identified that the test identity successfully modified or deleted AWS resources.

**Severity:** Medium

**Status:** Contained

---

### Finding 2 — Root Credential Usage Detected by GuardDuty

Amazon GuardDuty identified separate activity involving AWS root credentials.

The following findings were observed:

* `DescribeRegions` invoked using root credentials
* `ListAccountAliases` invoked using root credentials

GuardDuty classified both findings as:

```text
Policy:IAMUser/RootCredentialUsage
```

The activity was observed from a remote IP address and was associated with the AWS root identity.

This activity was assessed separately from the simulated `incident-response-test-user` investigation.

The GuardDuty findings demonstrate the importance of monitoring and restricting root credential usage.

**Severity:** Low

**Status:** Investigation Required

---

### Finding 3 — Security Hub Monitoring and Logging Gaps

AWS Security Hub identified several security configuration and monitoring gaps.

The most relevant finding was:

```text
CloudWatch.1
A log metric filter and alarm should exist for usage of the "root" user
```

Additional findings related to:

* CloudTrail configuration changes
* IAM policy changes
* S3 bucket policy changes
* KMS key state changes
* VPC changes
* Management Console authentication failures
* Management Console sign-ins without MFA
* AWS Config configuration changes

Several findings were related to the absence of the required multi-region CloudTrail configuration for the relevant controls.

These findings do not demonstrate that the simulated test identity successfully compromised the AWS environment.

Instead, they highlight opportunities to improve security monitoring, alerting, and incident-response readiness.

**Severity:** Low

**Status:** Open

---

## Incident Timeline

| Time         | Event                       | Description                                                                                |
| ------------ | --------------------------- | ------------------------------------------------------------------------------------------ |
| 19:18 UTC    | Test identity created       | IAM user `incident-response-test-user` created for authorized incident-response simulation |
| 19:27 UTC    | Access key created          | Test access key created for controlled API activity                                        |
| 19:30:56 UTC | Authentication verified     | Test identity successfully called `sts:GetCallerIdentity`                                  |
| 19:33 UTC    | IAM discovery attempted     | IAM enumeration activity was attempted                                                     |
| 19:33:46 UTC | S3 discovery attempted      | `s3:ListAllMyBuckets` was attempted and denied                                             |
| 19:33:53 UTC | EC2 discovery attempted     | `ec2:DescribeInstances` was attempted and denied                                           |
| 19:34:13 UTC | Network discovery attempted | `ec2:DescribeSecurityGroups` was attempted and denied                                      |
| 20:34 UTC    | CloudTrail investigation    | CloudTrail events were queried to investigate activity associated with the test identity   |
| Completed    | Evidence collection         | CloudTrail, GuardDuty, Security Hub, and IAM evidence collected                            |
| Completed    | Credential containment      | Test access key deleted after investigation and evidence collection                        |
| Completed    | Incident closure            | Investigation and cleanup completed                                                        |

---

## Containment

After evidence collection was completed, the test access key associated with the simulated incident was removed.

The access key was:

```text
Deleted after investigation
```

The credential cleanup ensured that the test identity could no longer authenticate using the simulated access key.

This completed the containment phase of the incident simulation.

No production credentials were intentionally compromised as part of this assessment.

---

## Security Controls Demonstrated

The project demonstrated the following AWS security controls and capabilities:

### IAM

* Identity and access management
* Least-privilege permissions
* Access key management
* Unauthorized API request prevention
* Credential containment

### AWS CloudTrail

* API activity logging
* Management event investigation
* IAM identity attribution
* API operation analysis
* Forensic timeline development

### Amazon GuardDuty

* Detection of suspicious root credential usage
* Security finding investigation
* Threat detection context

### AWS Security Hub

* Security control findings
* Monitoring gap identification
* Security posture analysis
* Incident-response context

---

## Key Findings

The assessment demonstrated several important security principles:

### 1. Least Privilege Limits Attack Impact

The simulated IAM identity was able to authenticate but could not perform unauthorized discovery operations because it lacked the required permissions.

### 2. Successful Authentication Does Not Mean Successful Compromise

An attacker with valid credentials may still be restricted by IAM authorization controls.

However, successful authentication should still be investigated if the resulting activity is suspicious.

### 3. CloudTrail Provides Critical Forensic Evidence

CloudTrail allowed the investigation to associate API activity with:

* IAM identity
* API operation
* AWS service
* Timestamp
* Source IP
* Authentication method
* User agent

### 4. GuardDuty Provides Additional Detection Context

GuardDuty identified separate root credential usage that required investigation.

This demonstrated the value of combining threat detection with CloudTrail forensic analysis.

### 5. Security Hub Identifies Monitoring Gaps

Security Hub highlighted areas where additional monitoring and alerting could improve incident detection and response.

### 6. Credential Containment Is Critical

Once the investigation was complete, the simulated access key was deleted to prevent further use.

---

## Remediation Recommendations

The following security improvements are recommended:

### IAM

* Continue enforcing least-privilege IAM policies.
* Remove unnecessary permissions.
* Regularly review IAM users and roles.
* Prefer IAM roles and temporary credentials where possible.
* Avoid long-lived access keys.
* Rotate credentials regularly where access keys are required.
* Enable MFA for privileged human identities.
* Remove unused credentials.

### Root Account Security

* Avoid using root credentials for routine AWS API operations.
* Enable MFA for the AWS root user.
* Remove root access keys if they exist and are unnecessary.
* Investigate unexpected root credential usage immediately.
* Monitor root-user activity with CloudWatch alarms and metric filters.

### CloudTrail

* Maintain multi-region CloudTrail logging.
* Enable appropriate management event logging.
* Send CloudTrail logs to CloudWatch Logs where appropriate.
* Protect CloudTrail logs from unauthorized modification or deletion.
* Monitor security-sensitive API activity.

### Monitoring

Configure monitoring and alerting for:

* Root-user activity
* IAM policy changes
* CloudTrail configuration changes
* S3 bucket policy changes
* VPC configuration changes
* KMS key state changes
* Console authentication failures
* Console logins without MFA

### Detection and Response

* Continue using GuardDuty for threat detection.
* Use Security Hub for centralized security findings.
* Integrate findings into an incident-response workflow.
* Establish automated credential containment procedures.
* Regularly test incident-response procedures.

---

## Evidence

### Evidence Files

```text
evidence/
├── cloudtrail-incident-events.json
├── guardduty-findings.json
└── securityhub-findings.json
```

### Screenshots

```text
screenshots/
├── access-key-investigation.png
├── iam-list-users-access-denied.png
├── incident-test-identity.png
├── test-user-created.png
└── unauthorized-discovery-attempts.png
```

The GuardDuty root credential findings were retained as JSON evidence but a separate screenshot was not included.

---

## Project Structure

```text
16-AWS-Incident-Response-Forensics/
│
├── findings.md
├── incident-timeline.md
├── remediation.md
├── README.md
│
├── evidence/
│   ├── cloudtrail-incident-events.json
│   ├── guardduty-findings.json
│   └── securityhub-findings.json
│
├── reports/
│
├── screenshots/
│   ├── access-key-investigation.png
│   ├── iam-list-users-access-denied.png
│   ├── incident-test-identity.png
│   ├── test-user-created.png
│   └── unauthorized-discovery-attempts.png
│
└── scripts/
```

---

## Incident Status

**Investigation:** Complete

**Evidence Collection:** Complete

**Containment:** Complete

**Credential Cleanup:** Complete

**Impact:** No confirmed resource modification or data deletion

**Primary Security Control:** IAM least privilege

**Primary Forensic Evidence Source:** AWS CloudTrail

**Threat Detection Source:** Amazon GuardDuty

**Security Posture Source:** AWS Security Hub

---

## Conclusion

This project demonstrates a complete simulated AWS incident-response and forensic investigation workflow.

A controlled IAM identity was used to simulate suspicious reconnaissance activity. AWS IAM permissions prevented the identity from successfully enumerating protected resources, while CloudTrail provided the forensic evidence required to investigate the activity.

Amazon GuardDuty provided additional visibility into separate root credential usage, while AWS Security Hub identified monitoring and logging gaps that could affect future incident detection and response.

The simulated credentials were removed after evidence collection, completing the containment and cleanup process.

The assessment demonstrates how AWS-native security services can work together to support the detection, investigation, containment, and remediation of cloud security incidents.

---

## Technologies Used

* Amazon Web Services (AWS)
* AWS IAM
* AWS CloudTrail
* Amazon GuardDuty
* AWS Security Hub
* AWS CLI
* Windows Command Prompt
* JSON
* Markdown

---

## Disclaimer

This project was performed in an authorized AWS test environment for educational, portfolio, and security assessment purposes.

The simulated activity was intentionally generated to demonstrate AWS incident-response and forensic investigation techniques. No unauthorized access to third-party systems or resources was performed.
