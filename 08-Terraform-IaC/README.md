# AWS Security Infrastructure Deployment with Terraform

## Overview

This project demonstrates Infrastructure as Code (IaC) deployment of a secure AWS environment using Terraform.

The goal is to automate the creation of AWS security-focused resources while following cloud security best practices.

## Technologies Used

- Terraform
- AWS
- Amazon VPC
- Amazon EC2
- Amazon S3
- AWS IAM
- AWS Systems Manager (SSM)

## Architecture

The Terraform deployment creates:

- Custom VPC
- Public subnet
- Private subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 instance
- IAM Role and Instance Profile
- Secure S3 bucket

Architecture flow:

```
Internet
   |
Internet Gateway
   |
Public Subnet
   |
EC2 Instance
   |
IAM Role (SSM Access)

Private Subnet

Secure S3 Bucket
- Encryption Enabled
- Versioning Enabled
- Public Access Blocked
```

## Security Controls Implemented

### Network Security

- Custom VPC created
- Public and private subnet separation
- Security Group restricting inbound access
- SSH access limited to administrator IP
- HTTPS outbound access enabled

### EC2 Security

- EC2 deployed using Terraform
- Encrypted root volume enabled
- IAM instance profile attached
- AWS Systems Manager access configured

### IAM Security

Created IAM role:

```
security-lab-ec2-role
```

Permissions:

```
AmazonSSMManagedInstanceCore
```

Purpose:

- Secure EC2 management without storing SSH credentials
- Least privilege access for system management

### S3 Security

The S3 bucket includes:

- Block public access enabled
- Bucket ownership enforcement
- Server-side encryption enabled
- Versioning enabled

## Terraform Workflow

### Initialize Terraform

```bash
terraform init
```

### Format Configuration

```bash
terraform fmt
```

### Validate Configuration

```bash
terraform validate
```

### Review Deployment Plan

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

### Destroy Resources

```bash
terraform destroy
```

## Deployment Validation

Terraform successfully created:

VPC:

```
vpc-00aecbdb29d2e0aa2
```

EC2 Instance:

```
i-035d315184b1abbba
```

S3 Bucket:

```
security-lab-secure-data-20260720133113382800000001
```

Security Group:

```
sg-0d62c865510d85dbb
```

## Screenshots

Screenshots demonstrating the deployment:

```
screenshots/
│
├── 01-ec2-instance.png
├── 02-vpc.png
├── 03-s3-bucket.png
├── 04-iam-role-trust.png
├── 05-iam-role-permissions.png
└── 06-security-group.png
```

## Lessons Learned

This project demonstrates:

- Creating AWS infrastructure using Terraform
- Applying cloud security principles through code
- Managing IAM permissions securely
- Automating repeatable cloud deployments
- Implementing secure AWS storage configurations

## Cleanup

To avoid unnecessary AWS costs, destroy the infrastructure after testing:

```bash
terraform destroy
```