# iPD Stakeholder Testing

## Background

We would like to understand the current stakeholder testing process so that we can use that to inform our recommendations for best practice testing processes as well as adjust any access policies needed.

## Topics

1. Who tests
1. When do they test
1. How do they test
1. How do they record/report their results
1. Where do they test
1. What do they test
1. Why do they test

## Session

- Occurred on 10/21/2021 at 10AM ET over Zoom
- [Recording](https://drive.google.com/drive/folders/1Vw8Zo83OwKWS_l4qhFK56sSnbgMDMf5P?usp=sharing)
- [Notes](https://docs.google.com/document/d/1Do2-kp71xNE4ALPoMQU7O1mRB39xoBdqWDbFcDT1DAU/edit?usp=sharing)

## Topic Observations

1. Brittany King, the main administrator of iPD, is the one that does any type of stakeholder testing, i.e. acceptance of a change. However, she usually does it on a call together with Priyanka and Ever, the Paradiso PM and Dev.
1. Brittany tests prior to deployment to production. However, this testing is not scheduled and so it sometimes happens at different times during the development cycle. In the case of our observed session, it happened on the same day as a scheduled maintenance where the change was intended to be deployed. However, the usual process is that Brittany has a sync up with Priyanka and Ever every Tuesday where they show her the implementation of changes and she reviews and tests along with them.
1. She tests on a call with Priyanka and Ever.
1. They don't record their results anywhere, but just select whether a change goes on the change notice or not based on the results.
1. She tests on staging environment.
1. She tests based on what's supposed to go in the next maintenance window and mainly does success path testing.
1. She tests to make sure that the change meets her requirements.

## Possible Areas of Improvement

- In at least the session that we observed, there seemed to be a disconnect between what Brittany wanted and the implementation that was done. This may be a result of lack of clarity in the original ask and/or lack of collaboration during the design and implementation process. Training around writing user stories may be a worthwhile offering to address this concern.
- The fact that this testing took place the morning before the release gave no time to adjust implementation yet still keep in the release. While this may not be the norm, it's still worth including cadence of testing in our recommendations
