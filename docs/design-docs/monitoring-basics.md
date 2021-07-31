# Monitoring Basics

Design Doc  
7/30/2021  
Rebecca Kilberg

## Context

Reference ADR 7, [Initial Monitoring Setup](../adr/0007-initial-monitoring-setup.md) for more information about why we are starting with such basic monitoring.

The expectation is to monitor for abnormal behavior on all websites (Coaching Companion, IPD, and ECLKC), load balancers, and Route53.

## Route53

We should monitor the Route53 healthchecks for domains of interest. We can use this preexisting [Route53 health check module](https://github.com/trussworks/terraform-aws-route53-health-check) to do so.

## Load Balancers

The [AWS documentation for monitoring load balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html) includes many metrics. Key concerns we can start with include:
* Latency (`TargetResponseTime`)
* Rejected Connections (`RejectedConnectionCount`)
* 5xx Status Codes (`HTTPCode_ELB_5XX_Count`, `HTTPCode_Target_5XX_Count`)
* Host Health (`HealthyHostCount`, `UnHealthyHostCount`)

## Websites

* [Coaching Companion](https://eclkc.ohs.acf.hhs.gov/cc/)
* [Early Educator Central](https://earlyeducatorcentral.acf.hhs.gov/)
* [ECLKC](https://eclkc.ohs.acf.hhs.gov/)
* [IPD](https://eclkc.ohs.acf.hhs.gov/ipd)

