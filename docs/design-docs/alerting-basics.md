# Alerting Basics

Design Doc
8/13/2021
Rebecca Kilberg

## Context

Reference ADR 7, [Initial Monitoring Setup](../adr/0007-initial-monitoring-setup.md) for more information about why we are starting with such basic alerting.

Reference [Monitoring Basics design doc](monitoring-basics.md) for more information about what metrics we will be alerting on.

The expectation is to send alerts once monitors are set up via SMS  to whoever is on call.

## Alerts vs Notifications

We should be differentiating between notifications and alerts.

Alerts are for issues that require immediate action or investigation. Notifications are informational. We will be using alerts for all of the monitors mentioned in the [Monitoring Basics design doc](monitoring-basics.md). In the future, we will likely implement notifications for events such as failing builds in lower environments or approaching credential expiration.

## Costs

Currently we believe the most effective way to alert team members is via SMS.

If we decide to use AWS directly, [this price sheet](https://aws.amazon.com/sns/sms-pricing/) describes costs per SMS for the US. We'll have to use [short codes, 10 digit number (10DLC), or a toll free number](https://docs.aws.amazon.com/sns/latest/dg/channels-sms-us-requirements.html) to reach phones in the US, where all team members are located.

Typically, we've integrated with another service such as PagerDuty, which does have a [free tier](https://www.pagerduty.com/sign-up-free/?type=free). I think it's worth considering whether it would be easier to set up subscriptions to our SNS topics with PagerDuty rather than to first set up with 10DLC or a toll free number (the short codes cost $650 to request and almost $1k per month to maintain).

## Usage

We will be using per-app team alert topics from SNS to indicate the source of the alert. However, all alerts will go directly to the Truss infrasec team member who is on call.

Part of the rationale of setting up PagerDuty rather than just creating subscriptions to individual phone numbers via AWS SNS is that we would have to rotate these numbers every week, since they don't appear to have a scheduled rotation option.

## PagerDuty

To configure PagerDuty, we would have a separate stack outside of the `AWS` stacks in the [Environment Configuration](https://github.com/OHS-Hosting-Infrastructure/environment-configuration) repo. We could organize our work under a single ["Service"](https://support.pagerduty.com/docs/services-and-integrations) since although we are monitoring different sites, all alerts will go to the same team. We would add members of the Truss hosting team to a schedule that would automatically rotate in PagerDuty. Initially we would simply create SMS alerts directly to the team member on call, but ultimately we could implement the Slack-PagerDuty integration that creates an alert or notification within Slack and a page.

We could rely on the [Truss External Integrations Guide](https://github.com/trussworks/Engineering-Playbook/blob/main/infrasec/aws/sns-guardduty-alert-integrations.md) to help describe how best to approach this, although initially we wouldn't be using GuardDuty.
