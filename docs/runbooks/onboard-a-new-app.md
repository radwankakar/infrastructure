# How to onboard a new application

Last updated by Eady on April 22, 2021


__Note:__ This is the proposed workflow with questions to help facilitate onboarding and expectations setting.

## Onboarding todos

1. Sync with dev team to learn about their system.
   * What is their system like?
   * How does the team do work?
   * How does the team validate quality?
   * Who are our points of contact?
   * Will adding this application affect our security and compliance posture, security categorization, or ATO?
1. Sync with dev team to show what the hosting team provides.
   * Common operations and schedules
   * how to contact us
   * What services we provide
   * schedule follow up sessions for tutorials/pairing
1. Document system configuration, architecture, data and access policies.
    * ATO related documentation
    * Provide an Outline of hosting team responsibilities vs dev team responsibilities
1. Provide dev team access to:
    * Hosting team github org and backlog
    * Hosting team process documentation (includes contact information for team)
    * documentation of system information we have on file
    * access to infrastructure tooling or dev/staging accounts
1. Work with dev team to deploy to dev -> staging -> prod.

## Questions to ask during onboarding

These are in draft format, these will be cleaned up later.

### About the application

What does your application do?

Who are your users and what do they use it for?

What information do you collect and store about your users? Does your application require PII?

Do you have any kind of helpdesk or emails that may come from users and be stored?

Does your application store any user submitted information/media?

What sort of logging do you use?

Does your application require use of a database?

Does your application need authentication?

### About the developer experience

What is your current development workflow?

What is the development team's experience with CI tools? (like the ones we provide)

What is the development team's experience with logging and monitoring tools?
