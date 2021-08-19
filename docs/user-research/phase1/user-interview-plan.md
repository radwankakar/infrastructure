# User Interview Plan

## Background
We would like to transform the hosting infrastructure on which several OHS applications reside to use cloud principles and devops practices so that:
* applications on the system can be developed, deployed, and maintained with minimal involvement from the hosting team
* system provides security and management so that application data is secure and the system maintains 99%/month uptime

With that objective in mind, we would like to understand different stakeholders' needs and priorities of those needs to inform our plan to achieve that objective.

## Interviewee Categories
1. Overall Business Stakeholders
2. Application Business Stakeholders
3. Application Development Teams
4. Hosting Team
5. End User (possible?)

## Interviewees
1. Alana Buroff (System Owner) - Business
2. Nate Price (18F Consulting Engineer) - Business
3. Townley Knudson (Hendall Project Lead) - Business
4. Scott Weinfeld (HSICC Project Manager) - Business
5. Sam Nevares (ECLKC Lead Dev) - Development Team
6. Bhuvan Neupane (ECLKC QA) - Development Team
7. Raul Rodriguez (ECLKC Drupal Dev) - Development Team
8. Luisa Soaterna (ZTT Director) - Business
9. Priyanka Shukla (iPD Product Manager) - Business
10. Brittany King (iPD Admin) - Business
11. Yakul Bajaj (iPD Developer) - Development Team
12. Ever Giraldo (iPD Developer) - Development Team
13. Craig Corvin (CC Product Manager) - Business
14. Virginia Tse (CC Product Owner) - Business
15. Dayton Allerman (CC Developer) - Development Team 
16. Allyson Dean (ZTT EEC Owner) - Business
17. Dan Gorman (EEC Product Manager) - Business
18. Anna Hoff (ZTT PM) - Business
19. Yashodip Kolhe (Mobisoft) - Development Team
20. Rob Wilkerson (EEC Developer) - Development Team
21. Rebecca Kilberg (Truss Infrasec) - Hosting Team
22. Elizabeth Eady (Truss Team Lead) - Hosting Team
23. Jerel Smith (Truss Infrasec) - Hosting Team

## Questions per Interviewee
### Overall Business Owner
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
4. Any strategic objectives affecting your project right now that we should be aware of?
5. Can you articulate the problem that you think this project is trying to solve?
#### Open Ended
7. What keeps you up at night?
8. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
9. Is there anything you wish we asked about?
10. Is there anything we’ve missed?
11. Who else should we speak to?

### Application Business Owner
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
3. Any strategic objectives affecting your project right now that we should be aware of?
4. Can you articulate the problem that you think this project is trying to solve?
#### Collaboration
5. Does your team collaborate with any other team currently?
   * If so, who do you collaborate with and how?
   * If so, what are some of the biggest challenges to effective collaboration?
#### Tools
6. Do you or your team have preferred tools for the following tasks?
   * Communication - Async or sync
7. Are there tools you would hate to use? Why?
8. What do you wish you had in terms of tooling that you don’t currently?
#### Open Ended
9. What’s easy for you about your job?
10. What is the most difficult thing about doing your job well?
   * IF they mention anything about manual work:
      * What’s the most painful manual process for you?
      * Are there repeating manual tasks that bother you as well?
11. What would you be upset about losing if it disappeared tomorrow (that’s job related)?
12. Are there any constraints that aren’t captured in the questions we’ve asked you?  
13. What keeps you up at night?
14. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
15. Is there anything you wish we asked about?
16. Is there anything we’ve missed?
17. Who else should we speak to?

### Application Team Member
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
3. Any strategic objectives affecting your project right now that we should be aware of?
4. Can you articulate the problem that you think this project is trying to solve?
#### Collaboration
5. Does your team collaborate with any other team currently?
   * If so, who do you collaborate with and how?
   * If so, what are some of the biggest challenges to effective collaboration?
6. How do you collaborate with SREs/DevOps/Infrastructure practitioners?
#### Data
7. What kinds of data do you store?
   * Follow up: Is any of this data media content submitted by end users?
8. What user data do you manage, if any?
   * Is any of this data is PII?
9 How much standardization is there with user submitted data?
   * What happens if you lose data? Do you know when you have inconsistent data?
#### Testing
1. What is the current cadence of integration tests? 
    * Why is it this cadence?
1. What is your lead time? (What is the average amount of time it takes from the time code is checked into the version control system to the point in time where it is deployed to staging and production?)
#### Security and Observability
1. What is your logging set up?
1. What external services does your app use?
#### Deployment and Process
1. What would a healthy deployment cycle timeline look like, in your point of view?
1. What kind of downtime is acceptable for your service/app?
#### Tools
6. Do you or your team have preferred tools for the following tasks?
   * Continuous integration
   * Cloud Hosting
   * Deployment
   * Communication - Async or sync
   * Authentication
   * Logging
7. Are there tools you would hate to use? Why?
8. What do you wish you had in terms of tooling that you don’t currently?
#### Open Ended
9. What’s easy for you about your job?
10. What is the most difficult thing about doing your job well?
   * IF they mention anything about manual work:
      * What’s the most painful manual process for you?
      * Are there repeating manual tasks that bother you as well?
11. What would you be upset about losing if it disappeared tomorrow (that’s job related)?
12. Are there any constraints that aren’t captured in the questions we’ve asked you?  
13. What keeps you up at night?
14. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
15. Is there anything you wish we asked about?
16. Is there anything we’ve missed?
17. Who else should we speak to?
18. Would you be interested in someone from our team embedding with yours for a few days?

### Hosting Team Member
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
3. Can you articulate the problem that you think this project is trying to solve?
#### Collaboration
4. Does your team collaborate with any other team currently?
   * If so, who do you collaborate with and how?
   * If so, what are some of the biggest challenges to effective collaboration?
6. How do you collaborate with SREs/DevOps/Infrastructure practitioners?
#### TODO

