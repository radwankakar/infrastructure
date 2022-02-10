

# Move Jenkins Behind VPN
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

## Table of Contents

<!-- toc -->

- [Move Jenkins Behind VPN](#move-jenkins-behind-vpn)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
    - [Positive Consequences](#positive-consequences)
    - [Negative Consequences](#negative-consequences)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Change Security Group Rules](#change-security-group-rules)
    - [Redeploy Jenkins instance](#redeploy-jenkins-instance)
    - [Do Nothing](#do-nothing)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

Currently Jenkins is available through the public internet. While there are controls to prevent unauthorized access, it's still not best practice to continue this since the current setup is a blocker for using Jenkins for automation during deployments.

We need to move the Jenkins machine behind the VPN so that the Jenkins UI can only be accessed when connected to the VPN. SSH Access is already restricted for Jenkins but we want to lock down access to the UI as well. 

## Decision Drivers 

* Reduce technical toil
* Automate currently manual tasks
* Possibility of replacing Jenkins with an alternate CI/CD system in the future 

## Considered Options

* One proposed solution is to change the security group rule(s) of our currently deployed Jenkins instance. We could add a security group rule that only allows a connection from the VPN and blocks all other traffic.
* The second proposed solution is to redeploy Jenkins within a private subnet that the VPN can access. This change would include: deploying a new instance of Jenkins in a private subnet that the VPN can access, communicating with OHS teams using Jenkins to not make any changes in the old instance, and transferring jobs over to the newly deployed instance batch by batch. 
* The third proposed solution is to do nothing and leave Jenkins setup as is.

## Decision Outcome

Chosen option: change security groups rules of our currently deployed Jenkins instance, because it is the lowest lift option that allows us to automate currently manual actions and reduce technical toil. This in turn will allow us to focus on improvements to the system.

### Positive Consequences 

* Jenkins locked down behind VPN 
* A more secure setup will allow us to feel more confident in granting Jenkins additional permissions which will allow us to automate deployments and many other currently manual processes

### Negative Consequences 

* Greater risk of unplanned downtime due to security group rule misconfiguration in comparison to the other options

## Pros and Cons of the Options 

### Change Security Group Rules

* Good, doesn’t require Jenkins redeploy
* Good, lower lift to implement / can be implemented relatively quickly
* Bad, Jenkins would still be in public subnet, which is not best practice given security considerations. Leaving Jenkins in the public subnet means it is theoretically accessible via the public internet, but locking it down with security groups will mitigate a lot of this risk


### Redeploy Jenkins instance

* Good, Jenkins would be in private subnet, which is best practice given security considerations. Redeploying Jenkins in a private subnet means Jenkins could not be accessed via the public internet. This would eliminate security risks associated with public subnets
* Bad, Jenkins redeploy required - this is a greater lift from the team, most of whom do not have access at the time. We also plan to stop using Jenkins as part of our future improvements to the system which means the redployed instance will likely be taken out of use.
* Bad, would require communication to OHS teams 
* Bad, would require coordination to batch and test jobs as we move them


### Do Nothing 

* Good, team won't have spend time working on something that's being taken out of use in the future 
* Bad, automation of manual deployment tasks blocked on current Jenkins setup