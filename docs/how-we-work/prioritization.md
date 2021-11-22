# Prioritization

## Background
We would like to be transparent with our client and application teams on how we decide what we work on. Therefore, we need to document the methods by which we prioritize our work, whether it's feature development, i.e. adding new functionality, or issues.
We will answer the following questions:
* What method will we use to prioritize new development?
* What scale will be run this prioritization on?
* How often will we review and adjust priorities for new development?
* What method will we use to prioritize issues?
* Once prioritization is complete, how will we schedule it into our work stream?

## New development
The team discussed several methods, including [WSJF](https://www.scaledagileframework.com/wsjf/), [Weighted Scoring](https://www.productplan.com/glossary/weighted-scoring/), Impact/Urgency vs Effort, and [RICE](https://www.productplan.com/glossary/rice-scoring-model/). After discussion, the team selected **Impact/Urgency vs. Effort**. Essentially a comparison of Impact and Urgency together against the Effort involved in completing the work.
### Description
The Impact and Urgency vs Effort prioritization method is essentially a simplified form of the WSJF method above. The team will put together a list of the items to be discussed. These items will typically be gathered on an ongoing basis by the Product Manager along with the team themselves based on input from the application teams, the system owner, hosting team, strategic discussions, etc.
* The list will be constructed at an epic or large story level. It will not include all work to be done as the details at that level may not be available at the time of prioritization.
* It will also not include issues or ongoing maintenance work.
* We will conduct prioritization at the minimum of _once a quarter_, but will shoot for **once a month**
#### Prioritization Exercise
* Once the list is selected to prioritize, the team will vote on points per item for Impact, Urgency, and Effort, **doing one column at a time**.
* The points will be using a Fibonnaci sequence of 1, 2, 3, 5, 8, 13, 20
* There must be at least one item with a vote of "1" per column.
* Definition of Impact: What is the impact of this change in terms of the outcome delivered? Could incorporate number of users affected as well as change delivered to their experience or capabilities. Could also include alignment with overall strategy.
* Definition of Urgency: How does the user/business value decay over time? Is there a fixed deadline? Will they wait for us or move to another solution? Are there Milestones on the critical path impacted by this? What is the current effect on customer satisfaction?
* Definition of Effort: Estimate of how long or how big the item is relative to other items being estimated. Dependencies will be considered as part of this estimate. _Sunk costs will be ignored, meaning that any work already done is not included in these estimates._
* Once voting is complete, score is computed with (Impact + Urgency ) / Effort
* Items are placed in order of score from High to Low
### Post Prioritization
* The results of the prioritization exercise will drive what items the team grooms and then pulls into their workstream in order of the higher level priority
* This doesn't mean that activity will always be only one item at a time. Depending on team capacity and the nature of the work involved, we may be able to include more than one item in the workstream.

## Issues
There are two types of issues that need two different prioritization methods. One is an Incident, meaning an outage or security issue, that requires immediate attention. The other is an issue with functionality that may or may not require immediate attention.
### Incidents
* All incidents will be prioritized according to the method listed in the [Incident Response Plan](https://acf-headstart.box.com/s/qvvzav6qy6swy7i6dj5a6125uw8ws29q) and the [support process](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/how-we-work/support-process.md#support-response-workflow-for-hosting-team).
* They will be pulled into the current or next sprint based on the determined priority of the issue and where the team is in the current sprint.
### Non-Incidents
* For issues that are not a security issue or an outage, the following prioritization method will be used:
#### Prioritization Method
* The initial prioritization will be done by the reporter of the issue. However, the hosting team may reprioritize based on questions we have about the issue.
1. Assess Severity of the issue using multiple factors. Could include number of application users impacted, whether it's an important workflow for the application user, whether there is a workaround, whether there is heightened visibility due to any external events, i.e. a launch of new functionality or offering.
   | Severity | Definition |
   | -------- | ---------- |
   | Sev1 | A critical issue with very high impact. This could include data loss, a security breach, or when a client-facing service is down for all users. No workaround available. Typicall would fall into the Incident category above.|
   | Sev2 | A major issue with significant impact, including when a client-facing service is down for a sub-set of users or a critical function within a system is not functioning. No workaround available. Brings large volume of support requests to application teams. |
   | Sev3 | A minor issue with low impact, such as a system glitch that is causing users slight inconvenience or a major issue with a workaround. |
   | Sev4 | A minor issue that impacts usability but doesn’t bring it to a halt or a minor issue with an available workaround. For example: Slower-than-average load times.|
   | Sev5| An issue that doesn't impact usability.|
1. Assess Likelihood of the issue, i.e. how often would this happen to an application user?
   | Likelihood of Occurrence | Definition |
   | ------------------------ | ---------- |
   | Always | Happens every time |
   | Frequently | More often than not |
   | Sometimes | Intermittent |
   | Rarely | Almost never would happen |
1. Calculate Priority based on the two factors:
   | Severity/Likelihood | Sev1 | Sev2 | Sev3 | Sev4 | Sev5 |
   | ------------------- | ---- | ---- | ---- | ---- | ---- |
   | Always | Incident | P1 | P2 | P3 | P4 |
   | Frequently | Incident | P1 | P2 | P3 | P4 |
   | Sometimes | Incident | P1 | P2 | P3 | P4 |
   | Rarely | P1 | P2 | P3 | P4 | P4 |
#### Post Prioritization
* Issues will be groomed during the hosting team's weekly grooming session and be reprioritized ahead of the sprint planning session (currently every two weeks).
* Issues will be scheduled into the hosting team's work stream with the following rules:
  | Priority | Schedule |
  | -------- | -------- |
  | P0 | Pull into current sprint |
  | P1 | Pull into current sprint |
  | P2 | Plan for next sprint |
  | P3 | PM's discretion |
  | P4 | PM's discretion |
## Iteration
This prioritization is an iterative process and the team may change methods based on feedback and the outcomes that are being delivered.
