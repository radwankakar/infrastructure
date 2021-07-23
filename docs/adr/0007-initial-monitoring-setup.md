# Intitial Monitoring and Alerting Status
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: In Review
* Deciders: Sanjay Satagopan, Elizabeth Eady
* Date: 2021-07-23

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options)
* [Links](#links)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

This is not a true ADR. Instead, this ADR documents our first phase of monitoring and alerting processes (as of July 2021).

The ECLKC system experienced an outage on July 17. This outage was reported to the hosting team by the HSICC team on July 18 and was done over email. The problem was fixed, but it exposed the problem that the hosting team itself does not have good monitoring set up that automatically detects outages or critical issues that could then notify the team.

## Decision Drivers <!-- optional -->

* The site must have 99% uptime
  * This leads to following allowed outage times (Reference: https://uptime.is/99)
    * Daily: 14m 24s
    * Weekly: 1h 40m 48s
    * Monthly: 7h 18m 17s
    * Quarterly: 21h 54m 52s
    * Yearly: 3d 15h 39m 29s
* There are several portions of the system that need monitoring, not just the main ECLKC website

## Considered Options

1. Sign up for Uptime Robot to monitor different URLs
2. Set up monitors in AWS

## Decision Outcome

Set up monitors in AWS - need a ticket to implement

### Positive Consequences <!-- optional -->

* Team has good coverage to be aware of issues with system and is able to respond as needed with a clear process

### Negative Consequences <!-- optional -->

* None

## Pros and Cons of the Options <!-- optional -->

### Option 1: 

* PRO: Simple
* PRO: Supports up to 50 monitors
* PRO: Free
* CON: Only monitors public sites, not supporting systems
* CON: Yet another system to use
* CON: Only supports email notifications for free

### Option 2: 

* PRO: Part of AWS ecosystem
* PRO: Can monitor all components
* CON: More complicated to set up
* CON: Have to pay extra for text message support

## Links <!-- optional -->
