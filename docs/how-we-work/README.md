# How we work

Any manual changes should be logged in the [manual operations plan](./manual-ops-log.md).

## Working hours

Our team has folks working across different time zones in the continental United States.
We work across Eastern, Central, and Pacific time zones.
Each team member works approximately 9am - 5pm in their home time zone.

The team's overlap time is from **12pm to 5pm eastern** and we will strive to schedule most meetings during this time.

If we need to have a one-off important meeting outside of these hours, that's okay, just be respectful.

Important points:

- Recurring meetings should be scheduled between 12pm - 5pm Eastern.
- Occasional important OHS meetings will be scheduled before Pacific working hours.
- **Scheduled maitenence windows** outside of core working hours occur once a month, every **3rd Thursday of the month at 8pm EST**.
- Critical requests, such as infrastructure outages, should be addressed as soon as possible even if it is outside of core business hours.

## Conventions

- Use labels to identify type of ticket
  - Bug: defect that needs to be fixed
  - Task: change that delivers value to client (i.e. application team or end user)
  - Chore: change that delivers value to team, but not a direct value to client (i.e. lets team work better or easier)
- Use additional labels for categorization
  - Documentation: when a ticket is only for documentation
  - Maintenance: when a ticket is to manage a maintenance window
  - etc.
- Ticket estimation:
  - Items are estimated using Fibonnaci points of 1, 2, 3, and 5
    - If any item is estimated as 5, needs to be broken down
    - 1: Well-understood and can be completed without requiring interaction between teams in less than 1-2 work hours
    - 2: Well-understood and can be completed with little to no interaction between teams within half a day of concentrated work
    - 3: Some ambiguity or well understood but requires interaction with other teams that may delay completion, likely would take 1 full work day
  - Point estimates are put in parenthesis at end of ticket title
  - All team members vote on points, whether or not they're in a technical role
- Epics or high level initiative name is put in square brackets at beginning of ticket title
- Tickets that are blocked by other tickets are identified in description with link to blocking ticket
- Bugs are not estimated nor are maintenance window items

## Sprint structure

The Headstart Hosting team works on a one week sprint cadence with the following structure:

- Sprint wrap/planning
- Sprint grooming
- Daily Standups
- Demo
- Retrospective

Our sprints start every Tuesday after Sprint Planning.

TODO: Note the next few sprint starts.

## Meetings

### __Sprint Grooming__

This meeting will occur once a sprint.

We will groom tickets in the backlog to make sure they are ready to review for sprint planning.

Grooming activities include:

- Adjusting placement of tickets in backlog based on priority
- Ticket clarification ensuring that Acceptance Criteria is clear
- Estimation of tickets and splitting of tickets if needed

### __Sprint Planning__

This meeting will occur once a sprint.

We'll keep all tasks associated with work in GitHub Projects.

We'll set aside an hour for sprint planning.
This time will be used to review work from the previous week and review work for the coming week.

In reviewing work for the coming week we will incorporate:

- Feedback from user research sessions
- Feedback from operational issues
- Deadlines for compliance requirements
- Requests from application teams

A digest of the meeting will be provided to stakeholders as necessary.

Note: The team is encouraged to spend a little time before this meeting to review their work and tie up any loose ends as well as add new stories to the backlog.

### __Daily Stand-up__

The team's daily sync.

This should be short and sweet with updates on what you're working on and anything that may be blocking you.
We will block a half hour but updates should be quick.
We will use any extra time to work through blocker items.

If you can't make it, please post a slack standup date with the following format:

- What you did yesterday.
- What you are planning to do today.
- Blockers or questions you have.

### __Demo__

This will occur once per sprint, ideally a couple of business days before sprint end.

Each sprint the team will demo what we've been working on.
This may be a time to present tools and technologies we have been working on or to present plans.
This is an opportunity to solicit feedback.
We will invite all of our stakeholders and customers.

We will record and share the meeting in the case that our customers and stakeholders cannot make it.

### __Retrospecitves__

A general retrospective should occur once every two sprints.

Blameless incident retrospectves should occur as needed to review and learn from incidents that occur.

TODO: Add more details about retrospectives.

### __Other weekly meetings__

- HSICC - Hosting team Syncs
  - This meeting happens once a week and is an opportunity to sync up on changes that the teams are working on that week.
- OHS Tech talks
  - This meeting happens once a week. It is an opportunity to share and teach new technologies and techniques with the wider OHS IT organization.

## Definition of Ready

TODO: Add here

## Definition of Done

- All Acceptance Criteria is met
- Reviewed at all stages
  - Person doing work
  - Person reviewing code changes - prior to merge
  - Person accepting - after merge and being applied
    - Internal - Sanjay default acceptor and can pair with other team members to learn how or reach out to external stakeholders to get acceptance if needed
- Relevant documentation is updated, whether it’s new or existing
- External communication done if needed
