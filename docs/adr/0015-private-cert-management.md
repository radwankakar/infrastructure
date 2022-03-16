# Deciding on a solution for private certificate management

<!-- Source: https://raw.githubusercontent.com/adr/madr/main/template/adr-template.md -->

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Deciding on a solution for private certificate management](#deciding-on-a-solution-for-private-certificate-management)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Continue manually managing private certs](#continue-manually-managing-private-certs)
    - [Use SSLMate for generating and managing private certs](#use-sslmate-for-generating-and-managing-private-certs)
    - [Use private cert management through AWS](#use-private-cert-management-through-aws)
  - [Links](#links)

<!-- mdformat-toc end -->

## Context and Problem Statement

While working to renew an expired certificate on the iRedMail server, it was highlighted that we don't currently have a good way to generate/manage private certificates. At the moment it seems the kind of management employed differs server by server.

## Decision Drivers

- We need a standardized way to be alerted when new private certs need to be generated.
- We need a standardized way for generating new certs when needed.
- Being our own CA, as is the current set up on at least one server, isn't advisable from a availability/security perspective. Such a practice could leave our apps/services open to man in the middle attacks and users could receive warnings when trying to access one of the apps/services all due to us not being considered an trusted CA.
- The solution has to be affordable and provide a reliable way to track/manage our private certificates.
- Preferably the solution will have a low learning curve.

## Considered Options

- Continue manually managing private certs
- Use SSLMate for generating and managing private certs
- Use private cert management through AWS

## Decision Outcome

Use AWS to generate and manage a single root CA, from which we can generate the needed private certificates. Our use of non-qualified domain names limits third-party options, as they do not support this.

## Pros and Cons of the Options

### Continue manually managing private certs

- Good, because it is the current way of operating. Which provides a certain kind of ease/consistency.
- Bad, because it quickly becomes difficult to track when certs are set to expire.
- Bad, because it's difficult to track which certs each app is using and for what at any given time.
- Bad, because maintaining our own CA, or even multiple CAs, isn't advisable.

### Use SSLMate for generating and managing private certs

- Good, because it provides alerting for certificate expiration.
- Good, because it provides alerting if something goes wrong during the renewal process
- Good, because it can automatically renew and install new certificates on to servers.
- Good, because it can automate the entire process of private cert generation.
- Good, because it provides a central location for tracking and managing every private cert we would need.
- Good, because the cost scales by year, rather by month. Starting at $15.95 a year for a single hostname, and $149.95 a year for a wildcard hostname.
- Bad, because it's another tool to add to learn and implement into our process.
- Bad, because we can't use non-qualified hostnames to generate certs.

### Use private cert management through AWS

- Good, because it provides alerting for certificate expiration.
- Good, because it provides alerting if something goes wrong during the renewal process
- Good, because it can automatically renew and install new certificates on to servers.
- Good, because it can automate the entire process of private cert generation.
- Good, because we would be remaining in the AWS ecosystem of products.
- Good, because private cert management would live in the same place we already manage our public certs.
- Good, because we can continue to use our current set of internal hostnames.
- Bad, because starting at $400 a month for each private CA required could become an issue if we grow our use of private CAs.

## Links

- Spun out from [OHSH-478](https://ocio-jira.acf.hhs.gov/browse/OHSH-478)
- [SSLMate pricing](https://sslmate.com/pricing/certificates)
- [SSLMate features](https://sslmate.com/certificates/)
- [AWS private ACM pricing](https://aws.amazon.com/certificate-manager/pricing/)
