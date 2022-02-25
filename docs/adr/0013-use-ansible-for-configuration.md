# Use Ansible For Host Configuration

<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors -->

- [Use Ansible For Host Configuration](#use-ansible-for-host-configuration)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
    - [Positive Consequences](#positive-consequences)
    - [Negative Consequences](#negative-consequences)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Use Ansible to manage machine configuration](#use-ansible-to-manage-machine-configuration)
    - [Building pre-packed AMIs to manage system deployments](#building-pre-packed-amis-to-manage-system-deployments)
    - [Continue manually managing systems](#continue-manually-managing-systems)


<!-- mdformat-toc end -->

## Context and Problem Statement

We maintain many hosts for our app dev teams - each of these require a different set of packages and configurations to function as intended. Different hosts also require different users. Currently these systems are all managed manually, meaning that repeated tasks take longer than they should, and take away time that could be used for improvements to the system.

## Decision Drivers

- Adhoc requests to add users to machines and VPN - current manual process results in technical toil and lack of one source of truth that contains all user management information. Manually completing configuration tasks is more error prone in comparison to automating configuration tasks.
- Dependency management / maintaining different versions of packages on different machines
- Manual management of system takes time away from planned improvements

## Considered Options

- Use Ansible to manage machine configuration
- Building pre-packed AMIs to manage system deployments
- Continue manually managing systems

## Decision Outcome

Use Ansible to manage machine configuration. This decision was chosen because ansible was already configured and setup, making it an option that can be implemented quickly and fairly easily.

### Positive Consequences

- Repeated manual tasks can be defined as automated processes without too much of a heavy lift from the team
- More secure environment setup (process of managing user access and permissions more transparent and easily audited)

### Negative Consequences

- Building off of the currently existing ansible setup will require restructuring to be used successfully which might mean re-doing work (for example, regrouping our already defined hosts list and modifying ansible playbooks accordingly)

## Pros and Cons of the Options

### Use Ansible to manage machine configuration

- Good, because ansible is already installed and configured, requiring no extensive setup on our part
- Good, because lots of documentation about ansible syntax exists, making it fairly approachable to start learning
- Good, because it (generally) will only run updates that need to be run (vs. scripting with bash, etc.)
- Good, because it allows us to have some level of configuration as code, which means also leveraging code review processes when making changes via ansible, ensure it is repeatable, etc.
- Good, because doesn't require us to redeploy existing machines (vs. using a golden image/pre-packed AMI) to manage and make changes
- Good, does not require an agent on systems and uses python and ssh
- Bad, because no notion of state. Ansible does not track dependencies and executes tasks until they complete successfully or fail. This means we have to be extra vigilant to make sure the state of a machine is as expected

### Building pre-packed AMIs to manage system deployments

- Good, because faster start times and easier dependency configuration
- Bad, because most teams have very different requirements so there wouldn't be many commonalities to create a base image
- Bad, because we would be responsible for maintaining many different images for all the teams
- Bad, because would require a redeploy on all existing machines, which would be difficult and a heavy lift for the team
- Bad, would require container / image management agent installation on all machines
- Bad, because for each change all updates will be run instead of just the updates that need to be made

### Continue manually managing systems

- Good, because it's the easiest option in the short term
- Bad, because manually managing systems creates a lot of extra work for team
- Bad, because many improvements to the system would be blocked by manual management of systems
- Bad, because no configuration as code, which means changes are not repeatable and don't go through code review process
