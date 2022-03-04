# Compare OpenVPN CE, OpenVPN Access Server, and AWS VPN
<!-- Source: https://raw.githubusercontent.com/adr/madr/main/template/adr-template.md -->

* Status: proposed by Mondo
* Deciders: ????
* Date: 2022-23-2022

Technical Story: [OHSH-473](https://ocio-jira.acf.hhs.gov/browse/OHSH-473)

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers-)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences-)
  * [Negative Consequences](#negative-consequences-)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options-)
  * [OpenVPN CE](#OpenVPN-CE)
  * [OpenVPN Access Server](#OpenVPN-Access-Server)
  * [AWS VPN](#AWS-VPN)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

We currently are using OpenVPN for the VPN for OHS. We believe it's the community edition, which is free, but they also offer Access Server which costs money per concurrently connected user. Additionally, AWS offers a VPN we could potentially deploy and use instead as well.

We suspect we want to stick with a flavor of OpenVPN, but it's worth researching and documenting why that and not AWS's VPN option.

## Decision Drivers <!-- optional -->

* implementation  
* user provisioning

## Considered Options

* OpenVPN CE
* OpenVPN Access Server
* AWS VPN

## Decision Outcome

Chosen option:

### Positive Consequences

*
*

### Negative Consequences

*
*

## Pros and Cons of the Options

### OpenVPN CE

This Is the free and open source version under the OpenVPN Items. All Configuring requires knowledge of Linux and ansible for deployments. Virtually Identical to the paid Access Server version but during a pairing session we discovered that there is no LDAP access. There is a compare sheet provided here (What Are The Main Differences Between OpenVPN Open Source And OpenVPN Access Server? | OpenVPN)

* Good, once configurations are complete deploying can be easy
* Bad, Having to keep a deploy script up-to-Date
* Bad, With a lack of documentation confusion can accrue

### OpenVPN Access Server

This is the paid version of OpenVPN. The biggest difference between this versus the free version is the use of a GUI. Using Ansible to make the configurations can still be used but creating users, Turning on MFA is easier. Through AWSMarketplace all billing will be done through AWS. With 10 Connected devices at a time it is estimated to cost roughly $700 per year.

Additionally there is a BYOL (bring your own license) model. This will be the cheaper option of the two but making changes to the instance like imaging and relaunching it, or changing the instance type, or enabling auto-scaling, will result in the license key becoming invalid, requiring you to contact us for support on this. The price for this will be $720 per year for the licenses and the cost of the EC2 instance

* Good, because GUI will allow adding users easily
* Good, Configurations can be down Via CLI or GUI interface
* Bad, because depending on the model we choose can limit how much we can automate without interruptions.


### AWS VPN

there are two version of AWS VP site to site and client VPN. We would be using client VPN to connect. AWS VPN does use an OpenVPN protocol.
