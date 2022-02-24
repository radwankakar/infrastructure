# Head Start Devs discussion guide

## Introduction

```
Hi. Thank you for your time today. [My name is [name]  and I’m a [position] on the Head Start Hosting and Infrastructure project. I want to make sure I’m pronouncing your name correctly, Is it ________? Thank you!]

I’d like to give you a little bit of background on what we’re doing today…

Truss is here to help the office of headstart move into a more devops way of working. So we are spending some time understanding their current way of working to help inform what that new world might look like.

With that in mind, I’d like to spend the next roughly 60 minutes learning your role, your workflow, what works well, what is challenging etc. This will give our team the foundational understanding before we start suggesting improvements or designing.

In our chat today, I’d love for you to speak openly and honestly with us. There are no right or wrong answers. We are interested in your specific perspective and experiences.

Are we okay to record this session for our internal team? This will let us focus on listening to you instead of trying to take a lot of notes. Is that okay? If you would like to say something off the record, please let us know and we will stop the recording and / or make a note of it so that off the record information does not get shared publicly. Also, if there are any questions you do not know or cannot answer, that is perfectly fine, just let us know.

```

**\[Record\]**

**\[If they say no\]** Since you do not feel comfortable being recorded, can we please take notes during this session so that we have a log of our conversation?

```
Do you have any questions before we begin?
```

## Goals

- Understand what, why, and type of system access developers need to best develop, deploy, and maintain their applications on our system
  - Identify their current painpoints
- Describe the current development and deployment process for their applications
  - Identify their current painpoints especially once code is written. E.g. testing, deploying, tools involved etc.

## Research Questions

- What is the current development and deployment process for various teams?
- Why is the current process the way it is? What goals do they support? Why is the most feasible solution?
- What parts of it are challenging?
- What is their current process for testing?
- What would the ideal process look like?
- What would a good developer environment look like?
- What parts of their own system don’t developers know about?

## Questions

### Your role

- Could you tell me a bit about your role on the team?
- What are your primary responsibilities?

### Current development and deployment experience

We’d like to talk to you about how you and your team currently develop and deploy software. We’d specifically like to focus from the moment something is ready to be merged all the way to the end.

To start, I’d like to recap our understanding of your current process (starting at the feature implementation part).
https://miro.com/app/board/o9J_lCdf5Iw=/
Summarise the steps involved based on the team

_As a note:
You may hear mention of legacy choices! In that case, politely move on to the next question._

### First/Dev environment

- Where does code go once it’s been written?
- Who has access to this environment?
- How do you create a new dev environment?
  - How long does it take?
  - How have you ensured consistency of dev environments?
  - Is there a reason why dev environments are used the way they are?
- Aside from bugs and failed tests, what other reasons have stopped code from moving onto the next step in your process?
  _Probe for external blockers, non-technical reasons, process gap e.g. admin approving_
- \[if not mentioned\] Do you do any testing in this environment?
- \[if not mentioned, replay their testing at this step\] Is there a reason you do these things in this step?
  _Probe for difference in philosophy and why it is the way it is_
  - How do you build up confidence in your code before proceeding to the next step?
    - Possible follow ups:
    - How do you test?
    - What systems do you access for testing?
    - Could you tell us about a recent time when you had challenges in testing?
    - What other challenges have you faced when testing?
- Have you had any other challenges when using this environment?
- What are your thoughts if testing was automated in this environment?
  - How would you feel about that?
- Is there anything else that happens in this step?
- What happens next?
  - How is code deployed to the next step?
    - Is it manual or automated?

### Staging environment

- Who has access to this environment?
- What do you do here once code is merged into this environment?
- Aside from bugs and failed tests, what other reasons have stopped code from moving onto the next step in your process?
  _Probe for external blockers, non-technical reasons, process gap e.g. admin approving_
- \[if not mentioned\] Do you do any testing in this environment?
- \[if not mentioned, replay their testing at this step\] Is there a reason you do these things in this step?
  _Probe for difference in philosophy and why it is the way it is_
  - How do you build up confidence in your code before proceeding to the next step?
    - Possible follow ups:
    - How do you test?
    - What systems do you access for testing?
    - Could you tell us about a recent time when you had challenges in testing?
    - What other challenges have you faced when testing?
- Have you had any other challenges when using this environment?
- What are your thoughts if testing was automated in this environment?
  - How would you feel about that?
- Is there anything else that happens in this step?
- What happens next?
  - How is code deployed to the next step?
    - Is it manual or automated?

### Release to prod

- How does staging compare to prod?
- What do you do here once code is merged into this environment?
- During the maintenance window, what do you look for once code is merged into production? Why?
- Could you tell me about the worst time a release didn’t go as planned?
  - Why didn’t the release go as planned?
- What other challenges in the past have you faced when releasing to prod?
- Who has access to this environment?

### Wrap up

- Why is your testing strategy set up the way it is? What’s the reason behind the different types of testing in the different steps?
  - Is there a reason you don’t test more rigorously in dev?
- If you had to describe your ideal process, what would that be?
  - \[play it by ear\] Is there anything blocking your team from doing this?
- What would make it easier for you to do your job?
- Is there anything else you think we’ve missed?
- Do you have any questions for us?
