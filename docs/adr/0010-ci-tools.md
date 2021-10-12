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
    * There’s [3 price levels](https://circleci.com/pricing/#compute-options-table), with each level allocating a number of credits that are used to pay for a team’s usage based on machine type and size. As well as a series of premium features such as, Docker layer caching:
        * Free, 2,500 credits/week
        * Performance, starting at $30 a month. 25,000 credits/month for the first 3 users, 25,000 credits/month for each additional user.
        * Scale, have to talk to CircleCI representative to get pricing
* **ATO of Services**
* **Team Familiarity**
* **Usability of Templates**
    * CircleCI uses a `config.yml` file that lives in the top-level `.circleci` directory of the repo to provide a job/pipeline template. CircleCI also offers the capability to use [dynamic configuration](https://circleci.com/docs/2.0/dynamic-config/), providing a way to generate configuration when needed rather than manually creating them every time.
* **Ease of AWS (and other) integrations**
    * CircleCI has two options for integrating with AWS.
        * Orbs: By using orbs teams can quickly, and with minimum effort, make deployments to AWS.
        * VPC: Running CircleCI this way provides an extra bit of control over the security of the project/deployments.
    * CircleCI provides a vast catalog of orbs, APIs, and web hooks. Allowing for easy integrations of several of our tools, including: Jira, Slack, and Github
* **Job Metrics**

### Bamboo

* **Cost**
    * Pricing tiers are based on agents rather than users. The more agents, the more processes can run concurrently – either steps in the same build, or different builds. Includes an unlimited amount of jobs. Appears to be billed on an annual basis:
        * 1, $1,200
        * 5, $3,200
        * 10, $5,840
        * 25, $11,600
        * 100, $23,280
        * 250, $58,160
        * 500, $87,280
        * 1,000, $133,840
        * 2,000, $187,380
* **ATO of Services**
* **Team Familiarity**
* **Usability of Templates**
    * As far as I can tell Bamboo uses Specs as a form of templating. You can either use [YAML or Java](https://docs.atlassian.com/bamboo-specs-docs/8.0.2/) to write a Spec, which creates the plan(s) for your CI pipeline. It seems it would have a similar issue to vanilla Jenkins, but I can't find as many examples of Specs being used. Bamboo also seems to really want you to use Java to get the full use out of using Specs.
* **Ease of AWS (and other) integrations**
    * It looks as if you could probably integrate Bamboo with AWS by hooking it up through an EC2 instance, it seems to require a server to operate.
    * The real integration benefits of using Bamboo is how it can seamlessly integrate with other [Atlassian applications](https://confluence.atlassian.com/bamboo/integrating-bamboo-with-atlassian-applications-289276942.html).
* **Job Metrics**
    * Bamboo has built-in [reporting](https://confluence.atlassian.com/bamboo/generating-reports-across-multiple-plans-289276964.html) that tracks a variety of metrics. Some of which include:
        * Build activity
        * Build duration
        * Percentage of successful builds
        * Time to fix

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