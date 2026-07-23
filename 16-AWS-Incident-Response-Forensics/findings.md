# Incident Findings

## Finding 1 — Unauthorized AWS Resource Discovery Attempts

**Severity:** Medium

**Status:** Contained

**Affected Identity:** `incident-response-test-user`

**Incident Type:** Suspicious IAM activity / Unauthorized resource discovery

### Description

The IAM identity `incident-response-test-user` was used to perform a series of AWS API requests attempting to discover information about the AWS environment.

The activity included attempts to:

* Enumerate IAM users
* Enumerate IAM roles
* Enumerate IAM policies
* Enumerate S3 buckets
* Discover EC2 instances
* Enumerate EC2 security groups
* Retrieve AWS account information

The attempted actions were denied by AWS because the identity did not have the required permissions.

### Confirmed CloudTrail Activity

CloudTrail recorded the following activity from the test identity:

| Time         | Service | API Operation          | Result        |
| ------------ | ------- | ---------------------- | ------------- |
| 19:30:56 UTC | STS     | GetCallerIdentity      | Successful    |
| 19:33:46 UTC | S3      | ListBuckets            | Access Denied |
| 19:33:53 UTC | EC2     | DescribeInstances      | Unauthorized  |
| 19:34:13 UTC | EC2     | DescribeSecurityGroups | Unauthorized  |

### Evidence

The CloudTrail events identified:

* IAM identity: `incident-response-test-user`
* Event source: AWS API services
* Source IP: Recorded in CloudTrail
* User agent: AWS CLI
* Authentication method: AWS access key
* Event type: AWS API call
* Event category: Management event
* Read-only activity: Yes

### Security Impact

The activity represents reconnaissance behavior commonly associated with the early stages of an AWS security incident.

The identity attempted to discover information about:

* IAM configuration
* S3 resources
* EC2 infrastructure
* Network security configuration

However, the AWS IAM permission model successfully prevented the identity from performing the requested discovery operations.

No evidence was identified during this phase that the test identity successfully modified or deleted AWS resources.

### Security Controls That Prevented Impact

The following controls limited the potential impact:

1. IAM least-privilege permissions
2. Explicit absence of unnecessary permissions
3. CloudTrail management event logging
4. AWS API authorization controls
5. Monitoring capability for IAM activity

### Assessment

The incident simulation demonstrates that a compromised IAM credential with insufficient privileges can still generate suspicious reconnaissance activity.

The test environment successfully prevented unauthorized discovery actions through IAM authorization controls.

However, the successful authentication of the identity and the ability to generate AWS API requests demonstrates why compromised access keys must be detected and contained quickly.

### Recommendation

* Continue enforcing least-privilege IAM policies.
* Monitor IAM user activity for unusual API patterns.
* Enable MFA for human IAM users where applicable.
* Prefer temporary credentials over long-lived access keys.
* Regularly review and rotate IAM access keys.
* Monitor CloudTrail for unusual API activity.
* Use GuardDuty and Security Hub for centralized threat detection.
* Implement automated response procedures for suspected credential compromise.
* Remove or disable compromised credentials immediately after confirmation.

### Evidence Files

* `evidence/cloudtrail-incident-events.json`
* `screenshots/unauthorized-discovery-attempts.png`
* `screenshots/cloudtrail-incident-events.png`
