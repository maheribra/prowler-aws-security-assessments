# AWS Architecture Visualization — Remediation Plan

## Assessment Overview

**Project:** AWS Architecture Visualization & Network Mapping
**AWS Region:** eu-west-1 (Ireland)
**Assessment Date:** 23 July 2026
**Primary Objective:** Improve AWS network segmentation, reduce unnecessary public exposure, and establish a secure baseline architecture.

---

## Remediation Priority

| Finding                            | Severity | Priority | Recommended Action                           |
| ---------------------------------- | -------- | -------- | -------------------------------------------- |
| Automatic public IP assignment     | Medium   | High     | Disable on private subnets                   |
| Internet Gateway routing           | Medium   | High     | Separate public and private route tables     |
| No private subnet architecture     | Medium   | High     | Implement public/private subnet segmentation |
| Default VPC usage                  | Low      | Medium   | Create dedicated custom VPC                  |
| Unrestricted security-group egress | Low      | Medium   | Apply least-privilege outbound rules         |
| Default NACL allows all traffic    | Low      | Low      | Implement custom NACLs where appropriate     |

---

## 1. Replace Default VPC Architecture

### Finding

The environment currently relies on the AWS default VPC.

### Recommended Remediation

Create a dedicated custom VPC designed around workload requirements.

The target architecture should include:

* Custom VPC CIDR range
* Multiple Availability Zones
* Public subnets
* Private application subnets
* Private database subnets where required
* Dedicated route tables
* Internet Gateway
* NAT Gateway
* Workload-specific security groups
* Custom Network ACLs where justified

### Target Architecture

```text
                         Internet
                             |
                             v
                    Internet Gateway
                             |
                +------------+------------+
                |                         |
                v                         v
          Public Subnet A           Public Subnet B
          eu-west-1a                eu-west-1b
                |                         |
                +------------+------------+
                             |
                         NAT Gateway
                             |
                +------------+------------+
                |                         |
                v                         v
        Private App Subnet A      Private App Subnet B
        eu-west-1a                eu-west-1b
                |                         |
                +------------+------------+
                             |
                             v
                     Private Database
                         Subnets
```

---

## 2. Disable Automatic Public IPv4 Assignment on Private Subnets

### Finding

All three current subnets have automatic public IP assignment enabled.

### Recommended Remediation

For subnets that will host private workloads, disable automatic public IPv4 assignment.

AWS CLI example:

```cmd
aws ec2 modify-subnet-attribute ^
    --subnet-id <PRIVATE_SUBNET_ID> ^
    --no-map-public-ip-on-launch ^
    --region eu-west-1
```

### Expected Result

New EC2 instances launched into private subnets will not automatically receive public IPv4 addresses.

This reduces the risk of accidental direct internet exposure.

---

## 3. Separate Public and Private Routing

### Finding

The current route table contains:

```text
0.0.0.0/0 → Internet Gateway
```

### Recommended Remediation

Create separate route tables.

### Public Route Table

```text
Destination: 172.31.0.0/16
Target: local

Destination: 0.0.0.0/0
Target: Internet Gateway
```

Associate this route table only with public subnets.

### Private Route Table

```text
Destination: 172.31.0.0/16
Target: local

Destination: 0.0.0.0/0
Target: NAT Gateway
```

Associate this route table with private application subnets.

### Expected Result

Private workloads can access the internet for required outbound operations without being directly reachable from the public internet.

---

## 4. Implement NAT-Based Private Subnet Egress

### Finding

No NAT Gateway was identified.

### Recommended Remediation

Deploy a NAT Gateway in a public subnet.

Private subnets should route outbound internet traffic through the NAT Gateway.

Recommended architecture:

```text
Private EC2
    |
Private Route Table
    |
NAT Gateway
    |
Public Route Table
    |
Internet Gateway
    |
Internet
```

### Security Benefit

This architecture allows private workloads to initiate outbound connections while preventing direct inbound internet connections to those workloads.

### Cost Consideration

NAT Gateways incur AWS charges. For small development environments, alternatives such as NAT instances or VPC endpoints may be considered depending on requirements.

For AWS services such as S3 and DynamoDB, VPC endpoints can reduce the need for NAT-based traffic.

---

## 5. Replace Default Security Group Usage

### Finding

The default security group allows unrestricted outbound traffic to `0.0.0.0/0`.

### Recommended Remediation

Create dedicated security groups for each application tier.

Example:

```text
Internet
   |
   v
ALB Security Group
   |
   | HTTPS 443
   v
Application Security Group
   |
   | Database Port
   v
Database Security Group
```

### Recommended Controls

#### Load Balancer Security Group

Allow:

```text
Inbound:
TCP 443 from 0.0.0.0/0
```

Where HTTP is required, redirect HTTP to HTTPS.

#### Application Security Group

Allow inbound traffic only from the Load Balancer security group.

#### Database Security Group

Allow database traffic only from the Application security group.

### Expected Result

Security groups become application-specific and follow the principle of least privilege.

---

## 6. Improve Outbound Traffic Controls

### Finding

The default security group permits all outbound IPv4 traffic.

### Recommended Remediation

Where operationally practical, restrict outbound access to required destinations and ports.

Examples:

```text
HTTPS → TCP 443
DNS → UDP/TCP 53
NTP → UDP 123
```

For sensitive workloads, consider using:

* VPC endpoints
* AWS Network Firewall
* Proxy infrastructure
* Egress filtering
* Domain-based filtering solutions

### Important Consideration

Outbound restrictions should be implemented carefully to avoid disrupting legitimate application dependencies.

---

## 7. Review Network ACL Configuration

### Finding

The default Network ACL allows all IPv4 inbound and outbound traffic.

### Recommended Remediation

For environments requiring additional subnet-level controls, create custom NACLs.

NACLs should:

* Allow only required traffic
* Explicitly define inbound rules
* Explicitly define outbound rules
* Use appropriate rule numbering
* Include required ephemeral port ranges
* Be documented and reviewed regularly

### Important Consideration

NACLs are stateless, unlike security groups.

Return traffic must therefore be explicitly allowed.

Security groups should remain the primary workload-level access control mechanism.

---

## 8. Implement Network Segmentation

The recommended architecture should separate workloads based on their exposure and function.

### Public Tier

Examples:

* Application Load Balancers
* Internet-facing services
* Bastion hosts where required

### Private Application Tier

Examples:

* Application servers
* Internal APIs
* Backend services

### Private Data Tier

Examples:

* RDS databases
* Database clusters
* Sensitive data stores

Each tier should have dedicated security groups and appropriate route tables.

---

## 9. Continuous Monitoring and Validation

After remediation, the environment should be reassessed.

Recommended tools include:

* AWS Security Hub
* Amazon GuardDuty
* AWS Config
* Prowler
* ScoutSuite
* AWS CLI
* VPC Flow Logs

### Validation Tasks

After implementing changes:

1. Verify private subnets do not assign public IP addresses.
2. Verify private route tables do not route directly to an Internet Gateway.
3. Verify private workloads can access required external services through NAT or VPC endpoints.
4. Verify security groups follow least privilege.
5. Verify NACL rules allow required traffic.
6. Verify no unintended public resources are deployed.
7. Re-run security assessments.
8. Review VPC Flow Logs for unexpected traffic.

---

## Recommended Target State

The final architecture should provide:

* Dedicated custom VPC
* Multi-AZ network design
* Public/private subnet separation
* No automatic public IPs on private subnets
* Internet Gateway restricted to public subnets
* NAT Gateway for controlled private egress
* Dedicated security groups
* Least-privilege network access
* Controlled NACLs where appropriate
* Continuous monitoring and security validation

---

## Remediation Outcome

Implementing these recommendations will significantly improve the AWS environment's network security posture by reducing unnecessary public exposure, introducing network segmentation, and establishing clearer security boundaries between internet-facing and internal workloads.

The recommended architecture provides a stronger foundation for securely deploying production workloads while maintaining controlled outbound connectivity and improving visibility into network traffic.
