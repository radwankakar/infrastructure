# CI Tooling Options

* Status: pending
* Deciders: ssatagopan, kilbergr, eeeady
* Date: [tbd]

Technical Story: [ADR regarding which CI system to use](https://ocio-jira.acf.hhs.gov/browse/OHSH-217)

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers)
* [Considered Options](#considered-options)
    * [Jenkins](#jenkins)
    * [CircleCI](#circleci)
    * [Bamboo](#bamboo)
    * [Github Actions](#github-actions)
* [Pros and Cons](#pros-and-cons)
* [Decision Outcome](#decision-outcome)
* [Links](#links)

## Context and Problem Statement

Currently, there exist no unified tooling or system to handle continuous integration (CI). In order to continue to move forward with plans to create a more streamlined coding ecosystem we have to come to an agreement around which CI tool all dev teams should use going forward.

## Decision Drivers

* Introduce a unified CI solution to the dev teams' coding pipeline

## Considered Options

### Jenkins

* **Cost**
    * Free, but have to pay for the cost of maintaining a server.
* **ATO of Services**
* **Team Familiarity**
* **Usability of Templates**
    * The built in method of "templating" seems to be using a Jenkinsfile that has been committed into source control. Setting up either a pipeline through an imperative or declarative method. However, once multiple teams using various tools, are added to the pipeline things can get a little tricky. As each team would probably end up needing their own Jenkinsfile(s) and therefore bespoke pipelines for each team and/or service.
    * As with most things to do with Jenkins, there's a plugin for its pipeline issues. [Jenkins Templating Engine](https://plugins.jenkins.io/templating-engine/), or JTE, is a Booz Allen Hamilton created and maintained plugin that enables a team to create pipeline templates that are completely language/tool agnostic. Removing the need for a Jenkinsfile on an individual repo level and for each team to need particular Jenkins expertise, keeping the pipeline consistent across teams, and allowing individual teams to inject the tools/libraries that they are most familiar with at the specified step in the pipeline.
* **Ease of AWS (and other) integrations**
    * Jenkins has to live and run on an server, so the recommended best practice to integrate Jenkins into an AWS account is by spinning up a new EC2, or taking an preexisting one, and installing Jenkins. There you can configure Jenkins to however you need.
* **Job Metrics**
    * Jenkins doesn't appear to come with any way to track/receive metrics natively. However, there does seem to be several plugins that serve the purpose of providing job metrics. The most used being, [Metrics](https://plugins.jenkins.io/metrics/).

### CircleCI

* **Cost**
* **ATO of Services**
* **Team Familiarity**
* **Usability of Templates**
* **Ease of AWS (and other) integrations**
* **Job Metrics**

### Bamboo

* **Cost**
* **ATO of Services**
* **Team Familiarity**
* **Usability of Templates**
* **Ease of AWS (and other) integrations**
* **Job Metrics**

### Github Actions

* **Cost**
* **ATO of Services**
* **Team Familiarity**
* **Usability of Templates**
* **Ease of AWS (and other) integrations**
* **Job Metrics**

## Pros and Cons



## Decision Outcome



## Links