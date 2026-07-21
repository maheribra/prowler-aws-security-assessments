# AWS Security Assessment with ScoutSuite

## Overview

This project uses ScoutSuite, an open-source multi-cloud security auditing tool, to assess the security posture of an AWS environment.

The assessment reviews AWS services and configurations for potential security weaknesses and provides visibility into security findings across the environment.

## Tool Used

* ScoutSuite
* AWS
* Python

## Assessment Scope

The ScoutSuite assessment reviewed the following AWS services:

* IAM
* S3
* EC2
* CloudTrail
* CloudWatch
* Config
* KMS
* VPC
* RDS
* Lambda
* CloudFront
* ELB / ELBv2
* Route 53
* Secrets Manager
* SNS
* SQS
* DynamoDB
* EFS
* ElastiCache
* And other supported AWS services

## Assessment Command

```bash
scout aws
```

## Findings

The assessment identified security findings across multiple AWS services.

The most significant areas reviewed included:

* IAM security configuration
* CloudTrail logging and monitoring
* AWS Config configuration
* EC2 security posture
* S3 security configuration
* VPC networking
* KMS configuration
* RDS security settings

Detailed findings are documented in `findings.md`.

## Remediation

Security findings should be reviewed and prioritized based on severity and business impact.

Recommended remediation activities include:

* Reviewing IAM users, roles, and permissions
* Enforcing strong authentication and least privilege
* Ensuring CloudTrail logging is enabled and protected
* Reviewing AWS Config coverage
* Restricting unnecessary public access
* Reviewing EC2 security group rules
* Securing S3 buckets and access policies
* Reviewing VPC network controls
* Protecting encryption keys and sensitive data

Detailed remediation guidance is documented in `remediation.md`.

## Screenshots

Screenshots from the ScoutSuite assessment are available in the `screenshots/` directory.

* `scoutsuite-dashboard.png`
* `scoutsuite-iam-findings.png`
* `scoutsuite-cloudtrail-findings.png`

## Project Structure

```text
12-ScoutSuite/
├── screenshots/
│   ├── scoutsuite-dashboard.png
│   ├── scoutsuite-iam-findings.png
│   └── scoutsuite-cloudtrail-findings.png
├── reports/
├── README.md
├── findings.md
└── remediation.md
```

## Skills Demonstrated

* Cloud security assessment
* AWS security auditing
* Security findings analysis
* IAM security review
* CloudTrail and logging assessment
* Infrastructure security review
* Security remediation planning
* ScoutSuite security tooling
* AWS cloud security
