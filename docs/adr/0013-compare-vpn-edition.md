# Compare OpenVPN CE, OpenVPN Access Server, and AWS VPN
<!-- Source: https://raw.githubusercontent.com/adr/madr/main/template/adr-template.md -->

* Status: proposed by Mondo
* Deciders: Reid, Rebecca, Ryan
* date: 02-22-2022

Technical Story: [OHSH-473](https://ocio-jira.acf.hhs.gov/browse/OHSH-473)

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

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


## Context and Problem Statement

We currently are using OpenVPN for the VPN for OHS. We believe it's the community edition, which is free, but they also offer Access Server which costs money per concurrently connected user. Additionally, AWS offers a VPN we could potentially deploy and use instead as well.

Additionally we are trying to find ways to lessen toil and make it easier for the hosting team to manage users.

## Decision Drivers

* Cost
* user provisioning, Adding and managing users

## Considered Options

* OpenVPN CE
* OpenVPN Access Server
* AWS VPN

## Decision Outcome

Chosen option: OpenVPN Access Server, Would be our best option going forward. the GUI will allow the hosting team manage users easily. Switching to Access Serve will have the least amount of down time to deploy and depending on what model is chosen changing the instance or image will result in little downtime.

### Positive Consequences

* Little to no downtime in switching.
* we can still use the config file from the VPN we currently use

### Negative Consequences

* depending on the model type redeploying will require contacting OpenVPN to get a new access key
*

## Pros and Cons of the Options

### OpenVPN CE

This is the free and open source version under the OpenVPN Items. All configuring requires knowledge of Linux and Ansible for deployments. Virtually identical to the paid Access Server version but during a pairing session we discovered that there is no LDAP access. There is a compare sheet provided here [What Are The Main Differences Between OpenVPN Open Source And OpenVPN Access Server? | OpenVPN](https://openvpn.net/faq/what-are-the-main-differences-between-openvpn-open-source-and-openvpn-access-server/)

* Good, once configurations are complete deploying can be easy
* Bad, because we must maintain deploy scripts
* Bad, there is no Support from OpenVPN directly, there are a few HOWTO guides to get started but most troubleshooting is through Wiki

### OpenVPN Access Server

This is the paid version of OpenVPN. The biggest difference between this versus the free version is the use of a GUI. Using Ansible to make the configurations can still be used but creating users, Turning on MFA is easier. Through AWSMarketplace all billing will be done through AWS. With 10 Connected devices at a time it is estimated to cost roughly $700 per year.

Additionally there is a BYOL (bring your own license) model. This will be the cheaper option of the two but making changes to the instance like imaging and relaunching it, or changing the instance type, or enabling auto-scaling, will result in the license key becoming invalid, requiring you to contact us for support on this. The price for this will be $720 per year for the licenses and the cost of the EC2 instance

* Good, because GUI will allow adding users easily
* Good, Configurations can be down Via CLI or GUI interface
* Bad, because depending on the model we choose can limit how much we can automate without interruptions.


### AWS VPN

From my initial research This VPN option seems confusing. It would take the hosting team some time to learn a new VPN system. All Users will need to be re-added and download a new VPN client software. A factor that I have found is AWS VPN is not FIPS compliant and knowing this is government work that might have an impact on what we can do.

* good, everything stays within AWS
* Bad, Having to learn a new VPN
* bad, adding and managing new users
