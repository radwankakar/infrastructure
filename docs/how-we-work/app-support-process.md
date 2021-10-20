# Application Team Support Process

## Background
The OHS Hosting team and the application teams it supports interact with each other in various ways. There is a need for documentation to describe the process that the application teams should follow depending on the need.

## Process
First, determine what type of communication is it?
1. [Is it some information you need to convey to the hosting team?](#information)
1. [Do you have a question about something that's not a ticket already?](#question)
1. [Do you have a request for a change to the infrastructure or configuration?](#change-request)
1. [Do you want to report a problem with the infrastructure causing an outage or other problem for you or your end users?](#problem)

### Information
* For communicating a Change Notice or Release Announcement related to a deployment to production, email Sanjay and Eady
* For communicating anything else, send email to the hosting team at headstart-hosting@truss.works if you're not sure who to communicate with, otherwise email the individual(s) needed

### Question
* For a question regarding timelines or communication, email Sanjay
* For a technical question, email headstart-hosting@truss.works

### Change Request
For something you need done by the hosting team that is not a bug with the infrastructure, please create a ticket in [JIRA](https://ocio-jira.acf.hhs.gov/secure/CreateIssue!default.jspa).

#### Ticket template
* **Project**: OHS Hosting (OHSH)
* **Issue Type**:
   * If it's a change that doesn't result in any impact on either developers or end users, create a Task
   * If it's a change that does have an impact on developers or end users, create a Story
* **Summary**: One line summary of what you are requesting
* **Component**: Infra
* **Description**:
   * **Application Name**: Name of application that is impacted by this change (ECLKC, IPD, HS CC, EEC, a mobile app?)
   * **Purpose**: Why are you requesting this change? or What is the problem or need you are trying to solve with this request? or What is the outcome you would like once this change is completed?
   * **Description of this Change**: Detailed information about the change being requested. Include as much information as available here, including any technical constraints to be aware of, etc.
      * If applicable:
         * _Is this change a configuration change or a software change?_
         * _Does this change require data schema migrations?_
         * _Does this change fix a security vulnerability?_
         * _What is the expected outcome and behavior?_
   * **User Impact**: Who does this impact? (i.e. Developers, application administrators, application end users)
   * **Timeline**: Is there a deadline or any other timing considerations for this change? And if so, what is it and why?
   * **Acceptance Criteria**:
      - [ ] Acceptance Criteria 1
      - [ ] ...
* **ENV**: Dev, Stage, and/or Prod

### Problem
Use the workflow documented in the [support process document](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/4e98bf8f9767f57cc2dcbfdef29d285634d77c56/docs/how-we-work/support-process.md#reporting-an-issue)
