# AWS Architecture Visualization — Findings

## Assessment Overview

**Project:** AWS Architecture Visualization & Network Mapping
**AWS Region:** eu-west-1 (Ireland)
**Assessment Date:** 23 July 2026
**AWS Account:** 018134828551
**Assessment Tool:** AWS CLI
**Primary Objective:** Analyze AWS network architecture, identify publicly exposed resources and network security weaknesses, and document remediation recommendations.

---

## Architecture Summary

The assessed AWS environment contains a single default VPC with three subnets distributed across three Availability Zones.

### Environment Inventory

| Component          | Configuration                      |
| ------------------ | ---------------------------------- |
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

## Finding 1 — Default VPC Used for AWS Networking

**Severity:** Low
**Category:** Network Architecture

### Description

The AWS account currently uses the default VPC with CIDR range `172.31.0.0/16`.

Default VPCs are automatically created by AWS and are convenient for initial development and testing. However, production environments typically benefit from custom VPC architectures that explicitly define network segmentation, routing, security boundaries, and workload isolation.

### Evidence

```text
VPC ID: vpc-057bc9c2d188e7ed6
CIDR: 172.31.0.0/16
Default: True
```

### Risk

Using a default VPC can encourage deployment of workloads into a network that has not been intentionally designed around the organization's security requirements.

### Recommendation

Create a dedicated custom VPC architecture for production workloads with:

* Dedicated public and private subnets
* Explicit routing
* Workload segmentation
* Controlled internet access
* Separate security boundaries
* Multi-AZ deployment where appropriate

---

## Finding 2 — Automatic Public IPv4 Assignment Enabled on All Subnets

**Severity:** Medium
**Category:** Network Exposure

### Description

All three subnets have automatic public IPv4 address assignment enabled.

### Evidence

```text
eu-west-1a — 172.31.16.0/20 — MapPublicIpOnLaunch: True
eu-west-1b — 172.31.32.0/20 — MapPublicIpOnLaunch: True
eu-west-1c — 172.31.0.0/20  — MapPublicIpOnLaunch: True
```

### Risk

Any EC2 instance launched into these subnets may automatically receive a public IPv4 address.

This increases the possibility of accidental internet exposure, particularly if an instance is deployed with permissive security-group rules or vulnerable services.

### Recommendation

Disable automatic public IP assignment on subnets intended for private workloads.

Use a dedicated architecture consisting of:

* Public subnets for internet-facing resources
* Private subnets for internal workloads
* NAT Gateway for controlled outbound internet access from private subnets

---

## Finding 3 — Default Route to Internet Gateway

**Severity:** Medium
**Category:** Network Exposure

### Description

The VPC route table contains a default route to the Internet Gateway.

### Evidence

```text
VPC: vpc-057bc9c2d188e7ed6
Route: 0.0.0.0/0
Target: igw-004e1aa5a5636856c
State: active
```

### Risk

Resources deployed into subnets associated with this route table have a network path to the public internet.

When combined with automatic public IP assignment, resources deployed into these subnets may become directly internet reachable depending on their security-group configuration.

### Recommendation

Use separate route tables for public and private subnets.

Public subnets should route internet traffic through an Internet Gateway.

Private subnets should avoid direct Internet Gateway routing and use a NAT Gateway or other controlled egress mechanism when outbound internet access is required.

---

## Finding 4 — No Private Subnet or NAT Gateway Architecture Identified

**Severity:** Medium
**Category:** Network Segmentation

### Description

No NAT Gateway was identified in the assessed region, and the current architecture does not show a dedicated private-subnet egress design.

### Evidence

```text
NAT Gateways: 0
```

All identified subnets have automatic public IPv4 assignment enabled.

### Risk

The current network design does not demonstrate a clear separation between internet-facing and internal workloads.

This could lead to workloads being deployed in publicly addressable subnets when they do not require direct internet connectivity.

### Recommendation

Implement a segmented architecture:

```text
Internet
    |
Internet Gateway
    |
Public Subnets
    |
Load Balancer / Bastion / Public Services
    |
Private Subnets
    |
Application and Database Workloads
    |
NAT Gateway
    |
Controlled Outbound Internet
```

---

## Finding 5 — Default Security Group Allows Unrestricted Outbound Traffic

**Severity:** Low
**Category:** Network Security

### Description

The default security group permits all outbound IPv4 traffic to `0.0.0.0/0`.

### Evidence

```text
Protocol: All
Destination: 0.0.0.0/0
Action: Allow
```

The inbound rule does not allow traffic from the public internet. It permits traffic originating from resources associated with the same security group.

### Risk

If workloads are attached to the default security group, they can initiate outbound connections to any IPv4 destination.

Unrestricted outbound access can increase the impact of compromised workloads by allowing unrestricted external communication.

### Recommendation

Use dedicated security groups for workloads and apply least-privilege egress rules where practical.

Restrict outbound access based on:

* Required destinations
* Required protocols
* Required ports
* Application dependencies

---

## Finding 6 — Default Network ACL Allows All IPv4 Traffic

**Severity:** Low
**Category:** Network Security

### Description

The default Network ACL allows all IPv4 inbound and outbound traffic.

### Evidence

```text
Inbound:
0.0.0.0/0 — All protocols — Allow

Outbound:
0.0.0.0/0 — All protocols — Allow
```

The default deny rules are evaluated after the allow-all rules and therefore do not restrict normal traffic.

### Risk

The Network ACL provides no meaningful restriction on IPv4 traffic at the subnet boundary.

Network security therefore relies primarily on security groups and other controls.

### Recommendation

For sensitive environments, consider implementing custom Network ACLs with explicitly defined allow rules.

NACL rules should complement, rather than replace, security groups.

---

## Positive Security Observations

The assessment also identified several positive characteristics:

### No EC2 Instances Currently Deployed

No EC2 instances were identified in the assessed region.

This means there are currently no active EC2 workloads directly exposed through the identified network architecture.

### No Elastic IP Addresses Identified

No Elastic IP addresses were identified in the assessment.

This reduces the number of persistent public IPv4 addresses associated with the account.

### Default Security Group Does Not Allow Internet-Wide Inbound Access

The default security group does not contain an inbound rule allowing `0.0.0.0/0`.

The inbound rule permits traffic only from resources associated with the same security group.

---

## Overall Assessment

The assessed AWS environment is relatively minimal, containing a single default VPC with three subnets and no active EC2 instances.

The primary architectural concern is that all subnets are configured for automatic public IPv4 assignment and use routing through an Internet Gateway. This configuration is acceptable for simple development environments but should be redesigned before hosting sensitive or production workloads.

The recommended target architecture is a segmented VPC containing dedicated public and private subnets, controlled routing, workload-specific security groups, and NAT-based outbound access for private resources.
