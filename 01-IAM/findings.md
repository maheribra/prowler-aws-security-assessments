# AWS IAM Security Assessment Findings

## Assessment Details

- **Tool:** Prowler v5.34.0
- **Service:** AWS IAM
- **Cloud Provider:** Amazon Web Services (AWS)

## Initial Assessment

The initial Prowler IAM assessment identified security gaps within the AWS account.

### Before Hardening Results

| Severity | Findings |
|---|---|
| Critical | 1 |
| High | 4 |
| Medium | 9 |
| Low | 6 |

**Total Failed Checks:** 20  
**Total Passed Checks:** 19  

---

# Key Findings

## Critical Findings

### Root Account Hardware MFA

**Finding:**
- Root account was using virtual MFA instead of hardware MFA.

**Risk:**
- Hardware-backed MFA provides stronger protection against account compromise.

**Recommendation:**
- Use a hardware MFA security key for the AWS root account.

---

## High Severity Findings

### Root Account Usage

**Finding:**
- AWS root account was recently accessed.

**Risk:**
- Root account usage increases the risk of full account compromise.

**Recommendation:**
- Avoid daily root account usage.
- Use IAM users or roles with least privilege permissions.

---

### IAM User Console MFA

**Finding:**
- IAM user `prowler-auditor` had console access without MFA protection.

**Risk:**
- Compromised credentials could allow unauthorized AWS console access.

**Recommendation:**
- Enable MFA for all IAM users with console access.

---

### Long-Lived Credentials

**Finding:**
- IAM user `prowler-auditor` used long-lived access keys.

**Risk:**
- Static credentials increase the risk of credential exposure.

**Recommendation:**
- Use temporary credentials through IAM roles where possible.

---

# Medium Severity Findings

Examples of medium-risk findings identified:

- Unused permissions for AWS AI services (Bedrock/SageMaker)
- Additional IAM permission reviews required
- Least privilege improvements needed

---

# Low Severity Findings

Examples of low-risk findings identified:

- Missing dedicated IAM support/audit roles
- Missing enterprise federation configuration
- IAM policies attached directly to users instead of groups

---

# Final Assessment

After remediation, the number of failed checks decreased:

| Metric | Before | After |
|---|---|---|
| Failed Checks | 20 | 13 |
| Passed Checks | 19 | 26 |

Remaining findings require additional architectural changes such as hardware MFA, federation, and IAM redesign.