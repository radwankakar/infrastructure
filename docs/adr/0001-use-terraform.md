# Use Terraform to Manage AWS Resources
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: Approved
* Deciders: Elizabeth Eady, Ryan Ahearn, Jerel Smith
* Date: 2021-05-11

## Table of Contents
<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers-)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences-)
  * [Negative Consequences](#negative-consequences-)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options-)
  * [[option 1]](#option-1)
  * [[option 2]](#option-2)
  * [[option 3]](#option-3)
* [Links](#links-)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

The resources currently managed in the ECLKC hosting AWS account were configured manually from the AWS console.
This has made validation of proposed changes to production difficult.
Furthermore, development teams do not currently have deep access and visibility to the configuration in AWS that affects the performance of their applications so debugging customer issues takes a long time.

## Decision Drivers <!-- optional -->

* The ability to consistently apply changes to AWS resources across dev/staging/production.
* The ability to stand up a new environment quickly in the case of a disaster event.
* The ability for developers, CORS, partner stakeholders, ACF officials to review and audit the resources in the ECLKC hosting AWS account.
* The ability to allow developers to evaluate and request changes to AWS resources for different environments and have confidence in that those changes will be applied identically.
* The ability to run analysis tools against the proposed changes to the AWS account.

## Considered Options

* Continue using AWS console
* Automation using Cloudformation
* Automation using Terraform
* Custom automation tooling

## Decision Outcome

We have chosen Option 3: Use Terraform.

### Positive Consequences <!-- optional -->

* infrastructure as code will allow us to run tools to scan and audit our configuration increasing security and compliance stance.
* infrastructure as code will allow us to take suggestions and contributions directly from development teams.
* infrastructure as code will allow us to consistently make changes across different envrionment levels and AWS regions.
* infrastructure as code allows us to build towards self service for development teams.
* infrastructure as code allows us to directly integrate code/infrastructure changes into a structured change request process on a public platform.
* Terraform is open source AND is built and maintained by Hashicorp (a large and relatively stable software company).
* Terraform has a large open source community supporting plugins and modules.
* Terraform has multiple plugins and backends we can use if we wish to move hosting platforms.

### Negative Consequences <!-- optional -->

* Mapping existing configuration into Terraform may take quite a bit of time and effort.
* Terraform is declarative and has gotchas when running a deployment with them.
  * We will need to evaluate how to deploy application code outside of Terraform because it is not flexible enough for the quick iteration application development requires.
* Terraform code will be mostly specific to AWS so if we need to transition to a new platform this will require addditional work.

## Pros and Cons of the Options <!-- optional -->

### Option 1: Continue using AWS Console

Point and click in the AWS web console. This can get you pretty far.

* Good, because it's relatively accessible for folks coming onto a project.
* Bad, because without automation we will continue to see drift in configuration across dev/stage/production.
* Bad, because without automation we will have a harder time enforcing which AWS regions resources will be spun up in.
* Bad, because we will have to give developer teams more access that could possibly allow for misconfiguration.
* Bad, because we would rely more on AWS specific scanning technologies for policy enforcement.
* Bad, because individual changes are harder to track, evaluate, and back out.

### Option 2: Automation using Cloudformation

This is AWS's infrastructure as code solution. It works.

* Good, because the configuration of resources would be in code so we can track and have dev teams suggest changes.
* Good, because it's tightly integrated with AWS and we can use built in tools to help manage and scan for configuration problems and risks.
* Good, because infrastructure as code will allow us to take suggestions and contributions directly from development teams.
* Good, because infrastructure as code will allow us to consistently make changes across different envrionment levels and AWS regions.
* Good, because infrastructure as code allows us to build towards self service for development teams.
* Bad, because sometimes this can get into an indeterminate state that is hard to debug from the console or cli.
* Bad, because this makes the configuration lift out of AWS more difficult.
* Bad, because this tool is less commonly used and general community support is harder to come by.

### Option 3: Automation using Terraform

The common industry tool for managing AWS resources among other infrastructure platforms.

* Good, because infrastructure as code will allow us to run tools to scan and audit our configuration increasing security and compliance stance.
* Good, because infrastructure as code will allow us to take suggestions and contributions directly from development teams.
* Good, because infrastructure as code will allow us to consistently make changes across different envrionment levels and AWS regions.
* Good, because infrastructure as code allows us to build towards self service for development teams.
* Good, because infrastructure as code allows us to directly integrate code/infrastructure changes into a structured change request process on a public platform.
* Good, because Terraform is open source AND is built and maintained by Hashicorp (a large and relatively stable software company).
* Good, because Terraform has a large open source community supporting plugins and modules.
* Good, because Terraform has multiple plugins and backends we can use if we wish to move hosting platforms.
* Bad, because mapping existing configuration into Terraform may take quite a bit of time and effort.
* Bad, because Terraform is declarative and has gotchas when running a deployment with them.
  * We will need to evaluate how to deploy application code outside of Terraform because it is not flexible enough for the quick iteration application development requires.
* Bad, because Terraform code will be mostly specific to AWS so if we need to transition to a new platform this will require addditional work.

### Option 4: Custom Automation Tooling

This could be some combination of Ansible or shell scripts or Python using AWS libraries.

* Good, because the configuration of resources would be in code so we can track and have dev teams suggest changes.
* Good, because we can be flexible to allow for multiple platforms and the same tools could be customized further to help with automated deployments of applciations.
* Bad, because would require us to define a specific interface for folks to use that could drift quickly.
* Bad, because it would be different from common practices in the wider DevOps community and hard to teach newcomers to the project.
* Bad, because linting tools might not work against custom tools.
* Bad, because maintaining custom tools is time consuming and expensive.
