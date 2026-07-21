# AWS Cloud Security Assessment & Hardening Portfolio

## Overview

This repository demonstrates a practical AWS cloud security assessment, hardening, compliance, infrastructure-as-code, security automation, and continuous security monitoring workflow.

The project uses **Prowler v5.34.0**, AWS security services, Terraform, CI/CD security scanning, and Python/Boto3 automation to identify security risks, apply remediation, and validate improvements.

The security lifecycle followed throughout the project is:

**Assess → Identify → Remediate → Validate → Automate → Monitor**

---

# Projects Included

## 01 - AWS IAM Security Assessment

Security assessment and hardening of AWS Identity and Access Management (IAM).

Covered:

* IAM security checks
* Password policy assessment
* Authentication security
* IAM security hardening
* Before and after validation
* Security findings and remediation documentation

---

## 02 - AWS S3 Security Assessment

Security assessment of Amazon S3 storage configurations.

Covered:

* S3 bucket security
* Access control configuration
* Public access security
* Encryption validation
* Security best practices
* Security findings and remediation documentation

---

## 03 - AWS CloudTrail Security Assessment

Assessment of AWS logging and monitoring configuration.

Covered:

* CloudTrail configuration
* Multi-region logging
* Log file validation
* Audit visibility
* Logging security improvements
* Security findings and remediation documentation

---

## 04 - AWS EC2 Security Assessment

Security assessment of Amazon EC2 configuration.

Covered:

* EC2 security checks
* Instance configuration review
* AWS security recommendations
* Security findings
* Remediation guidance

---

## 05 - AWS KMS Security Assessment

Assessment of AWS Key Management Service security.

Covered:

* Encryption key security
* KMS configuration
* Key management practices
* Security recommendations
* Security findings and remediation guidance

---

## 06 - CIS AWS Foundations Benchmark Assessment

Compliance assessment against CIS AWS Foundations Benchmark controls using Prowler.

Covered:

* CIS security checks
* Compliance assessment
* Failed security controls
* Security gaps
* Remediation recommendations

---

## 07 - AWS Security Hardening: Before vs After

Demonstrates the security improvement process by comparing the AWS environment before and after hardening.

Covered:

* Initial security posture
* Security findings
* Remediation actions
* Post-remediation validation
* Before and after evidence
* Security improvement documentation

---

## 08 - Terraform Infrastructure as Code Security

Demonstrates secure AWS infrastructure deployment using Terraform.

Covered:

* Infrastructure as Code
* Secure S3 configuration
* S3 encryption
* S3 versioning
* S3 Block Public Access
* IAM configuration
* AWS security best practices
* Infrastructure security validation

---

## 09 - CI/CD Security Scanning

Demonstrates automated security scanning integrated into a CI/CD workflow.

Covered:

* GitHub Actions
* Terraform security scanning
* Infrastructure security validation
* tfsec security scanning
* Automated security checks
* Security findings and remediation

---

## 10 - AWS Security Hub & GuardDuty Integration

Demonstrates AWS-native threat detection and centralized security monitoring.

Covered:

* AWS Security Hub
* Amazon GuardDuty
* Security findings
* Centralized security monitoring
* AWS security service integration
* Security assessment and monitoring workflow

---

## 11 - Automated AWS Security Remediation

Demonstrates automated AWS security remediation using Python and Boto3.

Covered:

* Python security automation
* Boto3 AWS SDK
* S3 Block Public Access remediation
* IAM password policy remediation
* CloudTrail log file validation
* Automated security hardening
* Remediation success evidence

The project includes working remediation scripts for:

* `remediate_s3.py`
* `remediate_iam.py`
* `remediate_cloudtrail.py`

---

# Tools & Technologies

* Prowler v5.34.0
* AWS CLI
* Python
* Boto3
* Terraform
* GitHub Actions
* tfsec
* AWS IAM
* Amazon S3
* Amazon EC2
* AWS CloudTrail
* AWS KMS
* AWS Security Hub
* Amazon GuardDuty
* CIS AWS Foundations Benchmark
* Git & GitHub

---

# Repository Structure

```text
prowler-aws-security-assessments
│
├── 01-IAM
├── 02-S3
├── 03-CloudTrail
├── 04-EC2
├── 05-KMS
├── 06-CIS-Benchmark
├── 07-Before-vs-After
├── 08-Terraform-IaC
├── 09-CI-CD-Security-Scanning
├── 10-Security-Hub-GuardDuty
├── 11-Automated-Remediation
└── README.md
```

---

# Security Methodology

The project follows a practical cloud security lifecycle:

### 1. Assess

AWS services and infrastructure are assessed using Prowler and other security scanning tools.

### 2. Identify

Security findings, misconfigurations, and compliance gaps are reviewed and documented.

### 3. Remediate

Security controls are improved using AWS configuration changes, Terraform, and automated Python/Boto3 remediation scripts.

### 4. Validate

Security configurations are reviewed and security scans are performed to confirm improvements.

### 5. Automate

Security checks and remediation processes are integrated into infrastructure and CI/CD workflows where appropriate.

### 6. Monitor

AWS Security Hub and GuardDuty provide centralized security findings and continuous threat detection capabilities.

---

# Skills Demonstrated

This portfolio demonstrates practical skills in:

* AWS cloud security
* Cloud security assessment
* Security auditing
* Vulnerability identification
* Security hardening
* IAM security
* S3 security
* EC2 security
* CloudTrail logging and monitoring
* KMS encryption
* CIS compliance
* Infrastructure as Code security
* Terraform
* CI/CD security
* GitHub Actions
* Security scanning
* AWS Security Hub
* Amazon GuardDuty
* Python security automation
* Boto3
* Automated remediation
* Security documentation
* Risk identification
* Remediation planning
* Security validation

---

# Security Workflow

```text
AWS Environment
       │
       ▼
Security Assessment
       │
       ▼
Prowler / Security Scanning
       │
       ▼
Identify Findings
       │
       ▼
Remediation
       │
       ├── AWS Security Configuration
       ├── Terraform IaC
       └── Python / Boto3 Automation
       │
       ▼
Validation
       │
       ▼
CI/CD Security Scanning
       │
       ▼
Security Hub + GuardDuty Monitoring
```

---

# Outcome

This portfolio demonstrates a practical approach to AWS cloud security by combining security assessment, compliance validation, infrastructure security, CI/CD scanning, AWS-native security services, and automated remediation.

The project demonstrates the ability to:

* Assess AWS cloud environments
* Identify security risks and misconfigurations
* Apply AWS security best practices
* Secure infrastructure using Terraform
* Integrate security into CI/CD workflows
* Use AWS Security Hub and GuardDuty for security monitoring
* Automate remediation using Python and Boto3
* Validate security improvements
* Document findings and remediation actions

This portfolio represents an end-to-end AWS cloud security workflow focused on **assessment, hardening, automation, and continuous security monitoring**.
