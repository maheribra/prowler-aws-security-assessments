# Incident Timeline

## Simulated AWS Security Incident

| Time                | Event                           | Description                                                                                                             |
| ------------------- | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| 19:18 UTC           | Test identity created           | IAM user `incident-response-test-user` was created for authorized incident-response simulation.                         |
| 19:27 UTC           | Access key created              | An active IAM access key was created for the test identity.                                                             |
| 19:30:56 UTC        | Authentication verified         | The test identity successfully called `sts:GetCallerIdentity`.                                                          |
| 19:33 UTC           | IAM discovery attempted         | The identity attempted IAM enumeration operations, which were denied due to insufficient permissions.                   |
| 19:33:46 UTC        | S3 discovery attempted          | `s3:ListAllMyBuckets` was attempted and denied.                                                                         |
| 19:33:53 UTC        | EC2 discovery attempted         | `ec2:DescribeInstances` was attempted and denied.                                                                       |
| 19:34:13 UTC        | Network discovery attempted     | `ec2:DescribeSecurityGroups` was attempted and denied.                                                                  |
| 20:34 UTC           | CloudTrail investigation        | CloudTrail events were queried to investigate API activity associated with the test identity.                           |
| 20:34 UTC           | Unauthorized activity confirmed | CloudTrail confirmed that the denied API requests were associated with `incident-response-test-user`.                   |
| Investigation phase | GuardDuty investigation         | GuardDuty findings were reviewed and root credential usage findings were identified as a separate security observation. |
| Investigation phase | Security Hub investigation      | Security Hub findings were reviewed to identify monitoring, logging, and security configuration gaps.                   |
| Pending             | Containment                     | Test credentials will be disabled or deleted after evidence collection.                                                 |
| Pending             | Remediation                     | IAM access, monitoring, logging, and incident-response recommendations will be documented.                              |

---

## Initial Assessment

The simulated incident involved a test IAM identity performing multiple read-only discovery attempts against AWS services.

The attempted actions included IAM, S3, and EC2 resource discovery.

The actions were unsuccessful due to insufficient IAM permissions.

CloudTrail provided forensic evidence linking the API requests to the test IAM identity and recording the associated AWS API activity.

The investigation also identified separate GuardDuty findings related to root credential usage. These findings were not attributed to the simulated `incident-response-test-user` activity and were treated as a separate security observation.

AWS Security Hub findings were also reviewed to identify monitoring and logging weaknesses that could affect the organization's ability to detect and respond to future security incidents.

---

## Incident Response Phases

### 1. Preparation

A dedicated IAM test identity was created to safely simulate suspicious AWS API activity without intentionally modifying or deleting resources.

### 2. Detection

Unauthorized API requests were identified through AWS IAM authorization failures and subsequently investigated using CloudTrail.

GuardDuty and Security Hub were also queried to provide additional security context.

### 3. Investigation

CloudTrail events were reviewed to identify:

* The IAM identity involved
* The access key used
* API operations attempted
* Event timestamps
* Source IP address
* AWS services targeted
* Authorization failure reasons

### 4. Containment

The test IAM credentials are scheduled to be disabled or deleted after evidence collection is complete.

### 5. Remediation

Recommended remediation actions include:

* Enforcing least-privilege IAM policies
* Rotating or removing unnecessary access keys
* Monitoring suspicious IAM activity
* Improving CloudTrail configuration
* Implementing CloudWatch monitoring and alerting
* Monitoring root account activity
* Reviewing GuardDuty findings
* Reviewing Security Hub findings

---

## Current Incident Status

**Status:** Investigation Complete — Containment Pending

**Impact:** No confirmed resource modification or data deletion

**Primary Security Control:** IAM least privilege

**Primary Evidence Source:** AWS CloudTrail

**Additional Detection Sources:** Amazon GuardDuty and AWS Security Hub

**Next Action:** Disable or delete the test IAM credentials after completing evidence collection.
