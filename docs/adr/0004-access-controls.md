# Access Controls

- Status: draft
- Deciders: @kilbergr @eeeady @rahearn
- Date: 2021-06-11

## Context and Problem Statement

As the project matures, roles will surface so users of the system have agency to debug problems and remain effective in their roles. However, not every user of the system needs access to the same resources. For example, engineers do not need access to Production database but should be able to look at Staging CloudWatch logs to debug issues. We have been using [Principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) to drive what access and privileges are available to a given role.

We anticipate the following user roles in our systems:

- Engineer
- Infrasec/Admin
- Auditor/Business

We anticipate the following environments in our system:

- Sandbox
- Development
- Staging
- Production

### Current groups and permissions associated with them

- dba (Unused)
  - AmazonEC2ReadOnlyAccess
  - CloudWatchFullAccess
  - MFA
- Developers
  - ELB and ELB v2 Full Access
  - EC2 List, Read Access
  - MFA
- DevStagingOnly (Unused)
  - EC2 List, Read, Write for ECLKCDev and Stage1 instances
- HHSAccountManager
  - Billing
- Read-Only (Unused)
  - ReadOnlyAccess
- S3_Access
  - AmazonS3FullAccess
- SupportAccessOnly (Unused)
  - AWSSupportAccess
- Sysadmins
  - IAMUserChangePassword
  - Allow ALL on ALL
- TMSC
  - permissions to describe and alter codecommit on cleverex and drupaldev resource

## Decision Drivers

In general, we prefer to follow the [Principle of Least Privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) to guide how we determine access controls. Roles should allow access to the infrastructure resources required to be effective while reducing security surface area or accidental changes to the system that might prove detrimental.

## Considered Options

- Every user has the same (full) rights and permissions for all environments.
- Access is determined based on role and environment.

## Decision Outcome

Continue to use the "Principle of least privilege" to drive roles' access, because it reduces the security surface area.

### Positive Consequences

- Better system stability
- Better system security
- Ease of deployment
- Reduce bottlenecks due to lack of access

### Negative consequences

- Potential for friction if user needs access to one of resource outside of normal use

## Further detail

In brief: Production should remain as locked down as possible. Infrastructure and security team members will have full administrative access to all four environments, including the production system, because it's essential to those team members' work. Individuals in an Auditor role will be granted read only access to all four environments. Engineers will have read only access to most of the production systems but greater access in the Sandbox, Development, and Staging environments.

Below is a chart of anticipated access requirements for which services. We will evaluate and add service access to these roles as we introduce them to the hosting system.

### Engineer role:

- Read information about ECS clusters, services, tasks, and task definitions in all environments.
- Stop tasks and update ECS services in Staging, Development, and Sandbox.
- Run and start ECS tasks in Development, Sandbox, and Staging.
- Modify event rules for ECS Scheduled Tasks in Staging, Development, or Sandbox.
- Modify IAM roles for ECS Scheduled Tasks in Staging, Development, or Sandbox.
- Full access to AWS Support, AWS Health.
- Read only access to SES, WAF, ECR, RDS, Route53, EC2, ALB, CloudWatch.
- Can modify SSM parameter store variables in Development, Sandbox, and Staging environments.
- Can modify S3 buckets in Development, and Sandbox.
- Cannot modify any S3 buckets in Production environment.

A note about the singular Engineer role:
We suspect we will be moving toward a one account per environment set up. In addition, we currently have very few developers in this role. As a result, we are not going to split access according to applications and instead expect these roles will evolve over the next year or so as we change our account configuration.

### Auditor/Business role:

- Read only access to S3, SES, IAM, Route53, RDS, VPC, SNS, CloudTrail, Lambda, Cloudfront, CloudWatch, ECR, Health.
- Access to AWS Billing

### Infrasec/Admin role:

- Full Read/Write access to all resources.

## Links

- [NIST definition of least privilege](https://csrc.nist.gov/glossary/term/least-privilege)
- [Wikipedia article on PoLP](https://en.wikipedia.org/wiki/Principle_of_least_privilege)
