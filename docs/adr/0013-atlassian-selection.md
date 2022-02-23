# Provide Atlassian suite for OHS IT teams
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: proposed
* Deciders: Hosting team, client system owner, OHS app team reps
* Date: 2022-02-22

Technical Story: [OHSH-469](https://ocio-jira.acf.hhs.gov/browse/OHSH-469)

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences-)
  * [Negative Consequences](#negative-consequences-)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options-)
  * [Atlassian](#atlassian)
  * [Integrations](#integrations)
  * [Process](#process)
* [Links](#links-)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

### Background

The Office of Head Start (OHS) currently has several systems and applications being maintained and developed by different teams, both OHS and vendor teams. These include Early Childhood Learning & Knowledge Center (ECLKC), Head Start Coaching Companion (HS CC), Individualized Professional Development (iPD) Portfolio, Early Educator Central (EEC), TTA Hub, and several mobile apps. 

All these teams use different tools for their development processes, including task management, development, automated test, build and deploy, documentation, and support notifications. For example, the hosting team uses ACF Jira for task management, GitHub for code and documentation, and PagerDuty for support notifications, the HSICC team uses their own Jira for task management, GitHub for code, Jenkins for build and deploy, the Paradiso team uses Service Desk for task management, GitHub for code, etc.

These teams also follow different processes when it comes to their development and deployment pipeline. Some have a form of CI with automated tests while others do not. Some use Jenkins to deploy while others are updated by doing a git pull directly from the application server(s).
OHS has oversight responsibilities over all the systems that these teams build and maintain, yet there is no consolidated review system. There is also no consolidated or collaborative planning process when it comes to future work. The systems and teams are dependent on each other for some functionality yet they cannot always identify those dependencies ahead of time so that the teams can align their work together.

As part of our project scope, we are tasked with helping facilitate collaboration and communication across OHS IT teams and moving OHS IT teams to more DevSecOps practices. We have made a start with providing a Slack workspace and introducing a cross-team sprint review. However, teams still use separate tools and processes for development and deployment. And there is still not a coordinated planning activity across OHS so teams are still identifying dependencies too late.

### Problems
1. OHS is not able to view program status across OHS IT so that they can monitor for issues and take action if needed.
1. OHS cannot view and/or manage the software code of all the OHS IT systems in production so that they can own the systems in truth.
1. OHS IT teams cannot collaboratively plan their work so that the teams can ensure success of their different work items while aligning with OHS program priorities.
1. OHS IT teams cannot identify dependencies between each other so that they can mitigate or resolve any risks that come from them.
1. Not all OHS IT teams have monitoring and alerting systems in place so that they can be notified of and act on issues that arise.
1. Not all OHS IT teams are following DevSecOps best practices so that OHS can be assured of success.

## Decision Drivers

1. Can provide a consolidated view of status and roadmaps across OHS IT teams
1. Cost
1. Simplicity of use and administration
1. Integrations with different systems, i.e. between code development and task management, between task management and incident management, to Slack, etc.

## Considered Options

1. Bitbucket, Jira, Confluence, and Opsgenie from Atlassian
1. Integrate existing systems and develop a way to present consolidated view to OHS
1. Status quo of systems, but use process and communications to achieve objectives

## Decision Outcome

Chosen option: "Option 1", because it offers an integrated solution out of the box, it can be configured and supported by non-engineers (allowing them to do more valuable engineering work), and can be used to support processes and communications while process only can only do so much.

### Positive Consequences <!-- optional -->

* Flexible enough to support baseline standards while providing teams autonomy
* Doesn't require engineering effort
* Within project budget

### Negative Consequences <!-- optional -->

* Hosting team may become tools administrators (IT Dept)

## Pros and Cons of the Options <!-- optional -->

### Atlassian

Bitbucket, Jira, Confluence, and Opsgenie from Atlassian

* Good, because several teams already use an Atlassian product so there should be less of a learning curve
* Good, because it can in theory address all the identified needs
* Bad, because it makes us act as IT administrators
* Bad, because it makes some teams use new systems

### Integrations

Integrate existing systems and develop a way to present consolidated view to OHS

* Good, because it doesn't require teams to use new systems
* Good, because it could still address the needs
* Bad, because it requires engineering effort to provide the consolidated view
* Bad, because it is harder to establish baseline standards for processes

### Process

Status quo of systems, but use process and communications to achieve objectives

* Good, because it doesn't require teams to use new systems
* Bad, because it is harder to establish baseline standards for processes
* Bad, because it doesn't address all the needs: specifically, a consolidated view of teams for OHS

## Links <!-- optional -->

* [Atlassian OpenDevOps](https://www.atlassian.com/solutions/devops/features)
