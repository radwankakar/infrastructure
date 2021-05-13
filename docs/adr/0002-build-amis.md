# Build AMIs to manage installed software
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: proposed
* Deciders: Elizabeth Eady, Ryan Ahearn, Jerel Smith
* Date: 20210-04-11

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers-)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options-)
  * [Option 1: Build AMIs from scratch using configuration management](#option-1-build-amis-from-scratch-using-configuration-management)
  * [Option 2: Get Developers to change their apps to better fit in Docker containers then build those](#option-2-get-developers-to-change-their-apps-to-better-fit-in-docker-containers-then-build-those)
  * [Option 3: Implement Ansible or Chef or Puppet or Saltstack to keep currently running instances up to date](#option-3-implement-ansible-or-chef-or-puppet-or-saltstack-to-keep-currently-running-instances-up-to-date)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

Most of the running servers in the ECLKC hosting AWS account have been running for a month or two.
The oldest instance is from 2015.
The team has kept these servers running and up to date by executing ansible scripts during regular maitenence windows.

## Decision Drivers <!-- optional -->

* Consistency of servers being stood up.
* Repeatability of server creation.
* Future scalability of servers and applications we host.
* Enabling dev teams to have more ownership of what is installed on their servers.

## Considered Options

* Build AMIs from scratch using configuration management.
* Get Developers to change their apps to better fit in Docker containers then build those.
* Implement Ansible or Chef or Puppet or Saltstack to keep currently running instances up to date.

## Decision Outcome

We will do Option 1: Build AMIs from scratch using configuration management.

We can test different methods and tools for final implementation but we will start with Packer and Ansible.

* Good, because this will create repeatable artifacts for software distribution down to the operating system configuration. This will create consistency.
* Good, because dev teams can directly contribute to the definition of their servers.
* Good, because as we work with dev teams, we can help them transition to more modern software delivery and configuration practice.
* Bad, because this keeps us using ec2 instances on AWS.
  * Note, this can be mitigated by choosing tools that can output other artifacts.

## Pros and Cons of the Options <!-- optional -->

### Option 1: Build AMIs from scratch using configuration management

Write configuration to build AMIs each time.

* Good, because this will create repeatable artifacts for software distribution down to the operating system configuration. This will create consistency.
* Good, because dev teams can directly contribute to the definition of their servers.
* Good, because as we work with dev teams, we can help them transition to more modern software delivery and configuration practice.
* Bad, because this keeps us using ec2 instances on AWS.
  * Note, this can be mitigated by choosing tools that can output other artifacts.

### Option 2: Get Developers to change their apps to better fit in Docker containers then build those

Move our apps into Docker containers. This requires developers to make adjustments to their apps that may take a distinct amount of effort.

* Good, because this will create repeatable artifacts for software distribution.
* Good, because we can scan images built for security vulnerabilities and updates.
* Good, because this fits with more modern software development and delivery practice.
* Good, because this can give developers more autonomy in building artifacts to deploy across dev/stage/prod.
* Bad, because this would be a large sustained effort working with development teams that would keep us from working on other initiatives this team would like to start.

### Option 3: Implement Ansible or Chef or Puppet or Saltstack to keep currently running instances up to date

Use a common configuration management system to update existing instances.

* Good, because it would help to keep servers up to date an in sync wth each other.
* Good, because defining the server configuration as code can be reviewable and auditable by stakeholders and developers.
* Bad, because continuing to update the same instances can create more divergent configuration across environments.
* Bad, because if an update run fails the instances will be even more divergent.
