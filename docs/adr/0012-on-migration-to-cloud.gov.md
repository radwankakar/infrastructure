# On whether to migrate hosted OHS apps to cloud.gov or not

- Status: proposed
- Deciders: Rebecca Kilberg, Sanjay Satagopan, Reid Lewis
- Date: 2022-02-09

Technical Story: [OHSH-229](https://ocio-jira.acf.hhs.gov/browse/OHSH-229)

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences)
  * [Negative Consequences](#negative-consequences)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options)
  * [Build our own self-managed, comprehensive solution in AWS](#build-our-own-self-managed-comprehensive-solution-in-aws)
  * [Migrate everything to cloud.gov all at once](#migrate-everything-to-cloudgov-all-at-once)
  * [Migrate one app to cloud.gov](#migrate-one-app-to-cloudgov)
  * [Adapt the hosted apps to make ready for cloud.gov, then migrate everything](#adapt-the-hosted-apps-to-make-ready-for-cloudgov-then-migrate-everything)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

App dev teams at OHS face several challenges with the infrastructure that suppports
their applications. These include:

- Inadequate visibility into their applications for investigating problems.
- Friction with security requirements that inhibit needed access to application
  architecture within OHS' hosting platform.
- Fragile architecture creates more risk when making changes, which is being managed
  with manual toil. This leads to a general aversion to change and low confidence in app
  resiliency to user demand and malicious activity.
- Differences in the infrastructure between dev/stage and prod environments limits
  our ability to find problems with new versions of an application before it is deployed
  to production.

In turn, this presents difficulties for the hosting team:

- Infrastructure engineers with access must act as technical go-betweens for application
  engineers who know what needs doing but don't have access.

## Decision Drivers

- We want to reduce the dependency of the app teams on the hosting team, to give
  them autonomy and to allow us to focus on our broad strategy goals.
- App teams need access to infrastructure on an as-needed basis consistent with
  the principle of least privilege.
- There is a substantial flat cost for using cloud.gov.
- The project has a limited budget for infrastructure costs.
- We need to maintain the stability of the applications in production during
  infrastructure level transitions.

## Considered Options

- Build our own self-managed, comprehensive solution in AWS
- Migrate everything to cloud.gov all at once
- Migrate one app to cloud.gov
- Adapt the hosted apps to make ready for cloud.gov, then migrate everything

## Decision Outcome

Wait until the hosted apps are ready for cloud.gov, then migrate everything, because
this is the only option that meets decision drivers around transition stability and
budget constraints.

### Positive Consequences

- We have a clear milestone to work toward that motivates needed modernization
  work in the hosted apps.

### Negative Consequences

- In the short term, we are limited to making relatively marginal improvements
  to existing architecture.
- Cloud.gov does not have some important services: e.g. email (AWS SES). We will
  have to build the brokerage for those features on our own.

## Pros and Cons of the Options

### Build our own self-managed, comprehensive solution in AWS

- Good, because we can design a made-to-order solution according to our specific
  requirements.
- Good, because we have direct control over how all the AWS services are integrated.
- Good, because we have access to more AWS services in general.
- Bad, because we have inadequate engineering bandwidth to put everything together
  and get improvements rolled out to our users within an acceptable time frame.
- Bad, because if we did get everything put together, maintaining it going forward
  would require more engineering time than we will have available.

### Migrate everything to cloud.gov all at once

- Good, because this is the shortest path to solving all the problems described in the
  context and problem statement.
- Bad, because cloud.gov requires containerization, and several hosted apps are currently
  in states that cannot run on a containerized platform. Adapting them all for containerization
  would be an extremely heavy lift, requiring the app dev teams to drop all their active
  priorities simultaneously.
- Bad, because the overall architecture of the hosted apps is fragile and has many unknowns.
  If one service becomes inaccessible or unresponsive, many hosted apps may be impacted,
  and that impact is sometimes difficult to predict. Therefore, a shotgun migration carries
  unacceptable risk of a major unplanned outage.

### Migrate one app to cloud.gov

- Good, because we can test cloud.gov with a smaller slice of the architecture
  as a proof of concept.
- Good, because our [research][1] suggests that we have at least one app (Coaching Companion)
  that is close to ready for migration.
- Bad, because there is a substantial flat cost for using cloud.gov, and we have decided that
  having only one app there is not a worthwhile use of the current budget.

### Adapt the hosted apps to make ready for cloud.gov, then migrate everything

- Good, because modernizing the hosted applications in preparation for a possible migration
  to cloud.gov is in alignment with our overall strategy using [12 Factor architecture][2].
- Good, because we can gradually improve the architecture before making the most risky
  and difficult changes.
- Bad, because cloud.gov does not support some AWS services we want, such as SES for email.

[1]: https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/research/applications/cc-cloudgov.md
[2]: https://12factor.net/
