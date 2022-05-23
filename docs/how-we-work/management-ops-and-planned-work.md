# Balancing Both Ops and New Implementation Work

## Background

The OHS Hosting team has multiple workstreams, including providing support to existing apps and architecture, regular maintenance, and planned work to ensure security, reliability, and addressing tech debt.

Given our availability constraints as of April 25, 2022, we have determined the need to create a system that will enable us to more accurately forecast and allocate work to team members. Currently, our sprints are constantly interrupted by firefighting and app needs, which make it difficult for us to complete our commitments in a timely manner.

This document addresses the steps we will take to balance our commitments to operations and planned implementation work geared towards shoring up and improving our systems.

## Process

We have established that we will proceed with a system of rotation to identify who would be responsible for operations and maintenance focused work every two sprints.

This is similar to the on-call rotation we are currently using.

Operating on a bi-sprint basis allows minimal context switching for developers.

### Scope
The person who is on-call for the two-sprint cycle will handle the following work:

- Unplanned (prior to sprint) critical security vulnerability remediations
- Planned security vulnerability remediations
- Qualys scan reviews (once all parties have access--as of May 23, 2022 folks without access are doing this)
- Outages
- Managing AWS resource actions like instance reboots or retirement
- Critical app requests that do not belong to an epic

### Example

- Sprint 1 & 2: Person A
- Sprint 3 & 4: Person B
- Sprint 5 & 6: Person C
- Sprint 7 & 8: Person A

If, for whatever reason, someone is unable to fulfill their commitments (to include reasons such as PTO, Sick leave, etc.) then this would need to be communicated as soon as possible to the Tech Lead and Delivery Manager so that they can adjust accordingly.
