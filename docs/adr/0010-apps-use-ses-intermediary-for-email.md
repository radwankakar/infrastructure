# Apps use SES intermediary for email

<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

- Status: proposed
- Deciders: OHS Hosting, Alana...?
- Date: 2021-12-16

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Apps use SES intermediary for email](#apps-use-ses-intermediary-for-email)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
    - [About integrating with Ironport](#about-integrating-with-ironport)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Applications directly use Ironport to send emails](#applications-directly-use-ironport-to-send-emails)
    - [Applications send emails through SES as an intermediary to Ironport](#applications-send-emails-through-ses-as-an-intermediary-to-ironport)
    - [Applications send emails through a SMTP server that OHS Hosting maintains](#applications-send-emails-through-a-smtp-server-that-ohs-hosting-maintains)

<!-- mdformat-toc end -->

## Context and Problem Statement

OHS has a variety of internally developed applications.
Many of these applications send emails and some receive and process emails.

HHS policy states that these applications should be performing email communications using hhs.gov email addresses.
Furthermore, anything sent or received by such an email address must pass through the Ironport application for scanning.

Knowing that teams will need to request email addresses and integrate with Ironport, should the applications directly integrate with Ironport or should applications integrate with an intermediary such as SES?

### About integrating with Ironport

OHS does not have a clear guidance for an application to request an hhs.gov email address and how to integrate their application with Ironport.

The process to make these requests is undocumented and requires access to a ticketing system that not all teams can have access to.

Each connection to Ironport must be configured as an SMTP relay with the Ironport appliance.

## Decision Drivers <!-- optional -->

- Emails from apps hosted on an hhs.gov domain should send emails from an official hhs.gov address.
- All of these emails should be verified through industry standards.
  - DKIM (DomainKeys Identified Mail)
  - SPF (Sender Policy Framework)
- There will be multiple applications owned by OHS that send/receive email from both AWS and cloud.gov.
- Ideally, assuming the principle of least priviledge: each OHS application should only have the ability to send and receive emails associated with their application.
- How easy is it for an application development team to request and implement email addresses?
- Can we automate the request and management processes? How easy is it to make changes?
- Can these apps safely retain the email records for future use or audit?

## Considered Options

- Applications directly use Ironport to send emails
- Applications send emails through SES as an intermediary to Ironport
- Applications send emails through a SMTP server that OHS Hosting maintains

## Decision Outcome

Chosen option: Applications directly use Ironport to send emails

## Pros and Cons of the Options <!-- optional -->

### Applications directly use Ironport to send emails

Applications would directly send and recieve emails via SMTP through Ironport.

The OHS team will help define the process and document this to make it easier for teams to perform in the future.

- Good, because the app teams get to work directly(ish) with the team that manages Ironport and email.
- Good, because the apps get all of the benefits of using Ironport.
  - The central HHS team can manage all of the DKIM and SPF records.
  - The Ironport application performs the DKIM signing and manages the email reputation scores for all of the domain.
  - The Ironport application provides spam email filtering and virus scanning.
  - It's up to HHS to manage who has access to which email address.
- Good, because app teams can configure their email any way they want with Ironport.
- Good, because the app just sends email via SMTP (a very common and usually built-in protocol).
- Eh?, because depending on how applications are supposed to authenticate to Ironport, it may be harder to limit app by app access to email addresses.
- Bad, because HHS’ Ironport appliance will have to register each new application as a relay server and whitelist it.
- Bad, because apps might have changing ip addresses across a pool of specified ip addresses.
  - Cloud.gov hosted applications do not have static ip addresses that they communicate on. However, there is a specific range these might come through. We could have the Ironport team register the whole ip range but then ANY cloud.gov application (even ones that may not be OHS) can send as one of our applications.
- Bad, because each application will have to do the same setup with the appropriate teams to get the correct configuration.
  - Extra hard because dev teams don’t automatically have access to the platform the Ironport team uses for ticketing. (More room for miscommunication in requests.)

### Applications send emails through SES as an intermediary to Ironport

The OHS hosting team would configure s3 buckets and SES emails such that each application has unique storage and sending capabilities.
We would limit access by leveraging AWS IAM api keys.
This would allow the OHS hosting team to give access to application specific resources and makes it easier to update access.

- Good, because there is a single team point of contact on OHS to manage email configuration for apps.
  - The team can coordinate who is using which email address.
  - The team can give tailored guidance and instruction for setup.
- Good, because OHS Hosting can define the configuration as code and can be audited.
- Good, because OHS Hosting can set SES to send all emails to s3 buckets and limit access to those for archival reasons.
- Good, because the OHS Hosting team can limit access to email addresses apps can send from.
- Good, because the apps don't need to use up disk space to store emails or run individual SMTP servers to manage email.
- Good, because the apps still get the benefits of using Ironport if we can configure this the correct way.
  - The central HHS team can manage all of the DKIM and SPF records.
  - The Ironport application performs the DKIM signing and manages the email reputation scores for all of the domain.
  - The Ironport application provides spam email filtering and virus scanning.
- Bad, because this puts OHS hosting on the hook for managing access to email resources.
- Bad, because configuration to receive emails is still a coordinated manual process (until we automate it).
- Bad, because it is still not self service to create new email addresses with Ironport.
  - The process seems to be that we work with Ironport to do the initial setup of the email and then verify the email address through SES in order to send. Then SES sends on behalf of the email address which obviates the DKIM stamping.
- Bad, because extra $25/mo to have a static ip address.
- Bad, because current send rates of applications are really low (\<1 message/minute on average) so AWS doesn’t think this is cost effective.
- Bad, because if the apps don't already have a way to use AWS apis they have some work to do so.

### Applications send emails through a SMTP server that OHS Hosting maintains

The OHS hosting team runs an SMTP server to funnel all application emails through.

Note, that running a mailserver is notoriously painful.

- Good, because apps can still use SMTP to get emails.
- Good, because there is a single team point of contact on OHS to manage email configuration for apps.
  - The team can coordinate who is using which email address.
  - The team can give tailored guidance and instruction for setup.
- Good, because the apps get all of the benefits of using Ironport.
  - The central HHS team can manage all of the DKIM and SPF records.
  - The Ironport application performs the DKIM signing and manages the email reputation scores for all of the domain.
  - The Ironport application provides spam email filtering and virus scanning.
- Good, because the app just sends email via SMTP (a very common and usually built-in protocol).
- Good, because the OHS Hosting team can limit access to email addresses apps can send from.
- Good, because the apps don't need to use up disk space to store emails or run individual SMTP servers to manage email.
- Bad, because there's configuration for the emails in multiple places.
  - Teams will have to wait for configuration to be completed on the hosting side and Ironport.
- Bad, because then the hosting team runs an email server. (This is a large operational overhead.)
