# AWS Security Hub + GuardDuty Findings

## Overview

This document records the security findings identified during the AWS Security Hub and Amazon GuardDuty assessment.

The assessment was performed after enabling AWS Security Hub and Amazon GuardDuty in the AWS environment.

Findings were reviewed through the AWS Security Hub console and AWS CLI.

---

## Security Hub Findings Summary

AWS Security Hub reported the following findings by severity:

| Severity      | Findings |
| ------------- | -------: |
| Critical      |        2 |
| High          |        1 |
| Medium        |       13 |
| Low           |        2 |
| Informational |       39 |
| **Total**     |   **57** |

These findings represent security posture checks and security-related detections identified by AWS security services.

The findings should be reviewed based on severity, affected resource, status, and business impact.

---

## Critical Findings

### Finding Count

**2 Critical findings were identified.**

### Risk

Critical findings represent the highest-priority security issues identified by Security Hub.

These findings should be investigated immediately to determine:

* The affected AWS resource.
* The security control that was violated.
* Whether the issue is actively exploitable.
* Whether the finding represents a real security risk or false positive.
* Whether immediate remediation is required.

### Recommended Action

Review the two Critical findings in:

**AWS Security Hub → All findings**

Prioritize these findings for immediate investigation and remediation.

---

## High Severity Findings

### Finding Count

**1 High severity finding was identified.**

### Risk

High severity findings may represent significant security weaknesses that could expose AWS resources or increase the risk of unauthorized access.

### Recommended Action

Review the affected resource and security control.

Apply the recommended AWS security configuration and verify that the finding is resolved.

---

## Medium Severity Findings

### Finding Count

**13 Medium severity findings were identified.**

### Risk

Medium severity findings may represent security configuration weaknesses that could contribute to a larger security incident if left unresolved.

### Recommended Action

Review the findings and prioritize remediation based on:

* Resource exposure.
* Potential attack impact.
* Business importance.
* Exploitability.
* Existing compensating controls.

---

## Low Severity Findings

### Finding Count

**2 Low severity findings were identified.**

### Risk

Low severity findings generally represent lower-risk security weaknesses or configuration improvements.

### Recommended Action

Address these findings as part of ongoing cloud security hardening and continuous improvement.

---

## Informational Findings

### Finding Count

**39 Informational findings were identified.**

### Risk

Informational findings generally provide security context, observations, or configuration information and may not represent an immediate security vulnerability.

### Recommended Action

Review informational findings to determine whether they provide useful security context or indicate opportunities for improving the AWS security posture.

---

# Amazon GuardDuty Findings

Amazon GuardDuty was successfully enabled and a GuardDuty detector was identified using the AWS CLI.

### GuardDuty Detector

```text
decfc0342b44bff462cc97bbb465a5d8
```

### GuardDuty Findings

**2 GuardDuty findings were identified.**

The finding IDs were:

```text
f8cfc036f2d5c39fed336a93217d0369
78cfc038421ed21212492eeb6d89fe66
```

Detailed GuardDuty finding information was exported to:

```text
reports/guardduty-details.json
```

The finding identifiers were exported to:

```text
reports/guardduty-findings.json
```

---

## GuardDuty Finding Analysis

The two GuardDuty findings should be reviewed in the AWS GuardDuty console and correlated with the corresponding Security Hub findings where applicable.

The investigation should determine:

* Finding type.
* Severity.
* Affected AWS resource.
* First detected time.
* Last detected time.
* Source IP address, if applicable.
* Destination resource, if applicable.
* Threat intelligence information.
* Whether the activity is expected or malicious.

---

## Security Hub and GuardDuty Integration

AWS Security Hub provides centralized visibility into security findings, while Amazon GuardDuty provides continuous threat detection.

The integration allows security teams to:

* Centralize security findings.
* Prioritize security alerts.
* Investigate potentially malicious activity.
* Correlate findings across AWS security services.
* Monitor AWS resources.
* Support incident response.
* Track the AWS security posture.

---

## Evidence

The following evidence was collected during the assessment:

```text
screenshots/
├── guardduty-enabled.png
├── securityhub-enabled.png
└── findings.png
```

The screenshots demonstrate:

* GuardDuty enabled.
* Security Hub enabled.
* Security Hub findings and severity overview.

---

## Exported Evidence

The following security data was exported using the AWS CLI:

```text
reports/
├── securityhub-findings.json
├── guardduty-findings.json
└── guardduty-details.json
```

These files provide machine-readable evidence of the security findings identified during the assessment.

---

## Assessment Conclusion

The assessment successfully demonstrated the deployment and integration of AWS Security Hub and Amazon GuardDuty.

The environment contained:

* **57 Security Hub findings**
* **2 Critical Security Hub findings**
* **1 High Security Hub finding**
* **13 Medium Security Hub findings**
* **2 Low Security Hub findings**
* **39 Informational Security Hub findings**
* **2 GuardDuty findings**

The Critical and High severity findings should receive the highest remediation priority.