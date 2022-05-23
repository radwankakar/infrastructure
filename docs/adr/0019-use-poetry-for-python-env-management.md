# Use poetry for python virtual environment managment

<!-- Source: https://raw.githubusercontent.com/adr/madr/main/template/adr-template.md -->

- Status: Accepted
- Deciders: Ryan Delaney, Clint Talbert, Reid Lewis
- Date: 2022-05-11

Technical Story: [OHSH-578](https://ocio-jira.acf.hhs.gov/browse/OHSH-578)

<!-- mdformat-toc start --slug=github --no-anchors --maxlevel=6 --minlevel=1 -->

- [Use poetry for python virtual environment managment](#use-poetry-for-python-virtual-environment-managment)
  - [Context and Problem Statement](#context-and-problem-statement)
  - [Decision Drivers](#decision-drivers)
  - [Considered Options](#considered-options)
  - [Decision Outcome](#decision-outcome)
  - [Pros and Cons of the Options](#pros-and-cons-of-the-options)
    - [Don't use virtual environments at all](#dont-use-virtual-environments-at-all)
    - [python's `venv`](#pythons-venv)
    - [pipenv](#pipenv)
    - [flit](#flit)
    - [poetry](#poetry)
  - [Links](#links)

<!-- mdformat-toc end -->

## Context and Problem Statement

In [ADR-0018](./0018-use-python-for-shell-scripting.md) we decided to focus on python
for shell scripting. Python has many strengths that drove that decision, but
virtual environment management in python is not a great user story. We want to settle on
a flow for working with virtual environments that works for us and everyone can follow.

## Decision Drivers

- The tooling itself should be easy to install and keep up-to-date.
- Ensuring a deterministic build process means builds are reproducible across
  environments.
- Some kind of dependency resolution is needed because, while such problems are unlikely,
  they can be very nasty to deal with when they crop up.
- Because we want to minimize the complexity of the stack, it is useful to have a
  single utility that handles everything.
- A graphical interface is not a requirement, but user-friendliness is at least
  nice-to-have to minimize the barrier to entry.

## Considered Options

- Don't use virtual environments at all
- python's native [`venv`][venv] module
- [pipenv](https://pipenv.pypa.io/en/latest/index.html)
- [flit](https://flit.pypa.io/en/latest/rationale.html)
- [poetry](https://python-poetry.org/)

## Decision Outcome

Chosen option: use poetry, because it provides a single command-line utility
that handles virtual environments, dependency resolution, and deterministic build
packaging and publication.

## Pros and Cons of the Options

### Don't use virtual environments at all

We can install arbitrary dependencies to userspace without ever activating
a virtual environment:

```
$ pip3 install --user requests
# OR
$ pip3 install --user -r requirements.txt
```

- Good, because it's the least possible work in the _near_-short-term.
- Bad, because dependency conflicts can't be resolved except by manually uninstalling
  and reinstalling dependencies until a solution is found.
- Bad, because there is no way to guarantee the reproducibility of any build. ("It works
  on my machine!")
- Bad, because over time, which modules were installed as dependencies of other
  dependencies becomes unclear: the userspace inevitably becomes clogged with cruft, and
  we get into dependency conflicts over dependencies that aren't even needed anymore.

### python's `venv`

The python standard library includes a module for initializing virtual environments.

```
# Create a virtual environment:
$ python3 -m venv .venv
# Activate it:
$ source .venv/bin/activate
# Install some dependencies:
$ pip3 install requests
# Quit the virtual environment
$ source .venv/bin/deactivate
```

`venv` doesn't have any way to lock dependencies, so we have to
rely on pip to get reproducible builds:

```
# Lock the dependencies and add to source control:
$ pip3 freeze > requirements.txt
$ git add requirements.txt && git commit -m "Add requirements.txt"
# Quit the virtual environment
$ source .venv/bin/deactivate
```

Now, after someone else clones the project, they would do this
to install the dependencies:

```
# Clone a repository and cd into it
$ git clone url://to/myproject.git && cd myproject
# Create a virtual environment:
$ python3 -m venv .venv
# Activate it:
$ source .venv/bin/activate
# Install the project dependencies:
$ pip3 install -r requirements.txt
```

- Good, because it's in the python standard library, so no additional tools have
  to be installed.
- Good, because it is relatively lower-level: the other options we considered
  wrap around this module when doing virtual env management anyway.
- Bad, because `venv` doesn't provide any dependency resolution, so
  manual labor is needed to lock dependencies in `requirements.txt` -- and it's still
  easy for an engineer to get stuck fumbling with it for a long time before realizing
  they are in dependency hell (e.g. if two dependecies require the same sub-dependency,
  but with conflicting version requirements for the sub-dependency.)
- Bad, because it doesn't support build packaging, which means distribution (especially
  for cli apps) requires an additional, separate workflow that hasn't been explored
  here (such as [setuptools](setuptools)). The separate build process has its own dependency list
  that must be kept in sync manually as well.

### pipenv

pipenv is a third-party shell utility that assists with development environment setup
and dependency locking, enabling deterministic builds.

```
# Install pipenv
$ brew install pipenv
# Install some dependencies for a project
$ cd myproject && pipenv install requests
# Commit the lock-file that pipenv automatically created
$ git add Pipfile && git add Pipfile.lock && git commit -m "Add pipenv configuration"
```

Now, the next engineer can activate the environment like this:

```
# Clone a repository and cd into it
$ git clone url://to/myproject.git && cd myproject
# Start a new shell with the virtual environment and dependencies installed
$ pipenv shell
# Exit the virtual environment
$ exit
```

- Good, because Truss have used pipenv on other python projects.
- Good, because it automates dependency locking: no `requirements.txt` management.
- Good, because it understands the difference between runtime vs dev dependencies.
- Bad, because it doesn't support build packaging and distribution.
- Bad, because it uses its [own format][pipfile] for configuration that is still unstable after 6+
  years of active development. This configuration is specific to pipenv and doesn't
  integrate with other addons for python projects.

### flit

`flit` focuses on simplifying the build and distribution process in python, and
does a great job. However, it does not tackle the virtual environment management
that we need to enable best practices during development.

```
# Install flit
$ brew install flit
# Set up a new project
$ mkdir -p myproject && cd myproject && flit init
# Build a distribution as a stand-alone module
$ flit build
# Publish the build to pypi or another repository
$ flit publish
```

- Good, because user-friendliness is a high priority. It is arguably the easiest
  of the tools considered.
- Good, because it understands the difference between runtime vs dev dependencies.
- Good, because it supports build packaging and even publishing to [pypi](https://pypi.org).
- Good, because all configuration is stored in the PEP-approved [`pyproject.toml`][pyproject.toml] file.
- Bad, because it doesn't provide its own support for lock files.
- Bad, because it doesn't manage virtual environments.
- Bad, because it has no dependency resolution logic.
- Bad, because Truss have not used flit before.

### poetry

`poetry` is the holy marriage of pipenv, setuptools, and twine. It is a one-stop shop for python
app development.

```
# Install poetry
$ brew install poetry
# Set up a new project
$ mkdir -p myproject && cd myproject && poetry init
# [follow the interactive prompts]
# Add a runtime dependency you forgot about
$ poetry add requests
# Add a dev dependency you forgot about
$ poetry add --dev flake8
# Remove a dependency that isn't needed anymore
$ poetry remove requests
# Start a new shell with the virtual environment and dependencies
$ poetry shell
# Update the dependencies in the lock file
$ poetry update
# Commit the configuration to source control
$ git add pyproject.toml poetry.lock && git commit -m "Add project configuration"
# Build a distribution as a stand-alone module
$ poetry build
# Publish the build to pypi or another repository
$ poetry publish
# Quit the virtual environment
$ exit
```

- Good, because Truss have used poetry on other python projects.
- Good, because user-friendliness is a high priority. For instance, poetry provides an interactive wizard
  for initializing a new project.
- Good, because the local virtual environment is maintained implicitly.
- Good, because it automates dependency locking: no extra work maintaining `requirements.txt`.
- Good, because it supports build packaging from the same dependency list.
- Good, because it automatically resolves dependencies; if a solution exists,
  poetry will find it. If there is no solution, a useful error explaining why is provided.
- Good, because it also supports build packaging and even publishing to [pypi](https://pypi.org).
- Good, because all configuration is stored in the PEP-approved [`pyproject.toml`][pyproject.toml] file.

## Links

- [ADR-0018 Use python for shell scripting](./0018-use-python-for-shell-scripting.md)
- [PEP 405 - Python Virtual Environments](https://peps.python.org/pep-0405/)

[pipfile]: https://github.com/pypa/pipfile
[pyproject.toml]: https://pip.pypa.io/en/stable/reference/build-system/pyproject-toml/
[venv]: https://docs.python.org/3/library/venv.html
