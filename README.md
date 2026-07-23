# AWS Cloud Security Assessment & Incident Response Portfolio

## Overview

This repository demonstrates a practical, end-to-end AWS cloud security portfolio covering **security assessment, compliance, hardening, infrastructure security, CI/CD security, threat detection, IAM analysis, exploitation simulation, architecture visualization, incident response, and digital forensics**.

The portfolio was built as a progressive security workflow, starting with foundational AWS security assessments and expanding into offensive security testing, cloud architecture analysis, and incident investigation.

The overall security lifecycle followed throughout the portfolio is:

**Assess → Identify → Remediate → Validate → Automate → Monitor → Investigate → Respond**

---

# Projects Included

## 01 — AWS IAM Security Assessment

Security assessment and hardening of AWS Identity and Access Management (IAM).

Covered:

* IAM security checks
* Password policy assessment
* Authentication security
* IAM security hardening
* Before-and-after validation
* Security findings and remediation documentation

---

## 02 — AWS S3 Security Assessment

Security assessment of Amazon S3 storage configurations.

Covered:

* S3 bucket security
* Access control configuration
* Public access security
* Encryption validation
* Security best practices
* Security findings and remediation documentation

---

## 03 — AWS CloudTrail Security Assessment

Assessment of AWS logging and monitoring configuration.

Covered:

* CloudTrail configuration
* Multi-region logging
* Log file validation
* Audit visibility
* Logging security improvements
* Security findings and remediation documentation

---

## 04 — AWS EC2 Security Assessment

Security assessment of Amazon EC2 configuration.

Covered:

* EC2 security checks
* Instance configuration review
* AWS security recommendations
* Security findings
* Remediation guidance

---

## 05 — AWS KMS Security Assessment

Assessment of AWS Key Management Service security.

Covered:

* Encryption key security
* KMS configuration
* Key management practices
* Security recommendations
* Security findings and remediation guidance

---

## 06 — CIS AWS Foundations Benchmark Assessment

Compliance assessment against CIS AWS Foundations Benchmark controls using Prowler.

Covered:

* CIS security checks
* Compliance assessment
* Failed security controls
* Security gaps
* Remediation recommendations

---

## 07 — AWS Security Hardening: Before vs After

Demonstrates the security improvement process by comparing the AWS environment before and after security hardening.

Covered:

* Initial security posture
* Security findings
* Remediation actions
* Post-remediation validation
* Before-and-after evidence
* Security improvement documentation

---

## 08 — Terraform Infrastructure as Code Security

Demonstrates secure AWS infrastructure deployment and security validation using Terraform.

Covered:

* Infrastructure as Code
* Secure AWS resource deployment
* S3 security configuration
* S3 encryption
* S3 versioning
* S3 Block Public Access
* IAM configuration
* Infrastructure security validation

---

## 09 — CI/CD Security Scanning

Demonstrates automated security scanning integrated into a CI/CD workflow.

Covered:

* GitHub Actions
* Terraform security scanning
* Infrastructure security validation
* tfsec security scanning
* Checkov security scanning
* Automated security checks
* Security findings and remediation

---

## 10 — AWS Security Hub & GuardDuty Integration

Demonstrates AWS-native threat detection and centralized security monitoring.

Covered:

* AWS Security Hub
* Amazon GuardDuty
* Security findings
* Centralized security monitoring
* AWS security service integration
* Threat detection workflows
* Security assessment and monitoring

---

## 11 — Automated AWS Security Remediation

Demonstrates automated AWS security remediation using Python and Boto3.

Covered:

* Python security automation
* Boto3 AWS SDK
* S3 Block Public Access remediation
* IAM password policy remediation
* CloudTrail security remediation
* Automated security hardening
* Remediation validation

The project includes remediation scripts for:

* `remediate_s3.py`
* `remediate_iam.py`
* `remediate_cloudtrail.py`

---

## 12 — AWS ScoutSuite Security Assessment

Multi-service AWS security assessment using ScoutSuite.

Covered:

* AWS account security assessment
* Multi-service cloud security analysis
* Security configuration review
* Security findings
* HTML security assessment reporting
* Security recommendations

This project expands the assessment methodology beyond individual AWS services and provides a broader view of the AWS account security posture.

---

## 13 — CloudSplaining & Principal Mapper IAM Security Assessment

Advanced IAM security analysis using CloudSplaining and Principal Mapper.

Covered:

* IAM policy analysis
* Overly permissive IAM policies
* Privilege analysis
* IAM principal relationships
* Permission mapping
* Potential privilege escalation paths
* Security findings and remediation recommendations

The project demonstrates how IAM permissions can be analyzed from both policy and principal perspectives.

---

## 14 — Pacu AWS Exploitation & Privilege Escalation Assessment

Controlled AWS security testing using Pacu.

Covered:

* AWS IAM enumeration
* IAM user enumeration
* IAM role enumeration
* Permission enumeration
* AWS attack-path analysis
* Privilege escalation analysis
* Controlled exploitation techniques
* Security findings
* Remediation recommendations

The project demonstrates how excessive AWS permissions can potentially be abused by an attacker and highlights the importance of least-privilege IAM design.

---

## 15 — CloudMapper AWS Architecture & Network Visualization

AWS cloud architecture and network security visualization using CloudMapper.

Covered:

* AWS infrastructure visualization
* VPC architecture analysis
* Network topology
* Subnet relationships
* Internet Gateway exposure
* Security group analysis
* Network security assessment
* Architecture documentation

The project provides a visual representation of the AWS environment and helps identify network exposure and architectural security considerations.

---

## 16 — AWS Incident Response & Forensics

Simulated AWS security incident investigation and incident-response workflow.

Covered:

* IAM test identity creation
* Access key investigation
* CloudTrail forensic analysis
* AWS API activity investigation
* Unauthorized discovery attempt analysis
* Amazon GuardDuty findings
* AWS Security Hub findings
* Root credential usage investigation
* Incident timeline development
* Security findings documentation
* Containment planning
* Remediation recommendations

The simulated incident involved an IAM identity performing read-only AWS resource discovery attempts. The attempted discovery operations were denied by IAM, while CloudTrail provided forensic evidence of the activity.

The project also investigated separate GuardDuty detections involving root credential usage and reviewed Security Hub findings related to monitoring and logging gaps.

The investigation demonstrates how multiple AWS security services can work together during an incident:

**CloudTrail → GuardDuty → Security Hub → Investigation → Containment → Remediation**

---

# Tools & Technologies

### AWS Security Services

* AWS IAM
* Amazon S3
* Amazon EC2
* AWS CloudTrail
* AWS KMS
* AWS Security Hub
* Amazon GuardDuty
* AWS Config
* Amazon CloudWatch

### Security Assessment & Analysis

* Prowler v5.34.0
* ScoutSuite
* CloudSplaining
* Principal Mapper
* Pacu
* CloudMapper
* CIS AWS Foundations Benchmark

### Infrastructure & Automation

* Terraform
* AWS CLI
* Python
* Boto3

### DevSecOps & CI/CD

* GitHub Actions
* Checkov
* tfsec

### Development & Version Control

* Git
* GitHub

---

# Repository Structure

```text
aws-cloud-security-assessments/
│
├── 01-IAM/
├── 02-S3/
├── 03-CloudTrail/
├── 04-EC2/
├── 05-KMS/
├── 06-CIS-Benchmark/
├── 07-Before-vs-After/
├── 08-Terraform-IaC/
├── 09-CI-CD-Security-Scanning/
├── 10-Security-Hub-GuardDuty/
├── 11-Automated-Remediation/
├── 12-ScoutSuite/
├── 13-CloudSplaining-PrincipalMapper/
├── 14-Pacu-AWS-Exploitation/
├── 15-CloudMapper-AWS-Architecture/
├── 16-AWS-Incident-Response-Forensics/
│
└── README.md
```

---

# Security Methodology

The portfolio follows a practical cloud security lifecycle.

### 1. Assess

AWS services, IAM configurations, infrastructure, and cloud architecture are assessed using security tools including Prowler, ScoutSuite, CloudSplaining, Principal Mapper, Pacu, and CloudMapper.

### 2. Identify

Security findings, misconfigurations, excessive permissions, compliance gaps, network exposure, and potential attack paths are identified and documented.

### 3. Remediate

Security controls are improved using:

* AWS security configuration
* IAM least privilege
* Terraform
* Python and Boto3 automation
* Security hardening practices

### 4. Validate

Security configurations and remediation actions are validated through follow-up assessments, security scans, and evidence collection.

### 5. Automate

Security checks and remediation processes are integrated into infrastructure and CI/CD workflows where appropriate.

### 6. Monitor

AWS Security Hub and Amazon GuardDuty provide centralized security findings and threat detection capabilities.

### 7. Investigate

CloudTrail, GuardDuty, Security Hub, and IAM evidence are used to investigate simulated security incidents and suspicious activity.

### 8. Respond

Incident-response activities include:

* Evidence collection
* Timeline development
* Finding analysis
* Credential investigation
* Containment planning
* Remediation recommendations

---

# Security Workflow

```text
AWS Environment
       │
       ▼
Security Assessment
       │
       ├── Prowler
       ├── ScoutSuite
       ├── CloudSplaining
       ├── Principal Mapper
       ├── Pacu
       └── CloudMapper
       │
       ▼
Identify Findings
       │
       ├── Misconfigurations
       ├── Compliance Gaps
       ├── Excessive Permissions
       ├── Network Exposure
       └── Potential Attack Paths
       │
       ▼
Remediation & Hardening
       │
       ├── AWS Security Configuration
       ├── IAM Least Privilege
       ├── Terraform IaC
       └── Python / Boto3 Automation
       │
       ▼
Validation
       │
       ├── Prowler
       ├── CI/CD Security Scanning
       └── Before vs After Assessment
       │
       ▼
Monitoring & Detection
       │
       ├── CloudTrail
       ├── Security Hub
       ├── GuardDuty
       └── CloudWatch
       │
       ▼
Incident Investigation
       │
       ├── Evidence Collection
       ├── CloudTrail Forensics
       ├── Finding Analysis
       └── Incident Timeline
       │
       ▼
Containment & Response
       │
       ├── Credential Investigation
       ├── Access Key Containment
       ├── Remediation
       └── Security Recommendations
```

---

# Skills Demonstrated

This portfolio demonstrates practical experience in:

* AWS cloud security
* Cloud security assessment
* Security auditing
* Vulnerability identification
* Security hardening
* IAM security
* Least-privilege design
* IAM policy analysis
* Privilege escalation analysis
* S3 security
* EC2 security
* CloudTrail logging and monitoring
* KMS encryption
* CIS compliance
* Infrastructure as Code security
* Terraform
* CI/CD security
* DevSecOps security scanning
* GitHub Actions
* AWS Security Hub
* Amazon GuardDuty
* CloudWatch monitoring
* Python security automation
* Boto3
* Automated remediation
* AWS attack-path analysis
* Cloud architecture visualization
* Network security assessment
* Incident response
* Cloud forensics
* Security evidence collection
* Security investigation
* Risk identification
* Remediation planning
* Security validation
* Security documentation

---

# Portfolio Outcome

This portfolio demonstrates a progressive approach to AWS cloud security, moving from foundational security assessment and hardening into automated remediation, security monitoring, IAM analysis, controlled offensive security testing, cloud architecture analysis, and incident response.

Across 16 projects, the portfolio demonstrates the ability to:

* Assess AWS cloud environments
* Identify security risks and misconfigurations
* Evaluate AWS compliance against security benchmarks
* Apply AWS security best practices
* Implement IAM least privilege
* Analyze excessive permissions and potential attack paths
* Secure infrastructure using Terraform
* Integrate security into CI/CD workflows
* Automate security remediation using Python and Boto3
* Use AWS Security Hub and GuardDuty for threat detection
* Visualize AWS cloud architecture and network exposure
* Investigate suspicious AWS API activity
* Perform CloudTrail-based forensic analysis
* Develop incident timelines
* Collect and preserve security evidence
* Plan credential containment and remediation
* Document security findings and recommendations

The result is an end-to-end AWS cloud security portfolio focused on:

**Assessment → Hardening → Automation → Monitoring → Detection → Investigation → Incident Response**

---

# Project Status

**Projects Completed:** 16

**Portfolio Status:** Completed

**Primary Focus:** AWS Cloud Security

**Security Domains:** Cloud Security, IAM, Compliance, DevSecOps, Threat Detection, Offensive Security, Cloud Architecture, Incident Response & Forensics
