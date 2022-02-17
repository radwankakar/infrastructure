# Definition of Ready

This describes the criteria that marks a ticket as ready to be worked on.

## Criteria

1. There exists an understandable description including background and need and benefit to User
1. Acceptance Criteria
   - Not a restatement of the description
   - Details specific user benefits being delivered
   - Can be tested and how to test is clear
1. Initial Implementation Steps (could be done during grooming, could include multiple options for implementation) - enough to get started on ticket
1. Point Estimate
1. Relation to overall roadmap/epic
1. Assessment of the ability and urgency to automate the work completed during grooming. Tickets requiring automation should have this indicated in their Acceptance Criteria.

# Definition of Done

This describes the criteria that need to be met to consider a ticket complete. This mainly applies only to tickets that have been worked on. It doesn't apply to tickets that can be closed as Duplicate or As Designed, etc.

## Criteria

1. Tests pass and results documented (if applicable)
   - Someone besides person making change or pairing person
   - Documentation of tests (how and results)
1. At least one review on PR(s)
   - Depending on type of reviewer, should include manual review of code change, tests when possible, review of automated tests when applicable
   - Types of reviewers:
     - Subject Matter Expert (SME)
     - Beginner to subject
     - Reviewer that knows enough to look for patterns
1. Documentation when applicable
1. Additional tickets created and linked if need for more work is discovered
1. Automation of a task should be completed (if applicable). If the team decides this is not possible as part of the current ticket, ensure a ticket is created to follow-up on the automation work. This work should be prioritized to be added to the next sprint.
