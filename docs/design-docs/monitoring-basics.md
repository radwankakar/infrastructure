# Monitoring Basics

Design Doc
7/30/2021
Rebecca Kilberg

## Context

Reference ADR 7, [Initial Monitoring Setup](../adr/0007-initial-monitoring-setup.md) for more information about why we are starting with such basic monitoring.

The expectation is to monitor for abnormal behavior on all websites (Coaching Companion, iPD, Early Educator Central, and ECLKC), load balancers, and Route53.

## Route53

We should monitor the Route53 healthchecks for domains of interest. We can use this preexisting [Route53 health check module](https://github.com/trussworks/terraform-aws-route53-health-check) to do so.

## Load Balancers

The [AWS documentation for monitoring load balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html) includes many metrics. Key concerns we can start with include:

- Latency (`TargetResponseTime`)
- 5xx Status Codes (`HTTPCode_ELB_5XX_Count`, `HTTPCode_Target_5XX_Count`)
- 4xx Status Codes (`HTTPCode_ELB_4XX_Count`, `HTTPCode_Target_4XX_Count`)
- Host Health (`HealthyHostCount`, `UnHealthyHostCount`)

## Websites

- **Autoscaling group**: With an autoscaling group, you are able to rely on the LB monitoring for errors and latency and don't have to be concerned if a single host goes down because another will be automatically brought up in its place.
  - [iPD](https://eclkc.ohs.acf.hhs.gov/ipd)
- **No autoscaling group**: Without an autoscaling group, you have to check whether the individual instances themselves are up. We should be using the pre-loaded CPU Utilization and the Status check metrics.
  - [Coaching Companion](https://eclkc.ohs.acf.hhs.gov/cc/)
  - [Early Educator Central](https://earlyeducatorcentral.acf.hhs.gov/)
  - [ECLKC](https://eclkc.ohs.acf.hhs.gov/)
- Latency: We need to determine our latency baseline. To do that, we should be monitoring CloudWatch logs. Since currently the set up does not send all logs to CloudWatch, we should explore setting up the logs to go to Cloudwatch on the host machines. We can then [track latency from there](https://aws.amazon.com/premiumsupport/knowledge-center/vpc-packet-loss-latency-gateway/).
