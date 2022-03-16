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

<!-- mdformat-toc end -->


## Context and Problem Statement

We don't have a thorough understanding of our current VPN deployment (which we believe is OpenVPN CE), we do not have any of the configuration in code for easy redeployment, and provisioning of users is a very manual task and lacks MFA for additional security. We are planning to improve this, but want to evaluate in this process if OpenVPN CE still makes the most sense for this project before we invest more time. Specifically we want to evaluate OpenVPN CE, OpenVPN AS, and AWS VPN.

Ultimately we are trying to find ways to lessen toil and make it easier for the hosting team to manage the VPN.

## Decision Drivers

* Cost
* User provisioning, adding and managing users
* Security authorization
* Official vendors support
* Maintenance burdens
* Automation ability


## Considered Options

* OpenVPN CE
* OpenVPN Access Server
* AWS VPN

## Decision Outcome

Chosen option: OpenVPN Access Server, Would be our best option going forward. the GUI will allow the hosting team manage users easily. Switching to Access Server will have the least amount of down time to deploy and depending on what model is chosen changing the instance or image will result in little downtime.

### Positive Consequences

* Little to no downtime in switching.
* We can still use the config file from the VPN we currently use

### Negative Consequences

* Depending on the model type redeploying will require contacting OpenVPN to get a new access key


## Pros and Cons of the Options

### OpenVPN CE

This is the free and open source version under the OpenVPN Items. All configuring requires knowledge of Linux and Ansible for deployments. Virtually identical to the paid Access Server version but during a pairing session we discovered that there is no LDAP access. There is a compare sheet provided here [What Are The Main Differences Between OpenVPN Open Source And OpenVPN Access Server? | OpenVPN](https://openvpn.net/faq/what-are-the-main-differences-between-openvpn-open-source-and-openvpn-access-server/)

* Good, once configurations are complete deploying can be easy
* Bad, because we must maintain deploy scripts
* Bad, because there is no support from OpenVPN directly. There are a few HOWTO guides to get started, but most troubleshooting is through a wiki

### OpenVPN Access Server

This is the paid version of OpenVPN. The biggest difference between this versus the free version is the use of a GUI. Using Ansible to make the configurations can still be used but creating users, Turning on MFA is easier. Through AWSMarketplace all billing will be done through AWS. With 10 Connected devices at a time it is estimated to cost roughly $700 per year.

Additionally there is a BYOL (bring your own license) model. This will be the cheaper option of the two but making changes to the instance like imaging and relaunching it, or changing the instance type, or enabling auto-scaling, will result in the license key becoming invalid, requiring us to contact support on this. The price for this will be $720 per year for the licenses and the cost of the EC2 instance

* Good, because user management is simplified with additional security authorization
* Good, because billing stays within AWS
  * This is dependent on model type
* Good, Backups can be created allowing for minimal downtime
* Good, Configurations can be done Via CLI or GUI interface
* Bad, because depending on the model we choose can limit how much we can automate without interruptions.


### AWS VPN

From my initial research this VPN option seems confusing. it is unclear on how complex this can be. It would take the hosting team some time to learn a new VPN system. All users will need to be re-added and download a new VPN client software. A factor that I have found is AWS VPN is not FIPS compliant and knowing this is government work that might have an impact on what we can do.

* Good, because everything stays within AWS
* Good, because it can integrate with Active Directory or Federated Auth / SAML
* Good, because it offers MFA option
* Bad, more complex user management
  * [note] can we use existing "LDAP" server? Would we need to spin up new Active Directory in AWS?
  * [note] follow-up with Rebecca / Dodger to try to get more info on existing LDAP server
  * [note] unclear if we used Active Directory / LDAP if all users would then have to exist in those systems for access (likely yes). does it make sense to require everyone in LDAP to allow access to the VPN? would this then require users to first have LDAP access before VPN access, and is that compatible with the current process (i.e. everyone with VPN access already has LDAP?)
* Bad, because the hosting team is unfamiliar and would have to learn the new system
* Bad, because more complex migration for users and different connection model adds user burden
* Bad, because AWS VPN is not FIPS compliant, which could impact our ATO
* Bad, because it has a complex pricing model based entirely on per hour usage
