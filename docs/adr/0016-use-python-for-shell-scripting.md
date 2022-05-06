# Use python for shell scripting

<!-- Source: https://raw.githubusercontent.com/adr/madr/main/template/adr-template.md -->

- Status: proposed
- Deciders: Ryan Delaney, TBD
- Date: 2022-05-05

Technical Story: [OHSH-578](https://ocio-jira.acf.hhs.gov/browse/OHSH-578)

## Table of Contents

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Use python for shell scripting](#use-python-for-shell-scripting)
  - [Table of Contents](#table-of-contents)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Use bash](#use-bash)
    - [Use python](#use-python)

<!-- mdformat-toc end -->

## Context and Problem Statement

As we build out more solutions for OHS, we will need to develop some bespoke
command-line scripts and tools. However, we also want to avoid committing to
maintaining code in many different languages and frameworks. So, we want to pick
a language to focus on going forward.

## Decision Drivers

- The chosen language should have an interpreter that can be distributed
  to, or is already on, the environments we typically work in.
- We want a maintainable language with good support for error handling, testing,
  self-documenting code, and consistent behavior across deployments.
- Engineers on the team should have some familiarity with the language, or
  it should be easy to come up to speed on it, or both.

## Considered Options

- bash
- python

## Decision Outcome

Chosen option: Use python, because it has features that support developer productivity
writing maintainable code, we have some familiarity with it, and it is beginner friendly.
If we need to run python code on remote Linux hosts, the python 3 interpreter is pre-
installed on many distributions (such as Ubuntu).

## Pros and Cons of the Options

### Use bash

- Good, because it's already installed everywhere we might want to run shell code.
- Good, because there aren't any complex frameworks or environments to manage.
- Good, because most engineers will have at least some familiarity with it.
- Bad, because bash has many [pitfalls][bash pitfalls].
- Bad, because it lacks error handling and robust testing frameworks, features we
  want to have available to make new code more maintainable.

### Use python

- Good, because some of us are more comfortable with python already, and it has a reputation
  for being relatively easy for beginners to spin up on.
- Good, because it has excellent error handling built-in to the language.
- Good, because the open source ecosystem provides mature, feature-rich and widely used testing frameworks.
- Bad, because python has a poor user story around virtual environment and dependency
  management. Mitigating that will require us to standardize on some additional command-line
  tooling.

[bash pitfalls]: https://mywiki.wooledge.org/BashPitfalls
