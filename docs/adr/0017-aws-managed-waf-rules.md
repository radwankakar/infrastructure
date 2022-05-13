# Using AWS Managed WAF Rules

<!-- Source: https://raw.githubusercontent.com/adr/madr/main/template/adr-template.md -->

Technical Story: [OHSH-587](https://ocio-jira.acf.hhs.gov/browse/OHSH-587)

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Using AWS Managed WAF Rules](#using-aws-managed-waf-rules)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
    - [Positive Consequences](#positive-consequences)
    - [Negative Consequences](#negative-consequences)
  - [Links](#links)

<!-- mdformat-toc end -->

## Context and Problem Statement

Due to some recent attacks, including a DDoS attack and a possible SQL injection attack, the Hosting team has decided to beef up our use of WAF rules.

## Decision Drivers <!-- optional -->

- A series of recent attacks on the ECLKC system.
- We currently only have a single rule on our global Cloudfront WAF ACL, Production-Cloudfront.
- Our current rules on the Production WAF ACL are more reactive, and not a cover for attacks that we haven't already encountered.

## Considered Options

1. Using AWS managed WAF rules, along with the rules the Hosting team already implemented.
1. Continuing only using Hosting team created and managed WAF rules
1. Use a combination of AWS managed WAF rules and existing Hosting team managed rules to add more layers of security.

## Decision Outcome

Use a combination of AWS managed WAF rules and existing Hosting team managed rules to add more layers of security.

### Positive Consequences

- The AWS managed WAF rules can provide a wider net and better stay up to date with threats than the Hosting team have the resources to do.
- Whereas AWS can provide broad protections, we can still create and manage rules that are more particular for our use case.

### Negative Consequences <!-- optional -->

- None

## Links <!-- optional -->

- [AWS Manage Rules Docs](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups.html)
