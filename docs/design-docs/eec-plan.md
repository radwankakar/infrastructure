# Deployment Plan for EEC

Contributors: Clint Talbert
Proposal Date: 5/23/2022
Feedback Accepted Until: 6/1/2022

## Overview

EEC is a project that is restarting. The team is furthest along (among the other teams) in terms of containerizing their application. There is already a containerized version of the application running in dev. This plan will outline the steps required to make this a useful development environment that is a production mirror and will allow us to move into production smoothly.

## Architecture

It's very standard. There's an ALB which allows connection to the application running as a docker container on Fargate. The application in turn references a RDS instance as its backing store. All of this is defined in [this Terraform PR](https://github.com/OHS-Hosting-Infrastructure/environment-configuration/pull/123/files).

### Development Flow

1. Developer would be granted access to the eec/dev ECR repository
1. Developer would use `docker push` to push their image to the ECR dev repo. [AWS has instructions for this](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)
1. Once a new image is pushed, ECR is configured to scan it automatically.
1. Upon a successful scan, fargate will automatically update the service to use the new image in dev.

### Production Flow

1. A Jenkins job is created that runs the automated tests against EEC dev
1. When those tests pass and/or on a specific schedule, a Jenkins job can run that pushes scanned, passing docker containers into the eec/prod ECR repo.
1. The production instance of EEC (also running on fargate) will update the service automatically when a new image is pushed.

## Plan Steps

1. Create ECR dev repo [PR 123](https://github.com/OHS-Hosting-Infrastructure/environment-configuration/pull/123/files)
1. Grant developers access to push to the dev repo (eec/dev)
1. Refactor code in PR 123 to use the same modules, but make the environment a configurable input variable (i.e. prod vs dev)
1. Create ECR prod repo (eec/prod)
1. Deploy terraform to create prod configuration
1. Test end to end workflow

## Jira Tickets

1. [OHSH-196](https://ocio-jira.acf.hhs.gov/browse/OHSH-196) - Complete EEC Environment (Route 53 etc)
1. [OHSH-610](https://ocio-jira.acf.hhs.gov/browse/OHSH-610) - Grant VPN access to EEC developers
1. [OHSH-633](https://ocio-jira.acf.hhs.gov/browse/OHSH-633) - Grant ECR access to eec/dev repo for EEC developers
1. [OHSH-612](https://ocio-jira.acf.hhs.gov/browse/OHSH-612) - Jenkins Job to promote from Dev to Prod
1. [OHSH-611](https://ocio-jira.acf.hhs.gov/browse/OHSH-611) - EEC Developers access to Jenkins job for promotion
1. [OHSH-634](https://ocio-jira.acf.hhs.gov/browse/OHSH-634) - Refactor EEC code to be environment agnostic
1. [OHSH-635](https://ocio-jira.acf.hhs.gov/browse/OHSH-635) - Test end to end development - production flow jointly with developers
