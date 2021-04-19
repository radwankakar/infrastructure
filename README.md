# infrastructure

A place to begin.

## TODOs

* Determine what should be documented in wiki vs markdown documents in this repository.
* Add basic nix usage
* Add project charter
* Add onboarding checklist
* Add individual systems documentation
* Add update research miro board to be accessible to whole team
* Team expectations
  * sprint structure
  * Documenting common meetings
* Roadmap
* Philosophy
* How to do user research
* Where to host ATO documentation
* Service levels

## How we work

### Working hours

Our team has folks working across different time zones in the continental United States.
We work across Eastern, Central, and Pacific time zones.
Each team member works approximately 9am - 5pm in their home time zone.

The team's overlap time is from **12pm to 5pm eastern** and we will strive to schedule most meetings during this time.

If we need to have a one-off important meeting outside of these hours, that's okay, just be respectful.

Important points:

* Recurring meetings should be scheduled between 12pm - 5pm Eastern.
* Occasional important OHS meetings will be scheduled before Pacific working hours.
* **Scheduled maitenence windows** outside of core working hours occur once a month, every **3rd Thursday of the month at 8pm EST**.
* Critical requests, such as infrastructure outages, should be addressed as soon as possible even if it is outside of core business hours.

### Sprint structure

The Headstart Hosting team works on a two week sprint cadence with the following structure:

* Sprint wrap/planning
* Daily Standups
* Demo
* Retrospective (if necessary)

Our sprints start every other Monday.

TODO: Note the next few sprint starts.

#### __Sprint Planning__

This meeting will occur once a sprint.

We'll keep all tasks associated with work in GitHub Projects.

We'll set aside an hour for sprint planning.
This time will be used to review work from the previous week and review work for the coming week.

In reviewing work for the coming week we will incorporate:

* Feedback from user research sessions
* Feedback from operational issues

A digest of the meeting will be provided to stakeholders as necessary.

Note: The team is encouraged to spend a little time before this meeting to review their work and tie up any loose ends as well as add new stories to the backlog.

#### __Daily Stand-up__

The team's daily sync.

This should be short and sweet with updates on what you're working on and anything that may be blocking you.
We will block a half hour but updates should be quick.
We will use any extra time to work through blocker items.

If you can't make it, please post a slack standup date with the following format:

* What you did yesterday.
* What you are planning to do today.
* Blockers or questions you have.

#### __Demo__

This will occur once per sprint, ideally a couple of business days before sprint end.

Each sprint the team will demo what we've been working on.
This may be a time to present tools and technologies we have been working on or to present plans.
This is an opportunity to solicit feedback.
We will invite all of our stakeholders and customers.

We will record and share the meeting in the case that our customers and stakeholders cannot make it.

#### __Retrospecitves__

A general retrospective should occur once every two sprints.

Blameless incident retrospectves should occur as needed to review and learn from incidents that occur.

TODO: Add more details about retrospectives.

#### __Other weekly meetings__

* HSICC - Hosting team Syncs
  * This meeting happens once a week and is an opportunity to sync up on changes that the teams are working on that week.
* OHS Tech talks
  * This meeting happens once a week. It is an opportunity to share and teach new technologies and techniques with the wider OHS IT organization.


### Definition of Done

TODO: Add here

## Getting Started

Before beginning, it is assumed you have:

1. Added your public key to your GitHub account
2. Cloned this repo locally

For this repository, we'll use the utility [nix](https://nixos.org/manual/nix/stable/) to manage tooling installation.

## Layout

### /docs

__/docs/adr__ this is where we'll be storing architectural decisions records

__/docs/runbooks__ this is where we'll be storing runbooks for operations

### /scripts

This is where we will store existing scripts.

Please note the following for each:

* server(s) and path location
* usage
* purpose

## Goals / Measures of success

Referencing the documented [QASP](https://app.box.com/file/793368311372) define success

[ECLKC Dashboard](https://eclkc.ohs.acf.hhs.gov/internal-use/eclkc-web-communication-standards/eclkc-analytics-dashboard)

## Other document repositories

* [Miro](https://miro.com/app/board/o9J_lL_TCxY=/)
* [Transition documentation Box](https://app.box.com/folder/133328677828)

## Reference Links

* [USER Metrics](https://medium.com/vmwaredesign/user-metrics-fd8e56914321)
* [18F's User Research Plan Documentation](https://ux-guide.18f.gov/research/plan/)
* [Google Cloud: 4 measures of devops performance](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance) TL;DR accelerate metrics
* [Historical Context Trello Board](https://trello.com/b/lPASAkHB/eclkc-web-hosting-agile-team-contract-no-gs00q17gwd2236-order-no-hhsp233201800062w) - You'll need to get access by talking to Eady(?).
