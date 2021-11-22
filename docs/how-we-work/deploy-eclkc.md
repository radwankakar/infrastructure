# Deploying ECLKC

## Context

One day, all of our deployments will be automated. Until then, they are nasty as heck.
Here's is happening during the ECLKC deploy.

## Development and Staging

Code that is "In Progress" are not yet checked into the develop branch in GitHub.

Code that is "In Review" will have been checked into the develop branch.

Once code is merged to the develop branch, the [Github drupal composer project](https://jenkins.eclkc.info/view/Drupal/job/GitHub-drupal-composer-project/) job is run automatically in Jenkins. Sam says this deploys to the dev env from the develop branch.

Sam syncs the environments and files via Jenkins jobs in order to have the staging env as close to the production env as possible before deploying. First he runs [Drupal Stage File Sync](https://jenkins.eclkc.info/job/Drupal%20Stage%20File%20Sync/), which identifies the files that are different between the nightly SFTP server sync from stage and what is currently in stage.

Sam then restores the production database using [Drupal Production to Stage DB Sync](https://jenkins.eclkc.info/job/Drupal%20Production%20to%20Stage%20DB%20Sync/). There is another job that runs a backup for the production DB that is stored in the SFTP server every night. This job downloads that file and restores the database from production.
