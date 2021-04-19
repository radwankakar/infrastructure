# DevOps Strategy

Last updated by Eady on April 19, 2021

This is a living document. We will review and update this strategy every other month.

We will take into account any user feedback along the way.

## Context

DevOps is a philosophy.
In order to deliver high quality secure software consistently...

Software development is a creative process and thus may take variable time to produce.
However, the process of testing and deploying that software should be consistent and predictable much like an assembly line in a factory.

Key features of a DevOps enabled workflow are:

* Flow - ease of delivery of development work to our customers
* Feedback - ability to understand changes to a system and if there is a defect to correct
* Continual Learning and experimentation - safely sharing well thought through hypotheses in our system

This team aims to create a platform to allow enable DevOps workflows for development teams.

## I. Get Daily Operations Under Control and Automated

The first step in automating a process is thorough documentation.
This team has received well documented processes from the incumbent contractor so we'll start there.

We will automate existing operations to the best of our ability with an eye towards allowing development teams to run the automation themselves.
We will be demoing and sharing all work with application development teams to see if we have produced tooling they can use on Dev/Staging environments.

Additionally, we would like to shadow development teams to understand their existing workflows and how to best integrate our work.

### Goals

* Automate as much as we can
  * Immutable infrastructure
  * Usability
* Prepare compliance and security workflows for automation
* Increase visibility for customers and stakeholders

### Possible workstreams

* Automate common tasks
  * Database dumps for development teams
* Create dashboards to answer questions about system status
* Migrate existing resources into infrastructure as code
  * Implement Terraform/Atlantis and share config with dev teams
  * Start abstractions into modules
* Work with dev teams to provide immutable artifacts to better facilitate automated deployment
* Review AWS Billing and usage
  * Automate dashboards
* ATO prep
* Decrease Operational Overhead
  * Migrate mail services to SES
  * Migrate MariaDB to RDS
  * Migrate all caching configuration into Cloudfront
  * Is there a better way to allow access to dev/staging to developers?

## II. Enablement

Enabling developers to better work ...

Enabling them to make better decisions and understand system ramifications

### Goals

* Make it easy to change and deploy applications
* Make it easy to stand up new services
* Enable development teams debug access
* Enable development teams to automate testing
* Empower development teams to develop applications with confidence

### Open questions

* What is the change request process today?
  * How can we make this easier for developers to submit and review changes?
* What are common architecture patterns that we host?
  * Can we give developers templates to start with?
  * Can we provide configuration and services for common actions?
* What information do developers need to debug and manage their systems?
* What access do developers need to debug and manage their systems?
* What are things developers want control of?
* What are thing developers don't want control of?
* Should we allow for multi cloud management?
* If we stay in AWS, should we allow each developer isolated environments?
* How can we maintain visibility into all systems for our CORs and stakeholders?

### Possible Workstreams

* Zero downtime deployments
* Isolated environments
  * Temporary demo and test environments
* Proof of concept or template repositories for new applications
* Centralized Identity management
  * IT systems access
  * CAS integration and stability improvements
* Other centralized services
  * How to configure SES
  * How to manage a database
  * How to share data across services
