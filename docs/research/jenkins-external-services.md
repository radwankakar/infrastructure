# Jenkins External Services Documentation

## Background

Research on which external services need access to Jenkins is necessary in the process of moving Jenkins behind the VPN. The [design doc](https://github.com/OHS-Hosting-Infrastructure/infrastructure/blob/main/docs/design-docs/moving-jenkins-behind-vpn.md) for this provides additional information.

Three main services that need access to Jenkins will need to be accounted for: Bitbucket, Box, and Github. A brief description of each service and how it interacts with Jenkins is below.

## Bitbucket

Jenkins makes a request to clone / download code from Bitbucket, however certain jobs are also triggered by Bitbucket. In these cases, Bitbucket sends a request via webhook to Jenkins, to trigger a job.

The following job is triggered by Bitbucket (there may be more, but this is the one sent to us by HSICC):

- BitBucket-drupal-composer-project

## Box

There are two similar jobs, one for Development and one for Production, that are triggered when files are added to a specific folder in Box for the HSICC team. Box sends a request via webhook to Jenkins, and this triggers the job.

Jobs that are triggered via Box are listed below:

- Production - Learning Modules Security Check
- Development - Learning Modules Security Check

## Github

At last one job associated with Coaching Companion is triggered when code is pushed to a specific Github repository.

The following job is triggered by Github (there may be more, but this is the one sent to us by CC):

- GitHub-OHSCC
