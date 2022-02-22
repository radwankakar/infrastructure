# Using Ansible For Host Configuration
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

## Table of Contents

<!-- toc -->

- [Using Ansible For Host Configuration](#using-ansible-for-host-configuration)
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

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

We maintain many hosts for our app dev teams - each of these require a different set of packages and configurations to function as intended. Different hosts also require different users. Currently these systems are all managed manually, meaning that repeated tasks take longer than they should, and take away time that could be used for improvements to the system.

## Decision Drivers 

* Adhoc requests to add users to machines
* Adhoc requests to add users to the VPN
* Dependency management / maintaining different versions of packages on different machines
* Manual management of system takes time away from planned improvements 

## Considered Options

* Use Ansible to manage machine configuration
* Building pre-packed AMIs to manage system deployments
* Continue manually managing systems

## Decision Outcome

Use Ansible to manage machine configuration. This decision was chosen because because ansible was already configured and setup, making it an option that can be implemented quickly and fairly easily.

### Positive Consequences <!-- optional -->

* Repeated manual tasks can be defined as automated processes without too much of a heavy lift from the team 
* More secure environment setup (process of managing user access and permissions more transparent and easily audited)

### Negative Consequences <!-- optional -->

* Building off of the currently existing ansible setup will require restructuring to be used successfully which might mean re-doing work (for example, regrouping our already defined hosts list and modifying ansible playbooks accoerdingly)

## Pros and Cons of the Options <!-- optional -->

### Use Ansible to manage machine configuration

* Good, because ansible is already installed and configured, requiring no extensive setup on our part
* Good, because lots of documentation about ansible syntax exists, making it fairly approachable to start learning 
* Good, does not require an agent on systems and uses python and ssh
* Bad, because no notion of state. Ansible does not track dependencies and executes tasks until they complete successfully or fail. This means we have to be extra vigilant to make sure the state of a machine is as expected

### Building pre-packed AMIs to manage system deployments

* Good, because faster start times and easier dependency configuration
* Bad, because most teams have very different requirements so there wouldn't be many commonalities to create a base image
* Bad, because we would be responsible for maintaining many different images for all the teams 

### Continue manually managing systems 

* Good, because it's the easiest option
* Bad, because manually managing systems creates a lot of extra work for team
* Bad, because many improvements to the system would be blocked by manual management of systems 