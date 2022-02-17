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

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

We maintain many hosts for our app dev teams - each of these require a different subset of packages / configuration / etc to function as intended. Different hosts also can require different users. 

## Decision Drivers <!-- optional -->

* Adhoc requests to add users to machines
* Adhoc requests to add users to the VPN
* Dependency management / maintaining different versions of packages on different machines

## Considered Options

* [Use Ansible to manage machine configuration]
* [Building pre-packed AMIs to manage system deployments]

## Decision Outcome

Chosen option: "Use Ansible to manage machine configuration", because ansible was already setup, team member already has experience in it and can train others, and is the easiest way to automate currently nmanual actions

### Positive Consequences <!-- optional -->

* Many currently manual tasks automated 
* Repeated tasks defined as processes
* More secure setup (process of removing access easier)

### Negative Consequences <!-- optional -->

* Building off of the currently existing ansible setup will require restructuring to be used successfully 

## Pros and Cons of the Options <!-- optional -->

### Use Ansible to manage machine configuration

* Good, because ansible already installed and configured
* Good, because ansible is fairly easy to pickup and lots of document exists 
* Good, does not require an agent on systems and uses python and ssh
* Bad, because no notion of state 

### Building pre-packed AMIs to manage system deployments

* Good, because faster start times and easier dependency configuration
* Bad, because most teams have very different requirements so there wouldn't be many commonalities to create a base image
* Bad, because we would be responsible for maintaining many different images for all the teams 