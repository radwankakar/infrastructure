# JIRA as the task management software tool of choice for Hosting team
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: proposed
* Deciders: Eady, Sanjay, Rebecca, and Jerel
* Date: [YYYY-MM-DD when the decision was last updated] <!-- optional -->

Technical Story: https://github.com/OHS-Hosting-Infrastructure/infrastructure/issues/31

## Table of Contents

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers-)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences-)
  * [Negative Consequences](#negative-consequences-)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options-)
  * [GitHub Projects](#github-projects)
  * [Trello](#trello)
  * [ServiceNow](#servicenow)
  * [SmartSheets](#smartsheets)
  * [JIRA](#jira)
* [Links](#links-)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

The TRUSS team as part of the Headstart project needs to use a task management solution that can accommodate several needs. We need to use it for managing our own work, while providing visibility to stakeholders.

## Decision Drivers <!-- optional -->

* Either already has ATO or can get ATO quickly
* Usability for team for planning and development
* Integration with other systems
* Able to provide visibility for stakeholders that aren't part of the hosting team

## Considered Options

* GitHub Projects
* Trello
* ServiceNow
* SmartSheet
* JIRA
* … <!-- numbers of options can vary -->

## Decision Outcome

Chosen option: "JIRA", because it meets all requirements plus is familiar to most, other teams are already using it.

### Positive Consequences <!-- optional -->

* Able to manage our work effectively
* Product teams are able to submit tickets to hosting team and maintain visibility to status and communicate back and forth
* Client stakeholders are able to view progress of project
* Team is able to continually monitor and improve

### Negative Consequences <!-- optional -->

* JIRA can get overly complicated easily so need to be deliberate when configuring
* Price?

## Pros and Cons of the Options <!-- optional -->

### GitHub Projects

[GitHub Projects Documentation](https://docs.github.com/en/issues/organizing-your-work-with-project-boards)

* Good, because it's already in use and has ATO
* Good, because it's part of team's source control system
* Bad, because it is too simple to use effectively

### Trello

[Trello](https://trello.com/home)

* Good, because it's FedRAMP authorized
* Good, because it's simple to use and set up
* Good, because it has Slack integration
* Bad, because it requires lots of add-ons and API integration to meet our requirements
* Bad, because it doesn't have ATO already

### ServiceNow

A platform on which there are different apps providing different workflows.

[ServiceNow](https://www.servicenow.com/)
* [Agile Development](https://www.servicenow.com/products/agile-development.html)
* [DevOps](https://www.servicenow.com/products/devops.html)

* Good, because it's FedRAMP authorized
* Good, because they have Agile workflow as well as DevOps workflows
* Good, because it meets all our requirements
* Bad, because it's a complex product that requires lots of configuration
* Bad, because it doesn't have ATO yet
* … <!-- numbers of pros and cons can vary -->

### SmartSheet

[SmartSheet](https://www.smartsheet.com/)

* Good, because it's FedRAMP authorized
* Good, because it's flexible enough that it can be made to accommodate any workflow we want
* Good, because it meets all our requirements
* Bad, because it requires configuration effort to accommodate our workflow
* Bad, because it doesn't have ATO
* … <!-- numbers of pros and cons can vary -->

### JIRA

Solution made for agile teams. [JIRA](https://www.atlassian.com/software/jira)

* Good, because people know how to use it already
* Good, because it's already being used by other teams so should be easier to integrate with
* Good, because it meets all our requirements
* Bad, because it's not FedRAMP authorized so it will take longer for an ATO
* … <!-- numbers of pros and cons can vary -->

## Links <!-- optional -->