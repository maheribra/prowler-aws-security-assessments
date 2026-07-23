# AWS Architecture Visualization & Network Mapping

## Overview

This project performs an AWS network architecture assessment focused on understanding the cloud environment, visualizing network connectivity, identifying potential public exposure, and documenting security improvements.

The assessment uses AWS CLI to collect information about the AWS networking environment, including VPCs, subnets, route tables, Internet Gateways, NAT Gateways, EC2 instances, security groups, Network ACLs, and Elastic IP addresses.

The collected data is analyzed to identify network architecture risks and recommend a more secure public/private subnet design.

---

## Objectives

The primary objectives of this project are to:

* Map the AWS network architecture
* Identify VPC and subnet configuration
* Analyze public and private network exposure
* Review route table configuration
* Identify Internet Gateway connectivity
* Review NAT Gateway deployment
* Analyze security group configuration
* Review Network ACL configuration
* Identify potential network security weaknesses
* Recommend a secure target architecture
* Document findings and remediation steps

---

## AWS Environment

| Property           | Value                              |
| ------------------ | ---------------------------------- |
| AWS Region         | eu-west-1                          |
| VPCs               | 1                                  |
| VPC Type           | Default VPC                        |
| VPC CIDR           | 172.31.0.0/16                      |
| Subnets            | 3                                  |
| Availability Zones | eu-west-1a, eu-west-1b, eu-west-1c |
| Internet Gateway   | 1                                  |
| NAT Gateways       | 0                                  |
| EC2 Instances      | 0                                  |
| Security Groups    | 1 default security group           |
| Network ACLs       | 1 default NACL                     |
| Elastic IPs        | None identified                    |

---

## Architecture Summary

The assessed environment contains a single default VPC spanning three Availability Zones.

All three identified subnets have automatic public IPv4 assignment enabled.

The VPC has an Internet Gateway and the identified route table contains a default route to the Internet Gateway.

No NAT Gateway was identified, and no active EC2 instances were found during the assessment.

The current architecture is therefore relatively minimal and is more representative of a development or initial AWS environment than a production-grade segmented architecture.

---

## Current Architecture

The current environment can be summarized as:

```text
                         Internet
                             |
                             |
                    Internet Gateway
                             |
                             |
                      Default VPC
                     172.31.0.0/16
                             |
              +--------------+--------------+
              |              |              |
              |              |              |
              v              v              v
         Subnet A       Subnet B       Subnet C
        eu-west-1a     eu-west-1b     eu-west-1c
      172.31.16/20    172.31.32/20     172.31.0/20
              |              |              |
              +--------------+--------------+
                             |
                             v
                    Default Security Group
                             |
                             v
                    Default Network ACL
```

---

## Assessment Methodology

The AWS CLI was used to collect network architecture data from the `eu-west-1` region.

### Resources Assessed

* VPCs
* Subnets
* Route tables
* Internet Gateways
* NAT Gateways
* EC2 instances
* Security groups
* Network ACLs
* Elastic IP addresses

### Data Collection Commands

Example:

```bash
aws ec2 describe-vpcs --region eu-west-1
```

```bash
aws ec2 describe-subnets --region eu-west-1
```

```bash
aws ec2 describe-route-tables --region eu-west-1
```

```bash
aws ec2 describe-internet-gateways --region eu-west-1
```

```bash
aws ec2 describe-nat-gateways --region eu-west-1
```

```bash
aws ec2 describe-instances --region eu-west-1
```

```bash
aws ec2 describe-security-groups --region eu-west-1
```

```bash
aws ec2 describe-network-acls --region eu-west-1
```

```bash
aws ec2 describe-addresses --region eu-west-1
```

---

## Key Findings

### 1. Default VPC Architecture

The environment uses the AWS default VPC.

**Severity:** Low

A custom VPC architecture is recommended for production environments to provide explicit network segmentation and security boundaries.

---

### 2. Automatic Public IPv4 Assignment

All three subnets have automatic public IPv4 assignment enabled.

**Severity:** Medium

This configuration may cause newly launched EC2 instances to automatically receive public IPv4 addresses.

Private workloads should be deployed into subnets where automatic public IP assignment is disabled.

---

### 3. Internet Gateway Route

The route table contains:

```text
0.0.0.0/0 → Internet Gateway
```

**Severity:** Medium

Resources in associated subnets have a network path to the public internet.

The recommended architecture should separate public and private route tables.

---

### 4. No Private Subnet/NAT Gateway Architecture

No NAT Gateway was identified.

**Severity:** Medium

The current environment does not demonstrate a clear separation between public and private workloads.

A production architecture should introduce private application subnets and controlled outbound internet access.

---

### 5. Unrestricted Security Group Egress

The default security group allows all outbound IPv4 traffic to:

```text
0.0.0.0/0
```

**Severity:** Low

Dedicated security groups with least-privilege egress rules are recommended for production workloads.

---

### 6. Default Network ACL

The default Network ACL allows all IPv4 traffic in both directions.

**Severity:** Low

Custom NACLs may be introduced where additional subnet-level network controls are required.

---

## Positive Security Observations

The assessment also identified several positive observations:

* No EC2 instances were identified.
* No Elastic IP addresses were identified.
* The default security group does not allow internet-wide inbound access.
* The environment currently has a limited attack surface due to the absence of active EC2 workloads.

---

## Recommended Target Architecture

The recommended architecture introduces clear network segmentation.

```text
                           Internet
                               |
                               v
                       Internet Gateway
                               |
                +--------------+--------------+
                |                             |
                v                             v
         Public Subnet A               Public Subnet B
         eu-west-1a                    eu-west-1b
                |                             |
                +--------------+--------------+
                               |
                               v
                         NAT Gateway
                               |
                +--------------+--------------+
                |                             |
                v                             v
       Private App Subnet A          Private App Subnet B
       eu-west-1a                    eu-west-1b
                |                             |
                +--------------+--------------+
                               |
                               v
                      Private Data Tier
                         Subnets
```

### Target Security Controls

* Custom VPC
* Public/private subnet separation
* No automatic public IPs on private subnets
* Dedicated public and private route tables
* NAT Gateway for private outbound traffic
* Dedicated security groups
* Least-privilege ingress and egress rules
* Custom NACLs where required
* VPC Flow Logs
* AWS Security Hub
* Amazon GuardDuty
* AWS Config

---

## Project Structure

```text
15-AWS-Architecture-Visualization
├── README.md
├── findings.md
├── remediation.md
├── screenshots
│   ├── vpc-network-map.png
│   ├── security-groups.png
│   └── architecture-details.png
└── reports
    ├── ec2-instances.json
    ├── elastic-ips.json
    ├── internet-gateways.json
    ├── nat-gateways.json
    ├── network-acls.json
    ├── route-tables.json
    ├── route-tables-full.json
    ├── security-groups.json
    ├── subnets.json
    └── vpcs.json
```

---

## Security Assessment Outcome

The AWS environment is currently minimal and contains no active EC2 workloads. However, the network configuration has several areas that should be improved before deploying production workloads.

The highest-priority recommendations are:

1. Introduce dedicated public and private subnet segmentation.
2. Disable automatic public IPv4 assignment on private subnets.
3. Separate public and private route tables.
4. Introduce NAT-based controlled egress for private workloads.
5. Replace reliance on the default security group with workload-specific security groups.
6. Apply least-privilege network controls where appropriate.

These improvements would provide a stronger foundation for secure AWS workload deployment and reduce the risk of accidental internet exposure.

---

## Disclaimer

This assessment was conducted against the AWS environment configured for the project and the `eu-west-1` region.

The findings represent the architecture observed at the time of assessment. AWS resources and configurations may change over time, so the assessment should be repeated periodically.

No destructive actions or exploitation techniques were performed as part of this project.
