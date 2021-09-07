# [Supporting OHS Hosting with a Small Team]
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: proposed <!-- optional -->
* Deciders: Sanjay, Eady, Rebecca, Jerel, Alana, Nate <!-- optional -->
* Date: 2021-09-02 <!-- optional -->

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences)
  * [Negative Consequences](#negative-consequences)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options)
  * [[option 1]](#option-1)
  * [[option 2]](#option-2)
  * [[option 3]](#option-3)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

The Truss hosting team has only three technical members. However, as part of the QASP for the project, we are required to maintain 99% uptime for the system. Two of the three technical team members are located in Pacific time. With these constraints, it's not sustainable for the team to maintain a weekly rotation to maintain 24x7 support in case of incidents.

## Decision Drivers <!-- optional -->

* Outages caused during penetration testing took a while to respond to and resolve
* On call every three weeks is not great

## Considered Options

1. Increase size of team
1. Change support requirements
1. Status quo

## Decision Outcome

Chosen option: "A blend of 1 and 2", because it addresses the short term needs of the project.

It's a blend because we are increasing the size of the team during certain hours only for support purposes while considering outages during the hours of 2AM-7AM ET lower priority, i.e. do not need to trigger an alert to the team.

Sam Nevares from the HSICC team will be helping during the hours of 7AM ET to 11AM ET on weekdays.

In order for Sam to be able to help, he will need to be granted read-only access to AWS production environment as well as write access to the Cloudfront and WAF rules. The team will also need to enable him to switch to Lifeboat without providing more access in AWS and the same for restarting the MariaDB server.

Once Sam is provided these capabilities, those same capabilities will be extended to Sanjay, who will then be able to provide some additional support. However, this will also require runbooks to be created for common troubleshooting procedures.

### Positive Consequences <!-- optional -->

* System has required support during the most active hours
* Team is able to focus more on implementing the new system vs. supporting the old

### Negative Consequences <!-- optional -->

* Still a need for existing team to support old system leading to less time for new

## Pros and Cons of the Options <!-- optional -->

### Increase the size of the team

* Good, because it provides the capacity for team to work on new system
* Good, because it offers a more sustainable rotation schedule
* Bad, because it costs more to someone, either Truss or OHS

### [option 2: Change support requirements]

* Good, because it makes supporting the system more sustainable for the team
* Good, because it clarifies expectations for everyone
* Bad, because it reduces support posture generally

### [option 3: Status quo]

* Good, because no change
* Bad, because not sustainable
* Bad, because no time to work on new system

