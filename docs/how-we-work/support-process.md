# Support Process

This document details how the hosting team supports the system and its users along with the response plan during incidents.

## Table of Contents
* [Reporting an Issue](#reporting-an-issue)
* [Support Response Workflow for Hosting Team](#support-response-workflow-for-hosting-team)
* [Bug Template](#bug-template)
* [Definitions](#definitions)
* [References](#references)

## Reporting an Issue

1. When an issue occurs, there needs to be some minimal assessment as to the impact and urgency of the issue. The reporter also needs to assess whether there was any possibility of PII exposure and if there's a possibility of the issue being security related. Using the [definitions](#definitions) and your assessment, determine the Priority.
1. If it's a P0 or a P1 with possibility of PII exposure:
   1. Send an email to the hosting team's on-call email: [on-call@eclkc.info](mailto:on-call@eclkc.info) with the following information:
   *  Application affected (ECLKC, HS CC, iPD, any mobile apps, EEC)
   *  One line summary of issue
   *  How to reproduce
   *  When did it start
   *  Additional details including any impact on PII
1. For all issues, create a Bug ticket in [JIRA](https://ocio-jira.acf.hhs.gov/secure/CreateIssue!default.jspa) using [template below](#bug-template)
1. The reporter should receive a response within 2 hours during core business hours (12PM - 5PM ET) for non-PII issues. Outside of these hours, response times will depend on the Priority of the issue.

## Support Response Workflow for Hosting Team

### Roles
* Reporter - the person that reported issue
* On Call Responder (OCR) - the person that is responsible for monitoring for new issues and investigation and fixing
* Secondary On Call Responder (SOCR) - the backup team member if assistance is needed or primary OCR is not available
* On Call Communicator (OCC) - the person that is responsible for sending out notifications and updates regarding issue

### Workflow

1. The OCR will monitor PagerDuty, JIRA issues, and the mailbox for new issues
2. Once a new issue is reported
   1. If it was reported as a PagerDuty alert, **_Acknowledge_** if it was an actual alert or **_Resolve_** if it was a test or if you know the cause of the alert and it has been resolved.
   2. If ticket is not already opened in JIRA, open ticket with as much information as provided
4. Assess Priority of issue based on Impact and Urgency
5. If the reported issue is P0 or P1, start a thread in Slack in the #pb-ohs-hsis-vendors channel, link ticket in thread, and do some immediate investigation to assess whether issue is actual and whether there is any possibility of PII exposure and whether this issue is security related. Include your findings in the thread and in the ticket. **_FOR NON-HOSTING TEAM MEMBERS:_** If you don't have access to the Slack channel, do the same with an email chain to headstart-hosting@truss.works.
   1. If the issue doesn't seem actual, send an email response to the reporter with your findings and verify with them that you can close ticket. If issue was reported by monitoring systems and not by a person, raise ticket to address bug in monitoring and **_Resolve_** incident in PagerDuty.
      1. If reporter responds with their acceptance, close ticket with your findings in comments, include in thread, and **_Resolve_** incident in PagerDuty
      2. If reporter responds that they see it as an issue, obtain more information as needed to investigate further, whether over email or a zoom session.
   2. If the issue is:
     * actual AND 
     * there is a possibility of PII exposure OR it could be security related:
    contact OCC (Sanjay) through their primary contact info in the [contact info spreadsheet](https://docs.google.com/spreadsheets/d/1NLuA5hcfV_NjZpxf5hxwMwkhu6qjUcXth01TDsh19cU/edit?usp=sharing).
      1. OCC needs to send a notification via email ⌛ **within 1 hour** to ACF_IRT@acf.hhs.gov, ISSO, System Owner, 18F advisors, Truss CSM, reporter, and app teams, and include:
         1. Headline summary of issue
         2. Description
         3. Possible PII exposure, including possible number of users impacted and what PII could have been exposed
         4. Link to Slack thread
         5. Incident Report Form
      2. OCR continues to troubleshoot issue and fix when root cause is found. As troubleshooting is done, OCR should be logging in Slack thread about what was done and results.
      3. OCC should send an update ⌛ **every hour** to same recipient list as original notification.
      4. If OCR needs assistance with troubleshooting and OCC is not able to help, OCR should **_Escalate_** incident in PagerDuty to secondary On Call Responder.
      5. Once enough information is found to provide an estimate on time to resolution, OCC should provide that estimate in the next update.
      6. Once issue is fixed, OCR should notify reporter to ask for their acceptance of fix. If issue was reported by system monitoring, get confirmation of resolution from another hosting team member before closing and **_Resolve_** ticket in PagerDuty.
         1. If reporter responds with their acceptance, close ticket with your findings in comments, include in Slack thread, and **_Resolve_** incident in PagerDuty. OCC should send a final update with the resolution.
         2. If reporter responds that they still see the issue, obtain more information as needed to investigate further, whether over email or a zoom session. Continue...
   3. If the issue is actual AND there is no possibility of PII exposure AND it is not security related, contact OCC through their primary contact info in the On Call Rotation schedule
      1.  If during core business hours, OCC needs to send an acknowledgement via email ⌛ **within 2 hours** to the reporter, System Owner, 18F advisors, and app teams. If outside core business hours, OCC needs to send an acknowledgement via email ⌛ **within X hours***, X is based on the Priority of the issue. Include in email:
         1. Headline summary of issue
         2. Description
         3. Link to Slack thread
      2. OCR continues to troubleshoot issue and fix when root cause is found. As troubleshooting is done, OCR should be keeping notes about what was done and results.
      3. OCC should send an update ⌛ **every hour** to same recipient list as original notification.
      4. Once enough information is found to provide an estimate on time to resolution, OCC should provide that estimate in the next update.
      5. Once issue is fixed, OCR should notify reporter to ask for their acceptance of fix. If issue was reported by system monitoring, get confirmation of resolution from another hosting team member before closing and **_Resolve_** ticket in PagerDuty.
         1. If reporter responds with their acceptance, close ticket with your findings in comments, include in Slack thread, and **_Resolve_** incident in PagerDuty. OCC should send a final update with the resolution.
         2. If reporter responds that they still see the issue, obtain more information as needed to investigate further, whether over email or a zoom session. Continue...
5. For P0 and P1 issues, once issue is resolved, full team is responsible for constructing a Root Cause Analysis (RCA), using the findings during investigation, troubleshooting, and fixing.
   1. This RCA should be sent to System Owner and 18F advisors
   2. Follow up tickets are created if needed
6. If the issue is P2 or P3,
   1. If it's during core business hours, send an acknowledgement to the reporter within 2 hours
   2. If it's outside core business hours, wait until next business day and send acknowledgement and mention in Slack channel for reference

## Bug Template
* **Project**: OHS Hosting(OHSH)
* **Issue Type**: Bug
* **Summary**: one line summary of problem
* **Component**: Infra
* **Description**:
   * **Application Affected:** (ECLKC, iPD, HS CC, EEC, or mobile app)
   * **Description of Problem:** A clear and concise description of what the issue is. Include any system information that could inform our investigation.
   * **Impact:** Who is affected? (i.e. developers or end users or application admins) How many are affected?
   * **Additional Details:** Anything else that could help the team troubleshoot the issue.
* **Steps to Reproduce**: How can the team reproduce and see the problem?
* **Expected Results**: What should happen?
* **Priority**:
   * P0 or P1 w/ PII exposure = Highest
   * P1 w/o PII exposure = High
   * P2 = Medium
   * P3 = Low
* **Reproducibility**: Always, Frequently, Sometimes, Rarely, or Never
* **ENV**: Prod, Stage, and/or Dev

## Definitions

Impact: the overall effect of an event or incident. This includes the number of affected users and the criticality of the affected system or data. Impact is also used to qualify the effect of reputation loss to the department, agency, or organization

Urgency: combines the time it takes an incident to have a significant impact on business, the criticality of the system under attack, and the sensitivity of the data exposed.

* Impact

Impact | Description
------ | ----------
Extensive | Affects all or most of the system across multiple applications. It has been verified that data was exposed to the public and it was sensitive PII. User data loss affects 500 unique individuals or more.
Significant | Affects large portions of system affecting two or more applications. It has either been verified that data was exposed to the public or has a strong likelihood of being exposed to the public and the exposed data is sensitive PII. User data loss affects 100 unique individuals or more.
Moderate | Affects some of the system and affects at least one application. It has either been verified that data was exposed to the public or has a strong likelihood of being exposed to the public and the exposed data is PII. User data loss affects 50 unique individuals or more.
Minor | Affecting some of the system. It has either been verified that data was exposed to the public or has a strong likelihood of being exposed to the public and the exposed data may contain data that is PII. User data loss affects less than 50 unique individuals.

* Urgency

Urgency | Description
------- | -----------
Severe | Affects critical systems or high-value applications or resulting in a complete work stoppage. With data exposure, the data exposed is sensitive PII.
High | Affects core support systems or high-value applications or resulting in a significant impact to business operations. With data exposure, the data exposed is sensitive PII.
Medium | Affects systems or applications resulting in a moderate impact to business operations, but a workaround exists. With data exposure, the data exposed is PII.
Low | Little to no impact to business operations. With data exposure, the data exposed is not PII.

* Personally Identifiable Information (PII)

PII | Description
--- | -----------
Sensitive | Sensitive information such as medical, financial, or legal information
Not-Sensitive PII | "Neutral" information, such as name, facial photos, or work address
Not PII | Information that does not refer to any specific user

* Priority

Impact/Urgency | Extensive | Significant | Moderate | Minor
-------------- | --------- | ----------- | -------- | -----
Severe | P0 | P0 | P1 | P2
High | P1 | P1 | P2 | P3
Moderate | P2 | P2 | P3 | P3
Low | P3 | P3 | P3 | P3

* Times

Priority | Response Time (hours)<sup>*</sup> | Resolution Time (hours)
-------- | --------------------- | -----------------------
P0 | 4 (1 with PII) | 16
P1 | 8 (1 with PII) | 24
P2 | 16 | 40
P3 | 24 | 56 to 72

_* - within Core businss hours of 12pm ET - 5PM ET Monday through Friday, acknowledgement should be sent within 2 hours_

## References
1. [Incident Response Plan](https://acf-headstart.box.com/s/qvvzav6qy6swy7i6dj5a6125uw8ws29q)
2. [QASP](https://acf-headstart.box.com/s/tq9p7rr1a4ext8k1ai0ic22zxkpak1xo)
3. [PII](https://www.hhs.gov/web/policies-and-standards/hhs-web-policies/privacy/index.html#what-is-pii)
4. [On Call Rotation](https://github.com/OHS-Hosting-Infrastructure/infrastructure/tree/main/docs/how-we-work/on-call-rotation.md)
5. [Response Workflow Diagram](https://drive.google.com/file/d/1Trx0TCZjoTdrObiZ2cE1RK7jguIC9y8f/view?usp=sharing)
