# Use Terracognita to turn existing AWS Infrastructure into Terraform code
<!-- Source: https://raw.githubusercontent.com/adr/madr/master/template/template.md -->

* Status: proposed
* Deciders: @eeeady
* Date: 2021-05-17

Technical Story: <https://github.com/OHS-Hosting-Infrastructure/environment-configuration/issues/3>

<!-- toc -->

* [Context and Problem Statement](#context-and-problem-statement)
* [Decision Drivers](#decision-drivers-)
* [Considered Options](#considered-options)
* [Decision Outcome](#decision-outcome)
  * [Positive Consequences](#positive-consequences-)
  * [Negative Consequences](#negative-consequences-)
* [Pros and Cons of the Options](#pros-and-cons-of-the-options-)
  * [[option 1]](#option-1)
  * [[option 2]](#option-2)
  * [[option 3]](#option-3)
* [Links](#links-)

<!-- Regenerate with "pre-commit run -a markdown-toc" -->

<!-- tocstop -->

## Context and Problem Statement

Taking existing AWS infrastructure and putting it under management of Terraform, as is, can be an incredibly tedious task. As it requires the engineer to go through each resource and translate its existing settings in the AWS console into pieces of interconnected Terraform. The toil of such a task only increasing as the complexity and size of the aforementioned existing infrastructure increases. Taking time away from other tasks and leaving room for unnecessary errors.

## Decision Drivers

* Reducing the toil of creating new Terraform based on existing AWS infrastructure.
* Cut down on errors inherent in the process of translation.
* Cut down on time spent placing existing AWS infrastructure under Terraform management.

## Considered Options

* Have a tool/service, in this case Terracognita, read existing AWS resources and create Terraform that reflects said resources.
* Continue to do such things by hand.

## Decision Outcome

Chosen option: Use Terracognita to create as much pre-written Terraform as it can on any given project. Editing and rearranging the output as is needed.

### Positive Consequences

* Dramatically reduces the amount of time spent transferring every resource by hand.
* Reduces the number of mistakes/typos made during the move.

### Negative Consequences

* Less time spent writing the Terraform code could lead to less of a grasp on what's happening under the hood.
* Depending on the project not every resource will be grabbed by/accessible to Terracognitta. Leading to gaps.
* Terracognita creates its own randomly generated names for resources, requiring the need to rename the imported resources and references to them by hand.


## Links

* [Terracognita Repo/Docs] <https://github.com/cycloidio/terracognita>
