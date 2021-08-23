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

## Interviewee Selection
1. Must have System Owner and 18F interviewees
2. Must have primary Application Business Owner
3. Must have at least two members of the development teams if possible
4. Must have at least two members of the hosting team

## Interviewee Candidates
1. Alana Buroff (System Owner) - Business - ET
2. Nate Price (18F Consulting Engineer) - Business - CT
3. Townley Knudson (Hendall Project Lead) - Business
4. Scott Weinfeld (HSICC Project Manager) - Business - ET
5. Sam Nevares (ECLKC Lead Dev) - Development Team - ET
6. Bhuvan Neupane (ECLKC QA) - Development Team - ET
7. Raul Rodriguez (ECLKC Drupal Dev) - Development Team
8. Luisa Soaterna (ZTT Director) - Business - ET
9. Priyanka Shukla (iPD Product Manager) - Business
10. Brittany King (iPD Admin) - Business
11. Yakul Bajaj (iPD Developer) - Development Team
12. Ever Giraldo (iPD Developer) - Development Team
13. Craig Corvin (CC Product Manager) - Business - PT
14. Virginia Tse (CC Product Owner) - Business- PT
15. Dayton Allerman (CC Developer) - Development Team - PT 
16. Allyson Dean (ZTT EEC Owner) - Business
17. Dan Gorman (EEC Product Manager) - Business
18. Anna Hoff (ZTT PM) - Business
19. Yashodip Kolhe (Mobisoft) - Development Team
20. Rob Wilkerson (EEC Developer) - Development Team
21. Rebecca Kilberg (Truss Infrasec) - Hosting Team - PT
22. Elizabeth Eady (Truss Team Lead) - Hosting Team - PT
23. Jerel Smith (Truss Infrasec) - Hosting Team - CT

## Schedule
TODO

## Questions per Interviewee
### Overall Business Owner
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
3. Any strategic objectives affecting your project right now that we should be aware of?
4. Can you articulate the problem that you think this project is trying to solve?
5. Can you describe your ideal outcome for this project?
#### Open Ended
6. What keeps you up at night?
7. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
8. Is there anything you wish we asked about?
9. Is there anything we’ve missed?
10. Who else should we speak to?

### Application Business Owner
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
3. Any strategic objectives affecting your project right now that we should be aware of?
4. Can you articulate the problem that you think this project is trying to solve?
5. Who are your primary stakeholders?
#### Collaboration
6. Does your team collaborate with any other team currently?
   * If so, who do you collaborate with and how?
   * If so, what are some of the biggest challenges to effective collaboration?
#### Tools
7. Do you or your team have preferred tools for the following tasks?
   * Communication - Async or sync
8. Are there tools you would hate to use? Why?
9. What do you wish you had in terms of tooling that you don’t currently?
#### Open Ended
10. What’s easy for you about your job?
11. What is the most difficult thing about doing your job well?
   * IF they mention anything about manual work:
      * What’s the most painful manual process for you?
      * Are there repeating manual tasks that bother you as well?
12. What would you be upset about losing if it disappeared tomorrow (that’s job related)?
13. Are there any constraints that aren’t captured in the questions we’ve asked you?  
14. What keeps you up at night?
15. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
16. Is there anything you wish we asked about?
17. Is there anything we’ve missed?
18. Who else should we speak to?

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
10. What is the current cadence of integration tests? 
    * Why is it this cadence?
11. What is your lead time? (What is the average amount of time it takes from the time code is checked into the version control system to the point in time where it is deployed to staging and production?)
#### Security and Observability
12. What is your logging set up?
13. What external services does your app use?
#### Deployment and Process
14. What would a healthy deployment cycle timeline look like, in your point of view?
15. What kind of downtime is acceptable for your service/app?
#### Tools
16. Do you or your team have preferred tools for the following tasks?
   * Continuous integration
   * Cloud Hosting
   * Deployment
   * Communication - Async or sync
   * Authentication
   * Logging
17. Are there tools you would hate to use? Why?
18. What do you wish you had in terms of tooling that you don’t currently?
#### Open Ended
19. What’s easy for you about your job?
20. What is the most difficult thing about doing your job well?
   * IF they mention anything about manual work:
      * What’s the most painful manual process for you?
      * Are there repeating manual tasks that bother you as well?
21. What would you be upset about losing if it disappeared tomorrow (that’s job related)?
22. Are there any constraints that aren’t captured in the questions we’ve asked you?  
23. What keeps you up at night?
24. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
25. Is there anything you wish we asked about?
26. Is there anything we’ve missed?
27. Who else should we speak to?
28. Would you be interested in someone from our team embedding with yours for a few days?

### Hosting Team Member
#### Opening Questions
1. How did you start your workday today?
2. Walk me through your day yesterday.
#### Strategy
3. Can you articulate the problem that you think this project is trying to solve?
4. Can you describe your ideal outcome for this project?
#### Collaboration
5. Does your team collaborate with any other team currently?
   * If so, who do you collaborate with and how?
   * If so, what are some of the biggest challenges to effective collaboration?
6. How do you collaborate with SREs/DevOps/Infrastructure practitioners?
#### Testing
7. What is the current cadence of unit and/or integration tests? 
    * Why is it this cadence?
8. What is your lead time? (What is the average amount of time it takes from the time code is checked into the version control system to the point in time where it is deployed to staging and production?)
#### Security and Observability
9. What is your logging set up?
10. What external services does your system use?
#### Deployment and Process
11. What would a healthy deployment cycle timeline look like, in your point of view?
12. What kind of downtime is acceptable for the hosting infrastructure?
#### Tools
13. Do you or your team have preferred tools for the following tasks?
   * Continuous integration
   * Cloud Hosting
   * Deployment
   * Communication - Async or sync
   * Authentication
   * Logging
14. Are there tools you would hate to use? Why?
15. What do you wish you had in terms of tooling that you don’t currently?
#### Open Ended
16. What’s easy for you about your job?
17. What is the most difficult thing about doing your job well?
   * IF they mention anything about manual work:
      * What’s the most painful manual process for you?
      * Are there repeating manual tasks that bother you as well?
18. What would you be upset about losing if it disappeared tomorrow (that’s job related)?
19. Are there any constraints that aren’t captured in the questions we’ve asked you?  
20. What keeps you up at night?
21. If I had a magic wand and granted you one wish to make your job easier, what would you wish for and why?
22. Is there anything you wish we asked about?
23. Is there anything we’ve missed?
24. Who else should we speak to?

