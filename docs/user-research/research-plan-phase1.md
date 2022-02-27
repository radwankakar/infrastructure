# Research plan - Task 1

This research plan uses the [18F research plan template](https://github.com/18F/ux-guide/blob/master/_pages/resources/research-plan.md).

## Background

The Office of Head Start (OHS) owns and operates a set of IT infrastructure that is being used for multiple purposes, one of which is the system called the Early Childhood Learning Knowledge Center (ECLKC). ECLKC hosts multiple applications, including the ECLKC website as well as some companion apps.

OHS has brought in TRUSS to help them both operate the hosting infrastructure and improve both software and processes as it relates to the hosting infrastructure and related teams.

These are the goals for this project as defined by OHS:

- **1.0**	The management and configuration of cloud hosting tools such as Infrastructure-as-a-Service providers and Platform-as-a-Service providers.
- **2.0**	Design and implementation of DevOps tools and practices such as deployment pipelines and continuous integration.
- **3.0**	Consultation with product teams on infrastructure-related tasks, and with OHS leadership on technical strategies.
- **4.0**	The management and configuration of shared services such as central authentication tools and internal data APIs.

The ECLKC hosting infrastructure is hosted in AWS and serves the following applications/teams:

- ECLKC
- HSICC
- National Centers
  - iPD Learning Management System (includes iLookOut)
  - Coaching Companion
  - Early Educator Central
  - Mobile Applications
    - ELOF 2 Go
    - ELOF 2 Go Spanish
    - ELOF@Home
    - Head Start Talks
    - Ready-DLL
    - Head Start Resources

We believe there are modificiations to technology and practice that can allow for self-service of the application deployments while maintaining ATO.

This is also our pilot to see if we can define practice and standards for technical teams working with OHS outside of the ECLKC infrastructure.

## Goals

The initial phase of our research is both [Foundational and Generative](https://ux-guide.18f.gov/research/clarify-the-basics/#research-types).

Therefore, we have the following goals for this phase:

- Identify and evaluate current processes for development workflows
- Determine developers' painpoints for doing their work
- Determine stakeholders' strategic priorities
- Determine current application needs regarding development and deployment
- Describe what success looks like for the interviewee

## Research questions

These questions we intend to answer via a number of workshops and interviews. They are separated here by the venue in which they will be asked.

### 1. Stakeholder mapping

(complete)

[Stakeholder Mapping Workshop](phase1/stakeholder-mapping.md)

### 2. Tooling Survey

(complete)

[Tooling Survey](phase1/tooling-survey.md)

### 3. Process Download

[Process Download](phase1/process-download.md)

### 4. System Mapping

[System Mapping](phase1/system-mapping.md)

### 5. User Interviews

[User Interviews](phase1/user-interviews.md)

## Method(s)

We have already conducted the [stakeholder mapping excercise](https://miro.com/app/board/o9J_lCdf5Iw=/?moveToWidget=3074457359393677819&cot=14)).

We will be completing a Process download workshop with the HSICC team, the Coaching Companion team, and the iPD team. [An example of that workshop is available](https://miro.com/app/board/o9J_lCdf5Iw=/?moveToWidget=3074457359402237068&cot=14). We'll update this plan with links to the workshops as they are completed.

We will be completing the System Mapping exercise with each of these 3 teams. We'll update this plan with links to the exercises as they are completed.

We will then conduct a series of single-subject user interviews. We will use a subset of the questions detailed above as appropriate to the interviewee.

## Research roles

> **Instructions:** Consider how research can be [a team activity](https://ux-guide.18f.gov/research/clarify-the-basics/#a-team-activity) and decide who will hold specific [research roles](https://ux-guide.18f.gov/research/do/#clarify-team-roles).

- Research lead
- Moderator
- Notetaker(s)
- Observer(s)

Given the size of our team, we'll likely have no observers in favor of keeping someone in a notetaker role.

## Timeline

> **Instructions:** Document the estimated [timeline](https://ux-guide.18f.gov/research/plan/#timeline) for completing this research. Plan more time than you think you need.

| Syntax                                              | Description |
| --------------------------------------------------- | ----------- |
| Study design                                        | 1 week      |
| Recruiting                                          | 3 days      |
| [1. Stakeholder Mapping](stakeholder-mapping.md)    | 2 days      |
| [2. Tooling Survey](tooling-survey.md)              | 4 days      |
| [3. Process Download Sessions](process-download.md) | 2 weeks     |
| [4. System Mapping Sessions](system-mapping.md)     | 2 weeks     |
| User Interview Design                               | 1 week      |
| [5. User Interviews](user-interviews.md)            | 2 weeks     |
| Top-line synthesis                                  | 4 days      |
| Collaborative analysis                              | 3 days      |
| Collaborative synthesis                             | 3 days      |
| Summary/outputs                                     | 3 days      |

## Participants and recruiting

We expect to work closely with members of the HSICC team, Coaching Companion, iPD team. With the last team we'll specifically be focusing on issues around the shared Central Authentication Service (CAS). Alana Buroff, Information Systems and Communications Team lead, completed a stakeholder exercise and identified who we should speak to for the first round. She will be sending the introduction emails to stakeholder/users targeted in this user research plan. We will then follow up with the teams.

## Ethics considerations

With their knowledge and consent, we will be recording all these conversations via Zoom and sharing them with our partners at OHS and 18F.

## Expected outputs and outcomes

### Outputs

At the end of this research round, we should have:

- a stakeholder map,
- multiple process download diagrams,
- basic architecture diagrams, at least the HSICC team,
- user research synthesis,
- list of problems/needs to prioritize in product roadmap including those from the different product teams, and
- a completed bang for your buck exercise to guide the creation of an actual roadmap.

We may also have:

- a deployment ridealong diagram and
- a system attribute prioritization diagram.

### Outcomes

- Hosting team is able to work on prioritized work to address product teams' needs while aligning with project goals
- Hosting team has identified needs for follow up research if any and is able to construct plan
- Hosting team is able to construct research plan for all of OHS hosting needs
